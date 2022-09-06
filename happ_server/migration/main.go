package main

import (
	"context"
	// "fmt"
	"happ/config"
	"happ/database"
	"happ/ent"
	"happ/ent/migrate"
	"log"
	// "os"
)

func main() {
	// fmt.Println(os.Getenv("PASSWORD"))
	config.ReadConfig(config.ReadConfigOption{})

	client, err := database.NewClient(database.NewClientOptions{})
	if err != nil {
		log.Fatalf("failed opening mysql client: %v", err)
	}
	defer client.Close()
	db := client.DB()
	_, err = db.Exec("SET GLOBAL read_only = OFF;")
	if err != nil {
		log.Fatalf("failed changing mysql config: %v", err)
	}

	createDBSchema(client)
}

func createDBSchema(client *ent.Client) {
	ctx := context.Background()
	if err := client.Schema.Create(
		ctx,
		// migrate
		migrate.WithDropIndex(true),
		migrate.WithDropColumn(true),
		migrate.WithForeignKeys(false),
	); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}
}
