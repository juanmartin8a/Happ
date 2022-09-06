package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"happ/ent"
	"happ/ent/follow"
	"happ/ent/friendship"
	"happ/ent/predicate"
	"happ/ent/user"
	"happ/graph/generated"
	"happ/graph/model"
	"happ/hash"
	"happ/jwtActions"
	userValidation "happ/resolverUtils"
	"happ/utils"
	meilisearchUtils "happ/utils/meilisearch"
	redisUtils "happ/utils/redis"
	"log"
	"net/mail"
	"strconv"
	"strings"
	"time"
)

// SignUp is the resolver for the signUp field.
func (r *mutationResolver) SignUp(ctx context.Context, input model.SignUpInput) (*model.UserAuthResponse, error) {
	errors, _ := userValidation.SignUpInputValidator(input, r.client, ctx)

	if len(errors) > 0 {
		return &model.UserAuthResponse{
			Errors: errors,
		}, nil
	}

	msInt, _ := strconv.ParseInt(input.Birthday, 10, 64)
	birthday := time.Unix(0, msInt*int64(time.Millisecond))

	p := &hash.Params{
		Memory:      64 * 1024, // 64 MB
		Iterations:  3,
		Parallelism: 1,
		SaltLength:  16,
		KeyLength:   32,
	}

	encodedHash, err := hash.GenerateHashFromPassword(input.Password, p)
	if err != nil {
		log.Fatal(err)
	}

	user, e := r.client.User.Create().
		SetName(input.Name).
		SetUsername(input.Username).
		SetEmail(input.Email).
		SetBirthday(birthday).
		SetPassword(encodedHash).
		Save(ctx)

	if e != nil {
		errors = append(
			errors,
			&model.ErrorResponse{
				Field:   "global",
				Message: "Could not create user",
			},
		)
		return &model.UserAuthResponse{
			Errors: errors,
		}, nil
	}

	res := meilisearchUtils.AddUserToMeili(user)
	if !res {
		errors = append(
			errors,
			&model.ErrorResponse{
				Field:   "global",
				Message: "Could not create user",
			},
		)
		r.client.User.DeleteOneID(user.ID).Exec(ctx)
		return &model.UserAuthResponse{
			Errors: errors,
		}, nil
	}

	tokens := jwtActions.CreateTokens(strconv.Itoa(user.ID), "")

	fmt.Println(tokens)
	fmt.Println(err)

	return &model.UserAuthResponse{
		User:   user,
		Tokens: tokens,
	}, nil
}

// SignIn is the resolver for the signIn field.
func (r *mutationResolver) SignIn(ctx context.Context, input model.SignInInput) (*model.UserAuthResponse, error) {
	_, err := mail.ParseAddress(input.UsernameOrEmail)

	var whereVal predicate.User

	if err == nil {
		whereVal = user.Email(input.UsernameOrEmail)
	} else {
		whereVal = user.Username(input.UsernameOrEmail)
	}

	user, e := r.client.User.Query().Where(whereVal).Only(ctx)

	fmt.Println(user)

	var errors []*model.ErrorResponse

	if e != nil {
		errors = append(
			errors,
			&model.ErrorResponse{
				Field:   "usernameOrEmail",
				Message: "User Not Found",
			},
		)
		return &model.UserAuthResponse{
			Errors: errors,
		}, nil
	}

	match, _ := hash.VerifyPassword(input.Password, user.Password)

	if !match {
		errors = append(
			errors,
			&model.ErrorResponse{
				Field:   "Password",
				Message: "Incorrect Password",
			},
		)
	}

	if len(errors) > 0 {
		return &model.UserAuthResponse{
			Errors: errors,
		}, nil
	}

	tokens := jwtActions.CreateTokens(strconv.Itoa(user.ID), "")

	return &model.UserAuthResponse{
		User:   user,
		Tokens: tokens,
	}, nil
}

// SignOut is the resolver for the signOut field.
func (r *mutationResolver) SignOut(ctx context.Context, token string) (bool, error) {
	userId, err := utils.IsAuth(ctx)

	if err == nil {
		redisUtils.DeleteTokenFromRedis("" + strconv.Itoa(*userId) + "_" + token)
	}

	return true, nil
}

// RefreshTokens is the resolver for the refreshTokens field.
func (r *mutationResolver) RefreshTokens(ctx context.Context, token string) (*model.TokenResponse, error) {
	// const resJWT = await readJWTPayload(token, true);

	payload, err := jwtActions.ValidateToken(token, true)
	if err != nil {
		return nil, fmt.Errorf("refresh token access denied")
	}

	redisRes := redisUtils.VerifyTokenFromRedis("" + payload["Id"].(string) + "_" + token)
	if !redisRes {
		return nil, fmt.Errorf("refresh token access denied")
	}

	tokens := jwtActions.CreateTokens(payload["Id"].(string), token)

	return tokens, nil
}

// AddOrRemoveUser is the resolver for the addOrRemoveUser field.
func (r *mutationResolver) AddOrRemoveUser(ctx context.Context, followUserID int) (*model.AddResponse, error) {
	userId, _ := utils.GetUserIdFromHeader(ctx)

	// check if follow already exists
	// if follow exists then delete follow
	// 	 if there is a friend relationship delete it too
	// if follow does not exist then create it and if other user follows too then create friendship

	_, err := r.client.Follow.Query().
		Where(follow.FollowerID(*userId)).
		Where(follow.UserID(followUserID)).
		Only(ctx)

	// if error == nil then it means there is no error
	if err == nil {
		// if exists then it means user is unfollowing
		// if friend relationship exists remove it
		_, err = r.client.Friendship.Query().
			Where(
				friendship.And(
					friendship.Or(
						friendship.FriendID(*userId), friendship.UserID(*userId),
					),
					friendship.Or(
						friendship.FriendID(followUserID), friendship.UserID(followUserID),
					),
				),
			).
			// Where(friendship.Or(friendship.FriendID(followUserID), friendship.UserID(followUserID))).
			Only(ctx)

		tx, _ := r.client.Tx(ctx)

		if err == nil {
			// if there is friend relationship then delete it
			_, err = tx.Friendship.
				Delete().
				Where(
					friendship.And(
						friendship.Or(
							friendship.FriendID(*userId), friendship.UserID(*userId),
						),
						friendship.Or(
							friendship.FriendID(followUserID), friendship.UserID(followUserID),
						),
					),
				).
				Exec(ctx)
			if err != nil {
				tx.Rollback()
				return &model.AddResponse{
					Value:    0,
					IsFriend: false,
				}, nil
			}
		}
		_, err = tx.Follow.
			Delete().
			Where(
				follow.And(
					follow.FollowerID(*userId),
					follow.UserID(followUserID),
				),
			).
			// DeleteOne(followRes).
			Exec(ctx)
		if err != nil {
			tx.Rollback()
			return &model.AddResponse{
				Value:    0,
				IsFriend: false,
			}, nil
		}
		tx.Commit()

		return &model.AddResponse{
			Value:    -1,
			IsFriend: false,
		}, nil
	}
	// if it does not exist create it and if the other user follows too crete friend relationship

	_, err = r.client.Follow.Query().
		Where(follow.FollowerID(followUserID)).
		Where(follow.UserID(*userId)).
		Only(ctx)

	tx, _ := r.client.Tx(ctx)

	if err == nil {
		// if other user follows then create friend relationship
		_, err = tx.Friendship.Create().
			SetFriendID(*userId).
			SetUserID(followUserID).
			Save(ctx)
		if err != nil {
			tx.Rollback()
			return &model.AddResponse{
				Value:    0,
				IsFriend: true,
			}, nil
		}
	}

	_, err = tx.Follow.Create().
		SetFollowerID(*userId).
		SetUserID(followUserID).
		Save(ctx)
	if err != nil {
		tx.Rollback()
		return &model.AddResponse{
			Value:    0,
			IsFriend: true,
		}, nil
	}

	tx.Commit()

	return &model.AddResponse{
		Value:    1,
		IsFriend: true,
	}, nil
}

// User is the resolver for the user field.
func (r *queryResolver) User(ctx context.Context, username string) (*ent.User, error) {
	return r.client.User.Query().Where(user.Username(username)).Only(ctx)
}

// UserFromID is the resolver for the userFromId field.
func (r *queryResolver) UserFromID(ctx context.Context, id int) (*ent.User, error) {
	return r.client.User.Query().Where(user.ID(id)).Only(ctx)
}

// SearchUsers is the resolver for the searchUsers field.
func (r *queryResolver) SearchUsers(ctx context.Context, search string) ([]*ent.User, error) {
	trimmedSearch := strings.TrimSpace(search)

	var users []*ent.User
	res, err := meilisearchUtils.GetUsersFromMeili(trimmedSearch)
	if err != nil {
		fmt.Println(res)
		// return nil, err

		// or show empty array of users
		return users, nil
	}

	if len(res) == 0 {
		return users, nil
	}

	for _, user := range res {
		users = append(
			users,
			&ent.User{
				ID:       int(user.(map[string]interface{})["id"].(float64)),
				Username: user.(map[string]interface{})["username"].(string),
				Name:     user.(map[string]interface{})["name"].(string),
			},
		)
	}

	return users, nil
	// panic(fmt.Errorf("not implemented"))
}

// UserAccess is the resolver for the userAccess field.
func (r *queryResolver) UserAccess(ctx context.Context) (*ent.User, error) {
	userId, err := utils.IsAuth(ctx)
	if err != nil {
		return nil, err
	}

	return r.client.User.Query().Where(user.ID(*userId)).Only(ctx)
}

// Birthday is the resolver for the birthday field.
func (r *userResolver) Birthday(ctx context.Context, obj *ent.User) (string, error) {
	birthdayNano := obj.Birthday.UnixNano()

	Birthdaymillis := birthdayNano / 1000000

	birthdayTime := int(Birthdaymillis)

	birthday := strconv.Itoa(birthdayTime)

	return birthday, nil
}

// CreatedAt is the resolver for the createdAt field.
func (r *userResolver) CreatedAt(ctx context.Context, obj *ent.User) (string, error) {
	createdAtNano := obj.CreatedAt.UnixNano()

	createdAtmillis := createdAtNano / 1000000

	createdAtTime := int(createdAtmillis)

	createdAt := strconv.Itoa(createdAtTime)

	return createdAt, nil
}

// UpdatedAt is the resolver for the updatedAt field.
func (r *userResolver) UpdatedAt(ctx context.Context, obj *ent.User) (string, error) {
	updatedAtNano := obj.UpdatedAt.UnixNano()

	updatedAtmillis := updatedAtNano / 1000000

	updatedAtTime := int(updatedAtmillis)

	updatedAt := strconv.Itoa(updatedAtTime)

	return updatedAt, nil
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

// User returns generated.UserResolver implementation.
func (r *Resolver) User() generated.UserResolver { return &userResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
type userResolver struct{ *Resolver }

// !!! WARNING !!!
// The code below was going to be deleted when updating resolvers. It has been copied here so you have
// one last chance to move it out of harms way if you want. There are two reasons this happens:
//  - When renaming or deleting a resolver the old code will be put in here. You can safely delete
//    it when you're done.
//  - You have helper methods in this file. Move them out to keep these resolver files clean.
func (r *userResolver) ID(ctx context.Context, obj *ent.User) (float64, error) {
	panic(fmt.Errorf("not implemented"))
}
