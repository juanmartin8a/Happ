package utils

import (
	"fmt"
	"happ/jwtActions"
	"strconv"
	"strings"
)

func GetUserIdFromJWT(authorizationHeader string) (*int, error) {

	token := strings.TrimPrefix(authorizationHeader, "Bearer ")

	payload, err := jwtActions.ValidateToken(token, false)
	if err != nil {
		return nil, fmt.Errorf("access denied")
	}

	userId, _ := strconv.Atoi(payload["Id"].(string))

	return &userId, nil
}