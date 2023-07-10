package dataloaders

// import graph gophers with your other imports
import (
	"context"
	"fmt"
	"log"
	"strings"
	"time"

	"happ/ent"
	"happ/ent/eventuser"
	"happ/ent/follow"
	"happ/ent/user"
	"happ/graph/model"
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

func GetEventFriends(ctx context.Context, keys dataloader.Keys) []*dataloader.Result {

	eventPeopleByEventID := map[string][]*ent.User{}

	client := utils.Client
	userId, _ := utils.GetUserIdFromHeader(ctx)

	eventIds := make([]int, 0, len(keys))
	for _, key := range keys {
		keyToInt, _ := strconv.Atoi(key.String())
		eventIds = append(eventIds, keyToInt)
	}

	var args []interface{}
	args = append(args, *userId)
	args = append(args, *userId)

	var params []string
	for _, id := range eventIds {
		params = append(params, strconv.Itoa(id))
	}

	// join params with commas
	placeholders := strings.Join(params, ",")

	args = append(args, placeholders)

	query := fmt.Sprintf(`SELECT sub.id, sub.name, sub.username, sub.email, sub.fuid, sub.created_at, sub.updated_at, sub.profile_pic, sub.event_id
	FROM (
		SELECT u.*, f.user_id, eu.event_id, ROW_NUMBER() OVER(PARTITION BY eu.event_id ORDER BY CASE WHEN f.user_id = %d THEN 1 ELSE 2 END, f.user_id DESC) row_num FROM users u
		INNER JOIN event_users eu ON eu.user_id = u.id
		LEFT JOIN follows f ON f.user_id = u.id AND f.follower_id = %d AND f.valid = true
		WHERE eu.event_id IN (%s) AND eu.confirmed = true
	) sub
	WHERE sub.row_num <= 3`, args...)

	res, err := client.QueryContext(ctx, query)
	if err != nil {
		log.Printf("Error on GetEventFriends(): %s", err)
		output := make([]*dataloader.Result, len(keys))
		for i := range output {
			output[i] = &dataloader.Result{Data: []*ent.User{}, Error: nil}
		}
		return output
	}

	defer res.Close()

	for res.Next() {
		var id int
		var name string
		var username string
		var email string
		var fuid string
		var created_at time.Time
		var updated_at time.Time
		var profile_pic string
		// var user_id *int
		var event_id int

		if err := res.Scan(
			&id,
			&name,
			&username,
			&email,
			&fuid,
			&created_at,
			&updated_at,
			&profile_pic,
			// &user_id,
			&event_id,
		); err != nil {
			// Check for a scan error.
			log.Printf("Error on GetEventFriends(): %s", err)
			output := make([]*dataloader.Result, len(keys))
			for i := range output {
				output[i] = &dataloader.Result{Data: []*ent.User{}, Error: nil}
			}
			return output
		}

		user := &ent.User{
			ID:         id,
			Name:       name,
			Username:   username,
			Email:      email,
			CreatedAt:  created_at,
			UpdatedAt:  updated_at,
			ProfilePic: profile_pic,
			FUID:       fuid,
		}

		eventPeopleByEventID[strconv.Itoa(event_id)] = append(eventPeopleByEventID[strconv.Itoa(event_id)], user)
	}

	output := make([]*dataloader.Result, len(keys))
	if err != nil {
		log.Printf("Error on GetEventFriends(): %s", err)
		for i := range output {
			output[i] = &dataloader.Result{Data: []*ent.User{}, Error: nil}
		}
		return output
	}

	for index, eventKey := range keys {
		users, ok := eventPeopleByEventID[eventKey.String()]
		if ok {
			output[index] = &dataloader.Result{Data: users, Error: nil}
		} else {
			output[index] = &dataloader.Result{Data: []*ent.User{}, Error: nil}
		}
	}

	return output
}

func GetEventUsersStatus(ctx context.Context, keys dataloader.Keys) []*dataloader.Result {

	client := utils.Client
	eventId, _ := utils.GetEventIdFromHeader(ctx)

	userIDs := make([]int, 0, len(keys))
	for _, key := range keys {
		keyToInt, _ := strconv.Atoi(key.String())
		userIDs = append(userIDs, keyToInt)
	}

	res, err := client.EventUser.Query().
		Where(
			eventuser.And(
				eventuser.EventID(*eventId),
				eventuser.UserIDIn(userIDs...),
			),
		).
		Select(eventuser.FieldUserID, eventuser.FieldConfirmed).
		All(ctx)

	output := make([]*dataloader.Result, len(keys))
	if err != nil {
		for i := range output {
			output[i] = &dataloader.Result{Data: model.EventUserStatusNotInvited, Error: nil}
		}
		return output
	}

	eventUserStatusByUserId := map[string]model.EventUserStatus{}
	for _, eu := range res {
		if eu.Confirmed {
			eventUserStatusByUserId[strconv.Itoa(eu.UserID)] = model.EventUserStatusConfirmed
		} else {
			eventUserStatusByUserId[strconv.Itoa(eu.UserID)] = model.EventUserStatusInvited
		}
	}

	for index, userKey := range keys {
		eventUserStatus, ok := eventUserStatusByUserId[userKey.String()]
		if ok {
			output[index] = &dataloader.Result{Data: eventUserStatus, Error: nil}
		} else {
			output[index] = &dataloader.Result{Data: model.EventUserStatusNotInvited, Error: nil}
		}
	}

	return output
}

// Loaders wrap your data loaders to inject via middleware
type Loaders struct {
	UserLoader            *dataloader.Loader
	FollowStateLoader     *dataloader.Loader
	FriendsLoader         *dataloader.Loader
	EventUserStatusLoader *dataloader.Loader
}

// NewLoaders instantiates data loaders for the middleware
func NewDataLoader() *Loaders {
	loaders := &Loaders{
		UserLoader:            dataloader.NewBatchedLoader(GetUsers, dataloader.WithClearCacheOnBatch()),
		FollowStateLoader:     dataloader.NewBatchedLoader(GetFollowStates, dataloader.WithClearCacheOnBatch()),
		FriendsLoader:         dataloader.NewBatchedLoader(GetEventFriends, dataloader.WithClearCacheOnBatch()),
		EventUserStatusLoader: dataloader.NewBatchedLoader(GetEventUsersStatus, dataloader.WithClearCacheOnBatch()),
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

func GetFriends(ctx context.Context, eventID string) ([]*ent.User, error) {
	loaders := For(ctx)
	thunk := loaders.FriendsLoader.Load(ctx, dataloader.StringKey(eventID))
	result, err := thunk()
	if err != nil {
		return []*ent.User{}, err
	}
	return result.([]*ent.User), nil
}

func GetEventUserStatus(ctx context.Context, userID string) (model.EventUserStatus, error) {
	loaders := For(ctx)
	thunk := loaders.EventUserStatusLoader.Load(ctx, dataloader.StringKey(userID))
	result, err := thunk()
	if err != nil {
		return model.EventUserStatusNotInvited, err
	}
	return result.(model.EventUserStatus), nil
}
