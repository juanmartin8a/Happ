package jwtActions

import "github.com/golang-jwt/jwt/v5"

type JWTPayload struct {
	*jwt.RegisteredClaims
	Id        string
	RandomInt string
	Roles     []string
}
