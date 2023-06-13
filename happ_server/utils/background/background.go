package background

import (
	"context"
	"encoding/json"
	"fmt"
	"happ/config"
	"happ/ent/schema/schematype"
	"happ/utils"
	"happ/utils/aws/awsS3"
	"happ/utils/notifications"
	"log"
	"strconv"
	"strings"
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
					LIMIT ?
				) AS dt ON eu.event_id = dt.event_id AND eu.user_id = dt.user_id;
			`, batchSize)

			if err != nil {
				log.Printf("Error deleting orphaned event_user rows: %v", err)
				time.Sleep(pauseDuration)
				continue
			}

			affectedRows, err := res.RowsAffected()
			if err != nil {
				log.Printf("Error getting affected rows after deleting orphaned event_user rows: %v", err)
				time.Sleep(pauseDuration)
				continue
			}

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
					LIMIT ?
				) AS dt ON ern.event_id = dt.event_id AND ern.user_id = dt.user_id;
			`, batchSize)

			if err != nil {
				log.Printf("Error deleting orphaned event_reminder_notification rows: %v", err)
				time.Sleep(pauseDuration)
				continue
			}

			affectedRows, err := res.RowsAffected()
			if err != nil {
				log.Printf("Error getting affected rows after deleting orphaned event_reminder_notification rows: %v", err)
				time.Sleep(pauseDuration)
				continue
			}

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

			tx, err := utils.Client.Tx(ctx)
			if err != nil {
				log.Printf("Error starting transaction on DeleteEventsAfterEventDate(): %v", err)
				continue
			}

			res0, err := tx.QueryContext(ctx, `
				SELECT * FROM events
				WHERE DATE_ADD(event_date, INTERVAL 7 DAY) < NOW()
				LIMIT ?
			`, batchSize)
			if err != nil {
				log.Printf("Error selecting events after event date: %v", err)
				if rerr := tx.Rollback(); rerr != nil {
					err = fmt.Errorf("%w: %v", err, rerr)
					log.Printf("Error rolling back on DeleteEventsAfterEventDate(): %v", err)
				}
				time.Sleep(pauseDuration)
				continue
			}

			var picturesToDelete []string

			var ids []interface{}
			var params []string

			for res0.Next() {
				var id int
				var name string
				var description string
				var confirmed_count int
				var event_pics string
				var light_event_pics string
				var event_date time.Time
				var created_at time.Time
				var updated_at time.Time
				var coords schematype.Point
				var event_key string
				var event_nonce string
				var confirmed_hosts int
				var event_place string

				if err := res0.Scan(
					&id,
					&name,
					&description,
					&confirmed_count,
					&event_pics,
					&event_date,
					&coords,
					&created_at,
					&updated_at,
					&light_event_pics,
					&event_key,
					&event_nonce,
					&confirmed_hosts,
					&event_place,
				); err != nil {
					// Check for a scan error.
					// Query rows will be closed with defer.
					log.Printf("Error scanning select events on DeleteEventsAfterEventDate(): %v", err)
					time.Sleep(pauseDuration)
					continue
				}

				var eventPics []string
				json.Unmarshal([]byte(event_pics), &eventPics)

				var lightEventPics []string
				json.Unmarshal([]byte(light_event_pics), &lightEventPics)

				allEventPics := append(eventPics, lightEventPics...)

				for _, pic := range allEventPics {
					objectToDeleteFullString := pic

					var cloudfrontDistribution string
					if config.C.AppEnv == "prod" {
						cloudfrontDistribution = "https://di7aab2ls1mmt.cloudfront.net/"
					} else if config.C.AppEnv == "dev" {
						cloudfrontDistribution = "https://d3pvchlba3rmqp.cloudfront.net/"
					}

					picturesToDelete = append(picturesToDelete, strings.ReplaceAll(objectToDeleteFullString, cloudfrontDistribution, ""))
				}

				ids = append(ids, id)
				params = append(params, "?")
			}
			res0.Close()

			if len(ids) <= 0 {
				log.Println("No results from select query on DeleteEventsAfterEventDate()")
				if rerr := tx.Rollback(); rerr != nil {
					err = fmt.Errorf("%w: %v", err, rerr)
					log.Printf("Error rolling back on DeleteEventsAfterEventDate(): %v", err)
				}
				hasOrphans = false
				break
			}

			placeholders := strings.Join(params, ",")

			query := `
			DELETE FROM events
			`

			query += fmt.Sprintf("WHERE id IN (%s)", placeholders)

			res, err := tx.ExecContext(ctx, query, ids...)
			if err != nil {
				log.Printf("Error deleting event after event date: %v", err)
				if rerr := tx.Rollback(); rerr != nil {
					err = fmt.Errorf("%w: %v", err, rerr)
					log.Printf("Error rolling back on DeleteEventsAfterEventDate(): %v", err)
				}
				time.Sleep(pauseDuration)
				continue
			}

			if err := tx.Commit(); err != nil {
				log.Printf("Error on commit DeleteEventsAfterEventDate(): %v", err)
				time.Sleep(pauseDuration)
				continue
			}

			affectedRows, err := res.RowsAffected()
			if err != nil {
				log.Printf("Error getting affected rows after deleting events 7 days or more after event date: %v", err)
				time.Sleep(pauseDuration)
				continue
			}

			if len(picturesToDelete) > 0 {
				deleteEventPicsRes := awsS3.DeleteFromS3(picturesToDelete)
				if !deleteEventPicsRes {
					log.Printf("could not delete event pictures from S3: %s", picturesToDelete)
				}
			}

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
						WHERE ern.id IS NULL AND DATEDIFF(e.event_date, NOW()) = ?
						LIMIT ?
					) AS eu
					JOIN events AS e ON eu.event_id = e.id
					JOIN devices AS d ON eu.user_id = d.user_id
				`, daysLeft, batchSize)
				if err != nil {
					log.Printf("Error fetching event_users for notifications: %v", err)
					time.Sleep(pauseDuration)
					continue
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
