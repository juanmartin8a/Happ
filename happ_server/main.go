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
	awsUtils "happ/utils/aws"
	"happ/utils/background"
	firebaseUtils "happ/utils/firebase"
	meilisearchUtils "happ/utils/meilisearch"
	"log"
	"os"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"

	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Fatalf("Error: .env file not found: %s", err)
	}

	port := os.Getenv("PORT")

	config.ReadConfig(config.ReadConfigOption{})

	ctx := context.Background()

	_, err := awsUtils.GetS3Client()
	if err != nil {
		log.Fatalf("Error getting S3 client: %s", err)
	}

	_, err = awsUtils.GetSSMClient()
	if err != nil {
		log.Fatalf("Error getting SSM client: %s", err)
	}

	_, err = awsUtils.GetKMSClient()
	if err != nil {
		log.Fatalf("Error getting KMS client: %s", err)
	}

	_, err = meilisearchUtils.GetMeiliClient()
	if err != nil {
		log.Fatalf("Error getting Meili client: %s", err)
	}

	_, err = firebaseUtils.GetFirebaseAuthClient(ctx)
	if err != nil {
		log.Fatalf("Error getting Auth client")
	}
	_, err = firebaseUtils.GetFirebaseMessageClient(ctx)
	if err != nil {
		log.Fatalf("Error getting FCM client")
	}

	go checkMeilisearchServerHealth()

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

	if config.C.AppEnv == "dev" {
		if err := client.Schema.Create(
			ctx,
			migrate.WithForeignKeys(false),
		); err != nil {
			log.Fatal("opening ent client", err)
		}
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
		time.Sleep(1 * time.Minute)
	}
}
