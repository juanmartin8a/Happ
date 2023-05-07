package meilisearchUtils

import (
	"github.com/meilisearch/meilisearch-go"
)

var MeiliClient *meilisearch.Client

func GetMeiliClient() *meilisearch.Client {
	MeiliClient = meilisearch.NewClient(meilisearch.ClientConfig{
		Host:   "http://127.0.0.1:7700",
		APIKey: "tQvcnvWK0BvMMGU0GrL1SwOOXPbs4BF8ZxrGP0YmNKY",
	})

	return MeiliClient
}

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
// 	index := MeiliClient.Index("follows")
// 	isHealthy := MeiliClient.IsHealthy()
// 	return index, isHealthy
// }
