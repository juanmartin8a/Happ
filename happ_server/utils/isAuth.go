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

	userId, err := GetUserIdFromJWT(ec.Request().Header.Get("Authorization"))
	if err != nil {
		return nil, err
	}

	return userId, nil
}

func GetUserIdFromHeader(ctx context.Context) (*int, error) {
	ec, err := customMiddleware.EchoContextFromContext(ctx)
	if err != nil {
		return nil, err
	}

	userIdString := ec.Request().Header.Get("UserId")
	if err != nil {
		return nil, err
	}

	userId, _ := strconv.Atoi(userIdString)

	return &userId, nil
}
