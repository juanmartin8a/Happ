package meilisearchUtils

import (
	"fmt"
	"happ/ent"
	"math"
	"strconv"

	// "strconv"

	"github.com/meilisearch/meilisearch-go"
)

func AddUserToMeili(user *ent.User) bool {
	index := GetMeiliUsersIndex()

	documents := []map[string]interface{}{
		{
			"id":       user.ID,
			"username": user.Username,
			"name":     user.Name,
		},
	}

	_, err := index.AddDocuments(documents)

	return err == nil
}

func GetUsersFromMeili(search string) ([]interface{}, error) {
	index := GetMeiliUsersIndex()

	searchRes, err := index.Search(
		search,
		&meilisearch.SearchRequest{
			Limit: 15,
		},
	)
	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return searchRes.Hits, nil
}

func AddFollowToMeili(userId1 int, userId2 int) bool {
	index := GetMeiliFollowIndex()

	lowestNumberUserId := math.Min(float64(userId1), float64(userId2))
	highestNumberUserId := math.Max(float64(userId1), float64(userId2))

	documents := []map[string]interface{}{
		{
			"id":      fmt.Sprintf("%s_%s", strconv.Itoa(int(highestNumberUserId)), strconv.Itoa(int(lowestNumberUserId))),
			"userID1": int(highestNumberUserId),
			"userID2": int(lowestNumberUserId),
		},
	}

	_, err := index.AddDocuments(documents, "id")

	return err == nil
}

func GetFollowFromMeili(id string) (interface{}, error) {
	index := GetMeiliFollowIndex()

	var a interface{}
	err := index.GetDocument(
		id,
		&meilisearch.DocumentQuery{Fields: []string{"id"}},
		&a,
	)

	if err != nil {
		return nil, err
	}

	return a, nil
}

func RemoveFollowToMeili(userId1 int, userId2 int) bool {
	index := GetMeiliFollowIndex()

	lowestNumberUserId := math.Min(float64(userId1), float64(userId2))
	highestNumberUserId := math.Max(float64(userId1), float64(userId2))

	id := fmt.Sprintf("%s_%s", strconv.Itoa(int(highestNumberUserId)), strconv.Itoa(int(lowestNumberUserId)))

	_, err := index.DeleteDocument(id)

	return err == nil
}

func UpdateUserFromMeili() {
	index := GetMeiliUsersIndex()

	documents := []map[string]interface{}{
		{"id": 1, "username": "juanmartin8a", "name": "Juan Martin"},
	}
	res, err := index.UpdateDocuments(documents)
	fmt.Println(res)
	fmt.Println(err)
}
