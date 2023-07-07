package main

import (
	"context"
	"happ/config"
	"happ/database"
	"happ/ent/user"
	awsUtils "happ/utils/aws"
	meilisearchUtils "happ/utils/meilisearch"
	"log"
)

func main() {

	config.ReadConfig(config.ReadConfigOption{})

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	_, err := awsUtils.GetSSMClient()
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

	client, err := database.NewClient(database.NewClientOptions{})
	if err != nil {
		log.Fatalf("failed opening mysql client: %v", err)
	}

	users, err := client.User.Query().
		Select(user.FieldID, user.FieldUsername, user.FieldName, user.FieldProfilePic).
		All(ctx)
	if err != nil {
		log.Fatalf("err when getting all dev users: %v", err)
	}

	index, isHealthy := meilisearchUtils.GetMeiliUsersIndex()
	if !isHealthy {
		log.Fatalf("meilisearch not healthy: %v", err)
	}

	_, err = index.DeleteAllDocuments()
	if err != nil {
		log.Fatalf("err when deleting all dev users: %v", err)
	}

	var usersToAddToMeili []map[string]interface{}
	for _, user := range users {
		userToAdd := map[string]interface{}{
			"id":         user.ID,
			"username":   user.Username,
			"name":       user.Name,
			"profilePic": user.ProfilePic,
		}

		usersToAddToMeili = append(usersToAddToMeili, userToAdd)
	}

	_, err = index.AddDocuments(usersToAddToMeili)
	if err != nil {
		log.Fatalf("err when adding all dev users: %v", err)
	}

	log.Println("Success ;)")
}
