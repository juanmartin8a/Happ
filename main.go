package main

import (
	"context"
	"happ/config"
	"happ/database"
	"happ/graph"
	"log"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

const defaultPort = "8080"

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	config.ReadConfig(config.ReadConfigOption{})

	e := echo.New()

	e.Use(middleware.Recover())

	client, err := database.NewClient(database.NewClientOptions{})
	if err != nil {
		log.Fatalf("failed opening mysql client: %v", err)
	}

	ctx := context.Background()
	if err := client.Schema.Create(
		ctx,
		// migrate.WithDropIndex(true),
		// migrate.WithDropColumn(true),
		// migrate.WithForeignKeys(false),
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

	e.Logger.Fatal(e.Start(":" + port))

	// SignUp()
}
