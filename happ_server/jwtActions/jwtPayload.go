package jwtActions

import "github.com/golang-jwt/jwt/v4"

type JWTPayload struct {
	*jwt.RegisteredClaims
	Id        string
	RandomInt string
	Roles     []string
}
