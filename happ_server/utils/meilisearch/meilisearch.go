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

func RemoveUserFromMeili(userId int) bool {
	index, isHealthy := GetMeiliFollowIndex()
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
		// fmt.Println(err)
		return nil, err
	}

	return searchRes.Hits, nil
}

func AddFollowToMeili(userID1 int, userID2 int) bool {
	index, isHealthy := GetMeiliFollowIndex()
	if !isHealthy {
		return false
	}

	// lowestNumberUserId := math.Min(float64(userId1), float64(userId2))
	// highestNumberUserId := math.Max(float64(userId1), float64(userId2))

	documents := []map[string]interface{}{
		{
			"id":      fmt.Sprintf("%s_%s", strconv.Itoa(userID1), strconv.Itoa(userID2)),
			"userID1": userID1,
			"userID2": userID2,
		},
	}

	_, err := index.AddDocuments(documents, "id")

	return err == nil
}

func GetFollowFromMeili(id string) (interface{}, error) {
	index, isHealthy := GetMeiliFollowIndex()

	if !isHealthy {
		return nil, fmt.Errorf("error: meilisearch client not healthy")
	}

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

func RemoveFollowFromMeili(userID1 int, userID2 int) bool {
	index, isHealthy := GetMeiliFollowIndex()
	if !isHealthy {
		return false
	}

	id := fmt.Sprintf("%s_%s", strconv.Itoa(userID1), strconv.Itoa(userID2))

	_, err := index.DeleteDocument(id)

	return err == nil
}

func RemoveFollowsFromMeili(ids []string) bool {
	index, isHealthy := GetMeiliFollowIndex()
	if !isHealthy {
		return false
	}

	_, err := index.DeleteDocuments(ids)
	return err == nil
}

// func UpdateUserFromMeili() {
// 	index, _ := GetMeiliUsersIndex()

// 	documents := []map[string]interface{}{
// 		{"id": 1, "profilePic": "https://d3pvchlba3rmqp.cloudfront.net/userProfilePics/blueLobster.jpg"},
// 	}
// 	res, err := index.UpdateDocuments(documents)
// 	fmt.Println(res)
// 	fmt.Println(err)
// }
