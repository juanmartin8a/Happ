package utils

import (
	"context"
	"fmt"
	firebaseUtils "happ/utils/firebase"
	"log"
	"strings"
)

type UserIdAndFUID struct {
	UserId      *int
	FirebaseUID *string
}

func GetUserIdFromFirebaseIDToken(ctx context.Context, authorizationHeader string) (*int, error) {
	authToken := strings.TrimPrefix(authorizationHeader, "Bearer ")

	token, err := firebaseUtils.AuthClient.VerifyIDToken(ctx, authToken)
	if err != nil {
		log.Printf("Error: %s", err)
		return nil, fmt.Errorf("error verifying id token: %v", err)
	}

	userId := int(token.Claims["id"].(float64))

	return &userId, nil
}

func GetUserIdAndFUIDFromFirebaseIDToken(ctx context.Context, authorizationHeader string) (*UserIdAndFUID, error) {
	authToken := strings.TrimPrefix(authorizationHeader, "Bearer ")

	token, err := firebaseUtils.AuthClient.VerifyIDToken(ctx, authToken)
	if err != nil {
		log.Printf("Error: %s", err)
		return nil, fmt.Errorf("error verifying id token: %v", err)
	}

	userId := int(token.Claims["id"].(float64))

	firebaseUID := token.Claims["user_id"].(string)

	userIdAndFuidStruct := UserIdAndFUID{
		UserId:      &userId,
		FirebaseUID: &firebaseUID,
	}

	return &userIdAndFuidStruct, nil
}
