package dataloaders

// import graph gophers with your other imports
import (
	"context"
	"fmt"

	"happ/ent"
	"happ/ent/user"
	"happ/utils"
	"strconv"

	"github.com/graph-gophers/dataloader"
	"github.com/labstack/echo/v4"
)

type ctxKey string

const (
	loadersKey = ctxKey("dataloaders")
)

// GetUsers implements a batch function that can retrieve many users by ID,
// for use in a dataloader
func GetUsers(ctx context.Context, keys dataloader.Keys) []*dataloader.Result {
	// read all requested users in a single query
	client := utils.Client
	userIDs := make([]int, len(keys))
	for i, key := range keys {
		keyToInt, _ := strconv.Atoi(key.String())
		userIDs[i] = keyToInt
	}

	res, _ := client.User.Query().Where(
		user.IDIn(userIDs...),
	).All(ctx)

	// return User records into a map by ID
	userById := map[string]*ent.User{}

	for _, entUser := range res {
		user := entUser
		userById[strconv.Itoa(user.ID)] = user
	}
	// return users in the same order requested
	output := make([]*dataloader.Result, len(keys))
	for index, userKey := range keys {
		user, ok := userById[userKey.String()]
		if ok {
			output[index] = &dataloader.Result{Data: user, Error: nil}
		} else {
			err := fmt.Errorf("user not found %s", userKey.String())
			output[index] = &dataloader.Result{Data: nil, Error: err}
		}
	}
	return output
}

// Loaders wrap your data loaders to inject via middleware
type Loaders struct {
	UserLoader *dataloader.Loader
}

// NewLoaders instantiates data loaders for the middleware
func NewDataLoader() *Loaders {
	loaders := &Loaders{
		UserLoader: dataloader.NewBatchedLoader(GetUsers),
	}
	return loaders
}

// Middleware injects data loaders into the context
func Middleware(loaders *Loaders) echo.MiddlewareFunc {
	return func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {

			ctx := context.WithValue(c.Request().Context(), loadersKey, loaders)

			c.SetRequest(c.Request().WithContext(ctx))

			return next(c)
		}
	}
}

// For returns the dataloader for a given context
func For(ctx context.Context) *Loaders {
	return ctx.Value(loadersKey).(*Loaders)
}

// GetUser wraps the User dataloader for efficient retrieval by user ID
func GetUser(ctx context.Context, userID string) (*ent.User, error) {
	loaders := For(ctx)
	thunk := loaders.UserLoader.Load(ctx, dataloader.StringKey(userID))
	result, err := thunk()
	if err != nil {
		return nil, err
	}
	return result.(*ent.User), nil
}
