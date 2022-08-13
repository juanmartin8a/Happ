package jwtActions

import "github.com/golang-jwt/jwt/v4"

type JWTPayload struct {
	*jwt.RegisteredClaims
	id       string
	username string
	roles    []string
}
