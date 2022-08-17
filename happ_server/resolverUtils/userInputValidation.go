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

	emailCh := make(chan *model.ErrorResponse)
	usernameCh := make(chan *model.ErrorResponse)
	nameCh := make(chan *model.ErrorResponse)
	passwordCh := make(chan *model.ErrorResponse)

	go validateEmail(input.Email, client, ctx, emailCh)
	go validateUsername(input.Username, client, ctx, usernameCh)
	go validateName(input.Name, nameCh)
	go validatePassword(input.Password, passwordCh)

	emailError, usernameError, nameError, passwordError := <-emailCh, <-usernameCh, <-nameCh, <-passwordCh
	if emailError.Field != "" {
		errors = append(errors, emailError)
	}
	if usernameError.Field != "" {
		errors = append(errors, usernameError)
	}
	if nameError.Field != "" {
		errors = append(errors, nameError)
	}
	if passwordError.Field != "" {
		errors = append(errors, passwordError)
	}

	return errors, nil
}

func validateUsername(username string, client *ent.Client, ctx context.Context, c chan *model.ErrorResponse) {

	var hasSpaces bool = false

	if strings.Contains(username, " ") {
		hasSpaces = true
	}

	var errorResponse *model.ErrorResponse = &model.ErrorResponse{}

	if len(username) == 0 {
		errorResponse = &model.ErrorResponse{
			Field:   "username",
			Message: "Username must not be empty",
		}
	} else if len(username) < 2 {
		errorResponse = &model.ErrorResponse{
			Field:   "username",
			Message: "Username must have at least 2 characters",
		}
	} else if hasSpaces {
		errorResponse = &model.ErrorResponse{
			Field:   "username",
			Message: "Username must not have any spaces",
		}
	} else if len(username) > 20 {
		errorResponse = &model.ErrorResponse{
			Field:   "username",
			Message: "Username must have no more than 20 characters",
		}
	} else if username != strings.ToLower(username) {
		errorResponse = &model.ErrorResponse{
			Field:   "username",
			Message: "Username must be in lower case only",
		}
	}

	if errorResponse.Field == "" {
		_, err := client.User.Query().Where(user.Username(username)).Only(ctx)

		if err == nil {
			errorResponse = &model.ErrorResponse{
				Field:   "username",
				Message: "Username already in use",
			}
		}
	}

	c <- errorResponse
}

func validateName(name string, c chan *model.ErrorResponse) {

	var errorResponse *model.ErrorResponse = &model.ErrorResponse{}

	if len(name) == 0 {
		errorResponse = &model.ErrorResponse{
			Field:   "name",
			Message: "Name must not be empty",
		}
	} else if len(name) < 2 {
		errorResponse = &model.ErrorResponse{
			Field:   "name",
			Message: "Name must have at least 2 characters",
		}
	} else if len(name) > 30 {
		errorResponse = &model.ErrorResponse{
			Field:   "name",
			Message: "Name must have no more than 30 characters",
		}
	}

	c <- errorResponse
}

func validateEmail(email string, client *ent.Client, ctx context.Context, c chan *model.ErrorResponse) {

	var errorResponse *model.ErrorResponse = &model.ErrorResponse{}

	_, err := mail.ParseAddress(email)

	if err != nil {
		errorResponse = &model.ErrorResponse{
			Field:   "email",
			Message: "Invalid Email",
		}
	}

	if errorResponse.Field == "" {
		_, e := client.User.Query().Where(user.Email(email)).Only(ctx)

		if e == nil {
			errorResponse = &model.ErrorResponse{
				Field:   "email",
				Message: "Email already in use",
			}
		}
	}

	c <- errorResponse
}

func validatePassword(password string, c chan *model.ErrorResponse) {

	var errorResponse *model.ErrorResponse = &model.ErrorResponse{}

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

	if !hasNumber || !hasLetter {
		errorResponse = &model.ErrorResponse{
			Field:   "password",
			Message: "Password must have at least 8 letters or numbers",
		}
	}

	if strings.Contains(password, " ") {
		hasSpaces = true
	}

	if hasSpaces {
		errorResponse = &model.ErrorResponse{
			Field:   "password",
			Message: "Password must not have any spaces",
		}
	}

	c <- errorResponse
}

// func SignUpInputValidator(input model.SignUpInput, client *ent.Client, ctx context.Context) ([]*model.ErrorResponse, error) {
// 	var errors []*model.ErrorResponse

// 	emailError, _ := validateEmail(input.Email, client, ctx)
// 	if emailError.Field != "" {
// 		errors = append(errors, emailError)
// 	}

// 	usernameError, _ := validateUsername(input.Username, client, ctx)
// 	if usernameError.Field != "" {
// 		errors = append(errors, usernameError)
// 	}

// 	userExistsError, _ := validateName(input.Name)
// 	if userExistsError.Field != "" {
// 		errors = append(errors, userExistsError)
// 	}

// 	passwordError, _ := validatePassword(input.Password)
// 	if passwordError.Field != "" {
// 		errors = append(errors, passwordError)
// 	}

// 	return errors, nil
// }

// func validateUsername(username string, client *ent.Client, ctx context.Context) (*model.ErrorResponse, error) {

// 	var hasSpaces bool = false

// 	if strings.Contains(username, " ") {
// 		hasSpaces = true
// 	}

// 	if len(username) == 0 {
// 		return &model.ErrorResponse{
// 			Field:   "username",
// 			Message: "Username must not be empty",
// 		}, nil
// 	} else if len(username) < 2 {
// 		return &model.ErrorResponse{
// 			Field:   "username",
// 			Message: "Username must have at least 2 characters",
// 		}, nil
// 	} else if hasSpaces {
// 		return &model.ErrorResponse{
// 			Field:   "username",
// 			Message: "Username must not have any spaces",
// 		}, nil
// 	} else if len(username) > 20 {
// 		return &model.ErrorResponse{
// 			Field:   "username",
// 			Message: "Username must have no more than 20 characters",
// 		}, nil
// 	} else if username != strings.ToLower(username) {
// 		return &model.ErrorResponse{
// 			Field:   "username",
// 			Message: "Username must be in lower case only",
// 		}, nil
// 	}

// 	_, err := client.User.Query().Where(user.Username(username)).Only(ctx)

// 	if err == nil {
// 		return &model.ErrorResponse{
// 			Field:   "username",
// 			Message: "Username already in use",
// 		}, nil
// 	}

// 	return &model.ErrorResponse{}, nil
// }

// func validateName(name string) (*model.ErrorResponse, error) {

// 	if len(name) == 0 {
// 		return &model.ErrorResponse{
// 			Field:   "name",
// 			Message: "Name must not be empty",
// 		}, nil
// 	} else if len(name) < 2 {
// 		return &model.ErrorResponse{
// 			Field:   "name",
// 			Message: "Name must have at least 2 characters",
// 		}, nil
// 	} else if len(name) > 30 {
// 		return &model.ErrorResponse{
// 			Field:   "name",
// 			Message: "Name must have no more than 30 characters",
// 		}, nil
// 	}

// 	return &model.ErrorResponse{}, nil
// }

// func validateEmail(email string, client *ent.Client, ctx context.Context) (*model.ErrorResponse, error) {
// 	_, err := mail.ParseAddress(email)

// 	if err != nil {
// 		return &model.ErrorResponse{
// 			Field:   "email",
// 			Message: "Invalid Email",
// 		}, nil
// 	}

// 	_, e := client.User.Query().Where(user.Email(email)).Only(ctx)

// 	if e == nil {
// 		return &model.ErrorResponse{
// 			Field:   "email",
// 			Message: "Email already in use",
// 		}, nil
// 	}

// 	return &model.ErrorResponse{}, nil
// }

// func validatePassword(password string) (*model.ErrorResponse, error) {

// 	var hasNumber bool = false
// 	var hasLetter bool = false
// 	var hasSpaces bool = false

// 	for _, char := range password {
// 		switch {
// 		case unicode.IsNumber(char):
// 			hasNumber = true
// 		case unicode.IsLetter(char):
// 			hasLetter = true
// 		}
// 	}

// 	if !hasNumber || !hasLetter {
// 		return &model.ErrorResponse{
// 			Field:   "password",
// 			Message: "Password must have at least 8 letters or numbers",
// 		}, nil
// 	}

// 	if strings.Contains(password, " ") {
// 		hasSpaces = true
// 	}

// 	if hasSpaces {
// 		return &model.ErrorResponse{
// 			Field:   "password",
// 			Message: "Password must not have any spaces",
// 		}, nil
// 	}

// 	return &model.ErrorResponse{}, nil
// }
