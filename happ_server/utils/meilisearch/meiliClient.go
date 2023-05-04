package meilisearchUtils

import (
	"github.com/meilisearch/meilisearch-go"
)

var MeiliClient *meilisearch.Client

func GetSimpleMeiliClient() *meilisearch.Client {
	client := meilisearch.NewClient(meilisearch.ClientConfig{
		Host:   "http://127.0.0.1:7700",
		APIKey: "tQvcnvWK0BvMMGU0GrL1SwOOXPbs4BF8ZxrGP0YmNKY",
	})

	// meilisearchClient.

	return client
}

func GetMeiliClient() (*meilisearch.Client, bool) {
	client := meilisearch.NewClient(meilisearch.ClientConfig{
		Host:   "http://127.0.0.1:7700",
		APIKey: "tQvcnvWK0BvMMGU0GrL1SwOOXPbs4BF8ZxrGP0YmNKY",
	})
	isHealthy := client.IsHealthy()

	return client, isHealthy
}

// func GetMeiliUsersIndex() (*meilisearch.Index, bool) {
// 	client, isHealthy := GetMeiliClient()
// 	if !isHealthy {
// 		return nil, isHealthy
// 	}
// 	index := client.Index("users")
// 	return index, isHealthy
// }

func GetMeiliUsersIndex() (*meilisearch.Index, bool) {
	// client, isHealthy := GetMeiliClient()
	// if !isHealthy {
	// 	return nil, isHealthy
	// }
	index := MeiliClient.Index("users")
	isHealthy := MeiliClient.IsHealthy()
	return index, isHealthy
}

// func GetMeiliFollowIndex() (*meilisearch.Index, bool) {
// 	client, isHealthy := GetMeiliClient()
// 	if !isHealthy {
// 		return nil, isHealthy
// 	}
// 	index := client.Index("follows")
// 	return index, isHealthy
// }

func GetMeiliFollowIndex() (*meilisearch.Index, bool) {
	// client, isHealthy := GetMeiliClient()
	// if !isHealthy {
	// 	return nil, isHealthy
	// }
	// filterableAttributes := []string{
	// 	"id",
	// 	"userID1",
	// 	"userID2",
	// }
	index := MeiliClient.Index("follows")
	// fmt.Println(index.GetFilterableAttributes())
	// index.UpdateFilterableAttributes(&filterableAttributes)
	// fmt.Println(index.GetFilterableAttributes())
	isHealthy := MeiliClient.IsHealthy()
	return index, isHealthy
}
