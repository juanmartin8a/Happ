package userValidation

import (
	"context"
	"happ/ent"
	"happ/ent/user"
	"happ/graph/model"
	"net/mail"
	"strings"
	"unicode"
)

func SignUpInputValidator(input model.SignUpInput, client *ent.Client, ctx context.Context) ([]*model.ErrorResponse, error) {
	var errors []*model.ErrorResponse

	emailError, _ := validateEmail(input.Email, client, ctx)
	if emailError.Field != "" {
		errors = append(errors, emailError)
	}

	usernameError, _ := validateUsername(input.Username, client, ctx)
	if usernameError.Field != "" {
		errors = append(errors, usernameError)
	}

	userExistsError, _ := validateName(input.Name)
	if userExistsError.Field != "" {
		errors = append(errors, userExistsError)
	}

	passwordError, _ := validatePassword(input.Password)
	if passwordError.Field != "" {
		errors = append(errors, passwordError)
	}

	return errors, nil
}

func validateUsername(username string, client *ent.Client, ctx context.Context) (*model.ErrorResponse, error) {

	var hasSpaces bool = false

	if strings.Contains(username, " ") {
		hasSpaces = true
	}

	if len(username) == 0 {
		return &model.ErrorResponse{
			Field:   "username",
			Message: "Username must not be empty",
		}, nil
	} else if len(username) < 2 {
		return &model.ErrorResponse{
			Field:   "username",
			Message: "Username must have at least 2 characters",
		}, nil
	} else if hasSpaces {
		return &model.ErrorResponse{
			Field:   "username",
			Message: "Username must not have any spaces",
		}, nil
	} else if len(username) > 20 {
		return &model.ErrorResponse{
			Field:   "username",
			Message: "Username must have no more than 20 characters",
		}, nil
	} else if username != strings.ToLower(username) {
		return &model.ErrorResponse{
			Field:   "username",
			Message: "Username must be in lower case only",
		}, nil
	}

	_, err := client.User.Query().Where(user.Username(username)).Only(ctx)

	if err == nil {
		return &model.ErrorResponse{
			Field:   "username",
			Message: "Username already in use",
		}, nil
	}

	return &model.ErrorResponse{}, nil
}

func validateName(name string) (*model.ErrorResponse, error) {

	if len(name) == 0 {
		return &model.ErrorResponse{
			Field:   "name",
			Message: "Name must not be empty",
		}, nil
	} else if len(name) < 2 {
		return &model.ErrorResponse{
			Field:   "name",
			Message: "Name must have at least 2 characters",
		}, nil
	} else if len(name) > 30 {
		return &model.ErrorResponse{
			Field:   "name",
			Message: "Name must have no more than 30 characters",
		}, nil
	}

	return &model.ErrorResponse{}, nil
}

func validateEmail(email string, client *ent.Client, ctx context.Context) (*model.ErrorResponse, error) {
	_, err := mail.ParseAddress(email)

	if err != nil {
		return &model.ErrorResponse{
			Field:   "email",
			Message: "Invalid Email",
		}, nil
	}

	_, e := client.User.Query().Where(user.Email(email)).Only(ctx)

	if e == nil {
		return &model.ErrorResponse{
			Field:   "email",
			Message: "Email already in use",
		}, nil
	}

	return &model.ErrorResponse{}, nil
}

func validatePassword(password string) (*model.ErrorResponse, error) {

	var hasNumber bool = false
	var hasLetter bool = false
	var hasSpaces bool = false

	for _, char := range password {
		switch {
		case unicode.IsNumber(char):
			hasNumber = true
		case unicode.IsLetter(char):
			hasLetter = true
		}
	}

	if hasNumber == false || hasLetter == false {
		return &model.ErrorResponse{
			Field:   "password",
			Message: "Password must have at least 8 letters or numbers",
		}, nil
	}

	if strings.Contains(password, " ") {
		hasSpaces = true
	}

	if hasSpaces {
		return &model.ErrorResponse{
			Field:   "password",
			Message: "Password must not have any spaces",
		}, nil
	}

	return &model.ErrorResponse{}, nil
}
