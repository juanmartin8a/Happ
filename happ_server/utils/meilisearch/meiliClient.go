package meilisearchUtils

import "github.com/meilisearch/meilisearch-go"

func GetMeiliClient() *meilisearch.Client {
	client := meilisearch.NewClient(meilisearch.ClientConfig{
		Host: "http://127.0.0.1:7700",
		// APIKey: "masterKey",
	})
	return client
}

func GetMeiliUsersIndex() *meilisearch.Index {
	client := GetMeiliClient()
	index := client.Index("users")
	return index
}
