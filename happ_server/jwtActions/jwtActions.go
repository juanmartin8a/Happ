package jwtActions

import (
	"fmt"
	"happ/graph/model"
	redisUtils "happ/utils/redis"
	"io/ioutil"
	"math/rand"
	"path/filepath"
	"strconv"
	"time"

	"github.com/golang-jwt/jwt/v4"
)

func CreateTokens(userId string, prevRefreshToken string) *model.TokenResponse { //user *ent.User

	accessDir, _ := filepath.Abs("./keys/access/rsa_private.pem")
	refreshDir, _ := filepath.Abs("./keys/refresh/rsa_private.pem")

	privAKey, _ := ioutil.ReadFile(accessDir)
	privRKey, _ := ioutil.ReadFile(refreshDir)

	timeToExpAccess := time.Second * 60 * 60 * 24
	timeToExpRefresh := time.Second * 60 * 60 * 24 * 3

	iat := time.Now()
	expAccess := iat.Add(timeToExpAccess)
	expRefresh := iat.Add(timeToExpRefresh)

	// userIdString := strconv.Itoa(userId)
	randomInt := rand.Intn(9999-0+1) + 0
	roles := []string{"user"}

	payloadAccess := &JWTPayload{
		RegisteredClaims: &jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(expAccess),
			IssuedAt:  jwt.NewNumericDate(iat),
		},
		Id:        userId,
		RandomInt: strconv.Itoa(randomInt),
		Roles:     roles,
	}

	payloadRefresh := &JWTPayload{
		RegisteredClaims: &jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(expRefresh),
			IssuedAt:  jwt.NewNumericDate(iat),
		},
		Id:        userId,
		RandomInt: strconv.Itoa(randomInt),
		Roles:     roles,
	}

	accessT := jwt.NewWithClaims(jwt.SigningMethodRS256, payloadAccess)
	refreshT := jwt.NewWithClaims(jwt.SigningMethodRS256, payloadRefresh)

	accessKey, _ := jwt.ParseRSAPrivateKeyFromPEM(privAKey)
	refreshKey, _ := jwt.ParseRSAPrivateKeyFromPEM(privRKey)

	accessToken, _ := accessT.SignedString(accessKey)
	refreshToken, _ := refreshT.SignedString(refreshKey)

	redisUtils.RefreshTokenToRedis(userId, timeToExpAccess, refreshToken)

	if prevRefreshToken != "" {
		redisUtils.DeleteTokenFromRedis("" + userId + "_" + prevRefreshToken)
	}

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
