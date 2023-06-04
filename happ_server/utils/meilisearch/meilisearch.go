package meilisearchUtils

import (
	"fmt"
	"happ/ent"
	"strconv"
	"strings"

	// "strconv"

	"github.com/meilisearch/meilisearch-go"
)

func AddUserToMeili(user *ent.User) bool {
	index, _ := GetMeiliUsersIndex()

	documents := []map[string]interface{}{
		{
			"id":         user.ID,
			"username":   user.Username,
			"name":       user.Name,
			"profilePic": user.ProfilePic,
		},
	}

	_, err := index.AddDocuments(documents)

	return err == nil
}

func UpdateMeiliUser(
	userId int,
	username *string,
	name *string,
	profilePic *string,
) bool {
	index, _ := GetMeiliUsersIndex()

	document := map[string]interface{}{
		"id": userId,
	}

	if username != nil {
		document["username"] = *username
	}

	if name != nil {
		document["name"] = *name
	}

	if profilePic != nil {
		document["profilePic"] = *profilePic
	}

	documents := []map[string]interface{}{document}

	_, err := index.UpdateDocuments(documents)

	return err == nil
}

func RemoveUserFromMeili(userId int) bool {
	index, isHealthy := GetMeiliUsersIndex()
	if !isHealthy {
		return false
	}

	_, err := index.DeleteDocument(strconv.Itoa(userId))

	return err == nil
}

func GetUsersFromMeili(search string, filterNotIn []int) ([]interface{}, error) {
	index, isHealthy := GetMeiliUsersIndex()

	var emptySearchArray []interface{}

	if !isHealthy {
		return emptySearchArray, nil
	}

	var filter string
	if len(filterNotIn) > 0 {
		filter = fmt.Sprintf("id NOT IN [%s]", strings.Trim(strings.Join(strings.Fields(fmt.Sprint(filterNotIn)), ","), "[]"))
	}

	searchRes, err := index.Search(
		search,
		&meilisearch.SearchRequest{
			Limit:  20,
			Filter: filter,
		},
	)
	if err != nil {
		return nil, err
	}

	return searchRes.Hits, nil
}
