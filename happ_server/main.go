package main

import (
	"context"
	"happ/config"
	"happ/database"
	"happ/ent/migrate"
	_ "happ/ent/runtime"
	"happ/graph"
	"happ/graph/dataloaders"
	customMiddleware "happ/middleware"
	"happ/utils"
	firebaseUtils "happ/utils/firebase"
	meilisearchUtils "happ/utils/meilisearch"
	"happ/utils/notifications"
	redisUtils "happ/utils/redis"
	"log"
	"os"
	"strconv"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"golang.org/x/sync/semaphore"
)

const defaultPort = "8080"

// var Client *ent.Client

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	config.ReadConfig(config.ReadConfigOption{})

	ctx := context.Background()

	redisUtils.RedisClient = redisUtils.GetRedisClient()

	meilisearchUtils.MeiliClient = meilisearchUtils.GetSimpleMeiliClient()

	_, err := firebaseUtils.GetFirebaseAuthClient(ctx)
	if err != nil {
		log.Fatalf("Error getting Auth client")
	}
	_, err = firebaseUtils.GetFirebaseMessageClient(ctx)
	if err != nil {
		log.Fatalf("Error getting FCM client")
	}

	// notificationTest()

	go checkMeilisearchServerHealth()
	go checkRedisServerHealth()

	e := echo.New()

	e.Use(customMiddleware.EchoContextMiddleware)
	loader := dataloaders.NewDataLoader()
	e.Use(dataloaders.Middleware(loader))

	e.Use(middleware.Recover())

	client, err := database.NewClient(database.NewClientOptions{})
	if err != nil {
		log.Fatalf("failed opening mysql client: %v", err)
	}

	utils.Client = client

	go deleteEventsAfterEventDate()
	go deleteOrphanedEventUsers()
	go sendEventNotifications()
	go deleteOrphanedEventReminderNotifications()

	// ctx := context.Background()
	if err := client.Schema.Create(
		ctx,
		migrate.WithForeignKeys(false),
	); err != nil {
		log.Fatal("opening ent client", err)
	}

	srv := handler.NewDefaultServer(graph.NewSchema(client))

	{
		e.POST("/query", func(c echo.Context) error {
			srv.ServeHTTP(c.Response(), c.Request())
			return nil
		})

		e.GET("/playground", func(c echo.Context) error {
			playground.Handler("GraphQL", "/query").ServeHTTP(c.Response(), c.Request())
			return nil
		})
	}

	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)

	e.Logger.Fatal(e.Start("0.0.0.0:" + port))
}

func checkMeilisearchServerHealth() {
	for {
		status, err := meilisearchUtils.MeiliClient.Health()
		if err != nil {
			log.Fatalf("Error checking Meilisearch server health: %v", err)
		} else {
			log.Printf("Meilisearch server status: %v", status.Status)
		}
		time.Sleep(10 * time.Minute)
	}
}

func checkRedisServerHealth() {
	for {
		result, err := redisUtils.RedisClient.Ping(context.Background()).Result()
		if err != nil {
			log.Fatalf("Error checking Redis server health: %v", err)
		} else {
			log.Printf("Redis server status: %v", result)
		}
		time.Sleep(10 * time.Minute)
	}
}

// create function that deleted orphaned event_user rows every 10 minutes
func deleteOrphanedEventUsers() {
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

func deleteOrphanedEventReminderNotifications() {
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

// func notificationTest() {
// 	// client := GetFirebaseMessageClient()
// 	start := time.Now()

// 	tokens := []string{"dcd-xIJ64U_qjOFh4pdqIO:APA91bFgzkXNFVlEgMzFgGFpH-J0Sr05IFAmVUliCUCq-RZZ8kwDs8EIL6eNu41zK0_dm-5ko9bq6frb3B7bJssFH4k2BEje03mCcGnkV77C6DKySSSuAIhrm953EZ6Dw_YQIVDc1o8U"}
// 	response, err := firebaseUtils.FCMClient.SendMulticast(context.Background(), &messaging.MulticastMessage{

// 		Notification: &messaging.Notification{
// 			Title: "Congratulations!!",
// 			Body:  "You have just implement push notification",
// 		},
// 		Tokens: tokens, // it's a single device token
// 	})

// 	elapsed := time.Since(start)
// 	fmt.Printf("took: %s", elapsed)

// 	fmt.Println("aaaaaaaa")

// 	if err != nil {
// 		fmt.Println(err)
// 	}

// 	fmt.Println("res")
// 	fmt.Println(response)
// }

func deleteEventsAfterEventDate() {
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

func sendEventNotifications() {
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
						WHERE ern.id IS NULL AND DATEDIFF(e.start_date, NOW()) = `+strconv.Itoa(daysLeft)+`
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

						notifications.SendPushNotificationsWithDevices(utils.Client, egr.Tokens, "Happ", egr.Body)
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

// create a function that checks for health on the database server

// create fucntion to delete orphaned rows

// on add friend
// on invitation accepted
// on invitatation sent
// on event leave (all hosts)
// on event canceled (all event guests and hosts)
