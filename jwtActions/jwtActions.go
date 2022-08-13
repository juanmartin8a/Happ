package jwtActions

import (
	"happ/ent"
	"strconv"
	"time"

	"github.com/golang-jwt/jwt/v4"
)

func CreateToken(sub string, user *ent.User) { //(string, error) {
	token := jwt.New(jwt.GetSigningMethod("RS256"))
	// Choose an expiration time. Shorter the better
	iat := time.Now()
	exp := iat.Add(time.Hour * 24)

	userId := user.ID
	username := user.Username
	roles := []string{"user"}
	// Add your claims
	token.Claims = &JWTPayload{
		&jwt.RegisteredClaims{
			// Set the exp and sub claims. sub is usually the userID
			ExpiresAt: jwt.NewNumericDate(exp),
			Subject:   sub,
			IssuedAt:  jwt.NewNumericDate(iat),
		},
		strconv.Itoa(userId),
		username,
		roles,
	}
	// Sign the token with your secret key
	// val, err := token.SignedString()

	// if err != nil {
	// 	// On error return the error
	// 	return "", err
	// }
	// // On success return the token string
	// return val, nil
}
