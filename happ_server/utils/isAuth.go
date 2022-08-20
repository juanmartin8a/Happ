package utils

import (
	"context"
	customMiddleware "happ/middleware"
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
