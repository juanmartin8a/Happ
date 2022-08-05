package main

import (
	"context"
	"happ/config"
	"happ/database"
	"happ/ent/migrate"
	"happ/graph"
	"log"
	"net/http"
	"os"

	// _ "github.com/99designs/gqlgen"
	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
)

// _ "github.com/99designs/gqlgen"

const defaultPort = "8080"

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	config.ReadConfig(config.ReadConfigOption{})

	client, err := database.NewClient(database.NewClientOptions{})
	if err != nil {
		log.Fatalf("failed opening mysql client: %v", err)
	}

	ctx := context.Background()
	if err := client.Schema.Create(
		ctx,
		migrate.WithDropIndex(true),
		migrate.WithDropColumn(true),
		migrate.WithForeignKeys(false),
	); err != nil {
		log.Fatal("opening ent client", err)
	}

	//srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{}}))
	srv := handler.NewDefaultServer(graph.NewSchema(client))

	http.Handle("/", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", srv)

	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	// log.Fatal(http.ListenAndServe(":"+port, nil))
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal("http server terminated", err)
	}

	// client, err := ent.Open(dialect.SQLite, "file:ent?mode=memory&cache=shared&_fk=1")
	//   if err != nil {
	//       log.Fatal("opening ent client", err)
	//   }
	//   if err := client.Schema.Create(
	//       context.Background(),
	//       migrate.WithGlobalUniqueID(true),
	//   ); err != nil {
	//       log.Fatal("opening ent client", err)
	//   }

	// Configure the server and start listening on :8081.
	// srv := handler.NewDefaultServer(todo.NewSchema(client))
	// http.Handle("/",
	//     playground.Handler("Todo", "/query"),
	// )
	// http.Handle("/query", srv)
	// log.Println("listening on :8081")
	// if err := http.ListenAndServe(":8081", nil); err != nil {
	//     log.Fatal("http server terminated", err)
	// }
}
