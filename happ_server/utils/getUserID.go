package utils

import (
	"context"
	"fmt"
	firebaseUtils "happ/utils/firebase"
	"strings"
)

// func GetUserIdFromJWT(authorizationHeader string) (*int, error) {

// 	token := strings.TrimPrefix(authorizationHeader, "Bearer ")

// 	payload, err := jwtActions.ValidateToken(token, false)
// 	if err != nil {
// 		return nil, fmt.Errorf("access denied")
// 	}

// 	userId, _ := strconv.Atoi(payload["Id"].(string))

// 	return &userId, nil
// }

func GetUserIdFromFirebaseIDToken(ctx context.Context, authorizationHeader string) (*int, error) {
	authToken := strings.TrimPrefix(authorizationHeader, "Bearer ")

	// payload, err := jwtActions.ValidateToken(token, false)
	// if err != nil {
	// 	return nil, fmt.Errorf("access denied")
	// }

	token, err := firebaseUtils.AuthClient.VerifyIDToken(ctx, authToken)
	if err != nil {
		fmt.Printf("Error: %s", err)
		return nil, fmt.Errorf("error verifying id token: %v", err)
	}

	userId := int(token.Claims["id"].(float64))

	return &userId, nil
}
