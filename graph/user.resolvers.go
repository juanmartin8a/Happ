package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"happ/ent"
	"happ/ent/user"
	"happ/graph/generated"
	"happ/graph/model"
	"happ/hash"
	"log"
	"strconv"
	"time"
)

// SignUp is the resolver for the signUp field.
func (r *mutationResolver) SignUp(ctx context.Context, input model.SignUpInput) (*ent.User, error) {
	fmt.Println(input)
	// panic(fmt.Errorf("not implemented"))
	msInt, err := strconv.ParseInt(input.Birthday, 10, 64)
	if err != nil {
		log.Fatal(err)
	}
	birthday := time.Unix(0, msInt*int64(time.Millisecond))
	fmt.Println(birthday)
	// panic(fmt.Errorf("not implemented"))

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

	print(encodedHash)

	// panic(fmt.Errorf("not implemented"))

	return r.client.User.Create().
		SetName(input.Name).
		SetUsername(input.Username).
		SetEmail(input.Email).
		SetBirthday(birthday).
		SetPassword(encodedHash).
		Save(ctx)
}

// User is the resolver for the user field.
func (r *queryResolver) User(ctx context.Context, username string) (*ent.User, error) {
	return r.client.User.Query().Where(user.Username(username)).Only(ctx)
}

// Birthday is the resolver for the birthday field.
func (r *userResolver) Birthday(ctx context.Context, obj *ent.User) (string, error) {
	panic(fmt.Errorf("not implemented"))
}

// CreatedAt is the resolver for the createdAt field.
func (r *userResolver) CreatedAt(ctx context.Context, obj *ent.User) (string, error) {
	panic(fmt.Errorf("not implemented"))
}

// UpdatedAt is the resolver for the updatedAt field.
func (r *userResolver) UpdatedAt(ctx context.Context, obj *ent.User) (string, error) {
	panic(fmt.Errorf("not implemented"))
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
