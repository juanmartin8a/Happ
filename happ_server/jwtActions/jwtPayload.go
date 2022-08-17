package jwtActions

import "github.com/golang-jwt/jwt/v4"

type JWTPayload struct {
	*jwt.RegisteredClaims
	Id       string
	Username string
	Roles    []string
}
