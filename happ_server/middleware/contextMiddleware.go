package customMiddleware

import (
	"context"
	"fmt"

	"github.com/labstack/echo/v4"
)

type CustomContext struct {
	echo.Context
	Ctx context.Context
}

type ContextKey struct {
	Name string
}

var echoContextKey = &ContextKey{"EchoContextKey"}

func EchoContextMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {

		ctx := context.WithValue(c.Request().Context(), echoContextKey, c)

		c.SetRequest(c.Request().WithContext(ctx))

		cc := &CustomContext{
			c,
			ctx,
		}

		return next(cc)
	}
}

func EchoContextFromContext(ctx context.Context) (echo.Context, error) {

	echoContext := ctx.Value(echoContextKey)

	if echoContext == nil {
		err := fmt.Errorf("could not retrieve echo.Context")
		return nil, err
	}

	ec, ok := echoContext.(echo.Context)
	if !ok {
		err := fmt.Errorf("echo.Context has wrong type")
		return nil, err
	}

	return ec, nil
}
