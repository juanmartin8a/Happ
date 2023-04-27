package utils

import (
	"context"
	customMiddleware "happ/middleware"
	"strconv"
)

func IsAuth(ctx context.Context) (*int, error) {
	ec, err := customMiddleware.EchoContextFromContext(ctx)
	if err != nil {
		return nil, err
	}

	// userId, err := GetUserIdFromJWT(ec.Request().Header.Get("Authorization"))
	// if err != nil {
	// 	return nil, err
	// }

	userId, err := GetUserIdFromFirebaseIDToken(ctx, ec.Request().Header.Get("Authorization"))
	if err != nil {
		return nil, err
	}

	userIdToString := strconv.Itoa(*userId)

	ec.Request().Header.Set("UserID", userIdToString)

	return userId, nil
}

func GetUserIdFromHeader(ctx context.Context) (*int, error) {
	ec, err := customMiddleware.EchoContextFromContext(ctx)
	if err != nil {
		return nil, err
	}

	userIdString := ec.Request().Header.Get("UserID")

	userID, _ := strconv.Atoi(userIdString)

	return &userID, nil
}

func SaveUserIdInHeader(ctx context.Context, userId int) (*int, error) {
	ec, err := customMiddleware.EchoContextFromContext(ctx)
	if err != nil {
		return nil, err
	}

	userIdToString := strconv.Itoa(userId)

	ec.Request().Header.Set("UserID", userIdToString)

	return &userId, nil
}
