package meilisearchUtils

import (
	"happ/config"
	awsParameterStore "happ/utils/aws/awsParams"
	"log"

	"github.com/meilisearch/meilisearch-go"
)

var MeiliClient *meilisearch.Client

func GetMeiliClient() (*meilisearch.Client, error) {

	appEnv := config.C.AppEnv

	APIKeyBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.MeilisearchMK)
	if err != nil {
		log.Printf("Error while getting meilisearch master key: %s", err)
		return nil, err
	}

	APIKey := string(APIKeyBytes)

	var host string

	if appEnv == "dev" {
		host = "http://localhost:7700"
	} else if appEnv == "prod" {
		host = "https://meilisearch.happ.rsvp"
	}

	MeiliClient = meilisearch.NewClient(meilisearch.ClientConfig{
		Host:   host,
		APIKey: APIKey,
	})

	return MeiliClient, nil
}

func GetMeiliUsersIndex() (*meilisearch.Index, bool) {
	index := MeiliClient.Index("users")
	isHealthy := MeiliClient.IsHealthy()
	return index, isHealthy
}
