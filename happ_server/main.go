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
	"happ/utils/background"
	firebaseUtils "happ/utils/firebase"
	meilisearchUtils "happ/utils/meilisearch"
	"log"
	"os"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
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

	// redisUtils.RedisClient = redisUtils.GetRedisClient()

	meilisearchUtils.GetMeiliClient()

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
	// go checkRedisServerHealth()

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

	go background.DeleteEventsAfterEventDate()
	go background.DeleteOrphanedEventUsers()
	go background.DeleteOrphanedEventReminderNotifications()
	go background.SendEventNotifications()

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
