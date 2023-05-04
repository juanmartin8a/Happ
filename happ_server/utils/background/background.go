package background

import (
	"context"
	"happ/utils"
	"happ/utils/notifications"
	"log"
	"strconv"
	"time"

	"golang.org/x/sync/semaphore"
)

func DeleteOrphanedEventUsers() {
	const maxBatches = 10
	const batchSize = 100
	const pauseDuration = time.Second * 2

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	for {
		batchesProcessed := 0
		hasOrphans := true
		for hasOrphans {
			batchesProcessed++
			res, err := utils.Client.DB().ExecContext(ctx, `
				DELETE eu
				FROM event_users AS eu
				INNER JOIN (
					SELECT event_id, user_id
					FROM event_users AS eu2
					LEFT JOIN events AS e ON eu2.event_id = e.id
					WHERE e.id IS NULL
					LIMIT `+strconv.Itoa(batchSize)+`
				) AS dt ON eu.event_id = dt.event_id AND eu.user_id = dt.user_id;
			`)

			if err != nil {
				log.Printf("Error deleting orphaned event_user rows: %v", err)
			}

			affectedRows, _ := res.RowsAffected()

			if affectedRows == 0 || batchesProcessed >= maxBatches {
				hasOrphans = false
			} else {
				time.Sleep(pauseDuration)
			}
		}
		time.Sleep(time.Hour * 1)
	}
}

func DeleteOrphanedEventReminderNotifications() {
	const maxBatches = 10
	const batchSize = 100
	const pauseDuration = time.Second * 2

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	for {
		batchesProcessed := 0
		hasOrphans := true
		for hasOrphans {
			batchesProcessed++
			res, err := utils.Client.DB().ExecContext(ctx, `
				DELETE ern
				FROM event_reminder_notifications AS ern
				INNER JOIN (
					SELECT event_id, user_id
					FROM event_reminder_notifications AS ern2
					LEFT JOIN events AS e ON ern2.event_id = e.id
					WHERE e.id IS NULL
					LIMIT `+strconv.Itoa(batchSize)+`
				) AS dt ON ern.event_id = dt.event_id AND ern.user_id = dt.user_id;
			`)

			if err != nil {
				log.Printf("Error deleting orphaned event_user rows: %v", err)
			}

			affectedRows, _ := res.RowsAffected()

			if affectedRows == 0 || batchesProcessed >= maxBatches {
				hasOrphans = false
			} else {
				time.Sleep(pauseDuration)
			}
		}
		time.Sleep(time.Hour * 1)
	}
}

func DeleteEventsAfterEventDate() {
	// Delete events 1 day after the event date,
	// Runs every 2 hours
	const maxBatches = 10
	const batchSize = 100
	const pauseDuration = time.Second * 2

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	for {
		batchesProcessed := 0
		hasOrphans := true
		for hasOrphans {
			batchesProcessed++
			res, err := utils.Client.DB().ExecContext(ctx, `
				DELETE FROM events e
				WHERE DATE_ADD(e.event_date, INTERVAL 7 DAY) < NOW()
				LIMIT `+strconv.Itoa(batchSize)+`
			`)

			if err != nil {
				log.Printf("Error deleting orphaned event_user rows: %v", err)
			}

			affectedRows, _ := res.RowsAffected()

			if affectedRows == 0 || batchesProcessed >= maxBatches {
				hasOrphans = false
			} else {
				time.Sleep(pauseDuration)
			}
		}
		time.Sleep(time.Hour * 2)
	}
}

func SendEventNotifications() {
	const maxBatches = 10
	const batchSize = 100
	const pauseDuration = time.Second * 2
	const maxConcurrentGoroutines = 50

	daysLeftOptions := []int{8, 3, 1}

	type EventGuestReminder struct {
		UserID  int
		EventID int
		Tokens  []string
		Body    string
	}

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	sem := semaphore.NewWeighted(maxConcurrentGoroutines)

	for {
		for _, daysLeft := range daysLeftOptions {
			batchesProcessed := 0
			hasEventUsers := true

			for hasEventUsers {
				rows, err := utils.Client.DB().QueryContext(ctx, `
					SELECT eu.event_id, eu.user_id, e.name, d.token
					FROM (
						SELECT eu.event_id, eu.user_id
						FROM event_users AS eu
						JOIN events AS e ON eu.event_id = e.id
						LEFT JOIN event_reminder_notifications AS ern ON ern.event_id = eu.event_id AND ern.user_id = eu.user_id AND ern.days_left = `+strconv.Itoa(daysLeft)+`
						WHERE ern.id IS NULL AND DATEDIFF(e.event_date, NOW()) = `+strconv.Itoa(daysLeft)+`
						LIMIT `+strconv.Itoa(batchSize)+`
					) AS eu
					JOIN events AS e ON eu.event_id = e.id
					JOIN devices AS d ON eu.user_id = d.user_id
				`)
				if err != nil {
					log.Printf("Error fetching event_users for notifications: %v", err)
					break
				}

				affectedRows := 0
				eventGuestReminderMap := make(map[int]EventGuestReminder)
				for rows.Next() {
					var eventID, userID int
					var name, token string
					if err := rows.Scan(&eventID, &userID, &name, &token); err != nil {
						log.Printf("Error scanning event_user row: %v", err)
						continue
					}

					if _, ok := eventGuestReminderMap[userID]; ok {
						egr := eventGuestReminderMap[userID]

						egr.Tokens = append(egr.Tokens, token)

						eventGuestReminderMap[userID] = egr
					} else {
						var body string

						if daysLeft == 8 {
							body = name + " is only 1 week away!"
						} else if daysLeft == 3 {
							body = "Just 3 days left until " + name + "!"
						} else {
							body = name + " is tomorrow!"
						}

						tokens := []string{token}
						eventGuestReminderMap[userID] = EventGuestReminder{
							UserID:  userID,
							EventID: eventID,
							Tokens:  tokens,
							Body:    body,
						}
					}

					affectedRows++
				}
				rows.Close()

				for _, egr := range eventGuestReminderMap {
					sem.Acquire(ctx, 1)

					go func(egr EventGuestReminder) {
						defer sem.Release(1)

						notifications.SendPushNotificationsWithDevices(ctx, egr.Tokens, "Happ", egr.Body)
						err := utils.Client.EventReminderNotification.
							Create().
							SetEventID(egr.EventID).
							SetUserID(egr.UserID).
							SetDaysLeft(daysLeft).
							SetSentAt(time.Now()).
							OnConflict().
							SetDaysLeft(daysLeft).
							SetSentAt(time.Now()).
							Exec(ctx)
						if err != nil {
							log.Printf("Error saving notification record %s", err)
						}
					}(egr)
				}

				// go notifications.SendPushNotificationsWithDevices(utils.Client, token, "Happ", body)
				if affectedRows == 0 || batchesProcessed >= maxBatches {
					hasEventUsers = false
				} else {
					time.Sleep(pauseDuration)
				}

				batchesProcessed++
			}
		}
		time.Sleep(time.Hour * 4)
	}
}
