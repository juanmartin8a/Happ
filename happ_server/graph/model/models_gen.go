// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

import (
	"happ/ent"
)

type AddResponse struct {
	Value     int  `json:"value"`
	Unchanged bool `json:"unchanged"`
	IsFriend  bool `json:"isFriend"`
}

type ErrorResponse struct {
	Field   string `json:"field"`
	Message string `json:"message"`
}

type SignInInput struct {
	UsernameOrEmail string `json:"usernameOrEmail"`
	Password        string `json:"password"`
}

type SignUpInput struct {
	Name     string `json:"name"`
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
	Birthday string `json:"birthday"`
}

type TokenResponse struct {
	RefreshToken string `json:"refreshToken"`
	AccessToken  string `json:"accessToken"`
}

type UserAuthResponse struct {
	User   *ent.User        `json:"user"`
	Tokens *TokenResponse   `json:"tokens"`
	Errors []*ErrorResponse `json:"errors"`
}
