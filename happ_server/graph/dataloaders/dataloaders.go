package dataloaders

// import graph gophers with your other imports
import (
	"context"
	"fmt"

	"happ/ent"
	"happ/ent/follow"
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
	userIDs := make([]int, 0, len(keys))
	for _, key := range keys {
		keyToInt, _ := strconv.Atoi(key.String())
		if keyToInt != -1 {
			userIDs = append(userIDs, keyToInt)
		}
		// userIDs[i] = keyToInt
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

	deletedUser := &ent.User{
		Name:       "Deleted User",
		ID:         -1,
		Username:   "deleted_user",
		ProfilePic: "https://d3pvchlba3rmqp.cloudfront.net/userProfilePics/blueLobster.jpg",
		// CreatedAt: time.Now(),
		// UpdatedAt: time.Now(),
	}

	// return users in the same order requested
	output := make([]*dataloader.Result, len(keys))
	for index, userKey := range keys {
		// user, ok := userById[userKey.String()]
		keyToInt, _ := strconv.Atoi(userKey.String())
		if keyToInt == -1 {
			output[index] = &dataloader.Result{Data: deletedUser, Error: nil}
		} else {
			user, ok := userById[userKey.String()]
			if ok {
				output[index] = &dataloader.Result{Data: user, Error: nil}
			} else {
				err := fmt.Errorf("user not found %s", userKey.String())
				output[index] = &dataloader.Result{Data: nil, Error: err}
			}
		}
	}
	return output
}

func GetFollowStates(ctx context.Context, keys dataloader.Keys) []*dataloader.Result {

	client := utils.Client
	userId, _ := utils.GetUserIdFromHeader(ctx)

	followUserIDs := make([]int, 0, len(keys))
	for _, key := range keys {
		keyToInt, _ := strconv.Atoi(key.String())
		followUserIDs = append(followUserIDs, keyToInt)
	}

	res, err := client.Follow.Query().
		Where(
			follow.And(
				follow.FollowerID(*userId),
				follow.UserIDIn(followUserIDs...),
				follow.Valid(true),
			),
		).
		All(ctx)

	output := make([]*dataloader.Result, len(keys))
	if err != nil {
		for i := range output {
			output[i] = &dataloader.Result{Data: false, Error: nil}
		}
		return output
	}

	followStateByUserId := map[string]bool{}
	for _, f := range res {
		followStateByUserId[strconv.Itoa(f.UserID)] = f.Valid
	}

	for index, userKey := range keys {
		followState, ok := followStateByUserId[userKey.String()]
		if ok {
			output[index] = &dataloader.Result{Data: followState, Error: nil}
		} else {
			output[index] = &dataloader.Result{Data: false, Error: nil}
		}
	}

	return output
}

// Loaders wrap your data loaders to inject via middleware
type Loaders struct {
	UserLoader        *dataloader.Loader
	FollowStateLoader *dataloader.Loader
}

// NewLoaders instantiates data loaders for the middleware
func NewDataLoader() *Loaders {
	loaders := &Loaders{
		UserLoader:        dataloader.NewBatchedLoader(GetUsers, dataloader.WithClearCacheOnBatch()),
		FollowStateLoader: dataloader.NewBatchedLoader(GetFollowStates, dataloader.WithClearCacheOnBatch()),
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

func GetFollowState(ctx context.Context, userID string) (bool, error) {
	loaders := For(ctx)
	thunk := loaders.FollowStateLoader.Load(ctx, dataloader.StringKey(userID))
	result, err := thunk()
	if err != nil {
		return false, err
	}
	return result.(bool), nil
}
