package jwtActions

import (
	"fmt"
	"happ/ent"
	"happ/graph/model"
	"io/ioutil"
	"path/filepath"
	"strconv"
	"time"

	"github.com/golang-jwt/jwt/v4"
)

func CreateTokens(user *ent.User) *model.TokenResponse {

	accessDir, _ := filepath.Abs("./keys/access/rsa_private.pem")
	refreshDir, _ := filepath.Abs("./keys/refresh/rsa_private.pem")

	privAKey, _ := ioutil.ReadFile(accessDir)
	privRKey, _ := ioutil.ReadFile(refreshDir)

	iat := time.Now()
	exp := iat.Add(time.Hour * 24)

	userId := user.ID
	username := user.Username
	roles := []string{"user"}

	payload := &JWTPayload{
		RegisteredClaims: &jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(exp),
			IssuedAt:  jwt.NewNumericDate(iat),
		},
		Id:       strconv.Itoa(userId),
		Username: username,
		Roles:    roles,
	}

	accessT := jwt.NewWithClaims(jwt.SigningMethodRS256, payload)
	refreshT := jwt.NewWithClaims(jwt.SigningMethodRS256, payload)

	accessT.Claims = payload
	refreshT.Claims = payload

	accessKey, _ := jwt.ParseRSAPrivateKeyFromPEM(privAKey)
	refreshKey, _ := jwt.ParseRSAPrivateKeyFromPEM(privRKey)

	accessToken, _ := accessT.SignedString(accessKey)
	refreshToken, _ := refreshT.SignedString(refreshKey)

	return &model.TokenResponse{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}
}

func ValidateToken(token string, isRefresh bool) (jwt.MapClaims, error) {

	keyDir, _ := filepath.Abs("./keys/access/rsa_public.pem")

	if isRefresh {
		keyDir, _ = filepath.Abs("./keys/refresh/rsa_public.pem")
	}

	pubKey, _ := ioutil.ReadFile(keyDir)

	key, err := jwt.ParseRSAPublicKeyFromPEM(pubKey)
	if err != nil {
		return nil, fmt.Errorf("validate: parse key: %w", err)
	}

	tokenPayload, err := jwt.Parse(token, func(jwtToken *jwt.Token) (interface{}, error) {
		if _, ok := jwtToken.Method.(*jwt.SigningMethodRSA); !ok {
			return nil, fmt.Errorf("unexpected method: %s", jwtToken.Header["alg"])
		}

		return key, nil
	})

	if err != nil {
		return nil, fmt.Errorf("validate: %w", err)
	}

	payload, ok := tokenPayload.Claims.(jwt.MapClaims) //(*JWTPayload)
	if !ok || !tokenPayload.Valid {
		return nil, fmt.Errorf("validate: invalid")
	}

	return payload, nil
}
