package utils

import (
	"fmt"
	"happ/jwtActions"
	"strconv"
	"strings"
)

func GetUserIdFromJWT(authorizationHeader string) (int, error) {

	token := strings.TrimPrefix(authorizationHeader, "Bearer ")

	payload, err := jwtActions.ValidateToken(token, false)
	if err != nil {
		return -1, fmt.Errorf("access denied")
	}

	userId, _ := strconv.Atoi(payload["Id"].(string))
	fmt.Println(userId)

	return userId, nil
}
