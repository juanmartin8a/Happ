package meilisearchUtils

import (
	"fmt"
	"happ/ent"

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

func UpdateUserFromMeili() {
	index := GetMeiliUsersIndex()

	documents := []map[string]interface{}{
		{"id": 1, "username": "juanmartin8a", "name": "Juan Martin"},
	}
	res, err := index.UpdateDocuments(documents)
	fmt.Println(res)
	fmt.Println(err)
}
