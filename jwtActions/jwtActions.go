package jwtActions

import (
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

	accessT := jwt.New(jwt.SigningMethodRS256)
	refreshT := jwt.New(jwt.SigningMethodRS256)

	iat := time.Now()
	exp := iat.Add(time.Hour * 24)

	userId := user.ID
	username := user.Username
	roles := []string{"user"}

	payload := &JWTPayload{
		&jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(exp),
			IssuedAt:  jwt.NewNumericDate(iat),
		},
		strconv.Itoa(userId),
		username,
		roles,
	}

	accessT.Claims = payload
	refreshT.Claims = payload

	accessKey, _ := jwt.ParseRSAPrivateKeyFromPEM(privAKey)
	accessToken, _ := accessT.SignedString(accessKey)

	refreshKey, _ := jwt.ParseRSAPrivateKeyFromPEM(privRKey)
	refreshToken, _ := refreshT.SignedString(refreshKey)

	return &model.TokenResponse{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}
}
