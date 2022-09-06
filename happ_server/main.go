package main

import (
	"context"
	"fmt"
	"happ/config"
	"happ/database"
	"happ/ent/migrate"
	"happ/graph"
	customMiddleware "happ/middleware"
	meilisearchUtils "happ/utils/meilisearch"
	"log"
	"os"
	"reflect"

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

	e.Use(customMiddleware.EchoContextMiddleware)

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

	// meilisearchUtils.AddUserToMeili()
	// meilisearchUtils.UpdateUserFromMeili()

	users, _ := meilisearchUtils.GetUsersFromMeili("juan")
	fmt.Println(users)
	for _, user := range users {
		fmt.Println(user.(map[string]interface{})["username"].(string))
		fmt.Println(reflect.TypeOf(user.(map[string]interface{})["username"].(string)))
		// sapo := mapstructure.Decode(user, &UserDoc{})
		// fmt.Println(sapo)
	}

	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)

	e.Logger.Fatal(e.Start(":" + port))

	// SignUp()
}
