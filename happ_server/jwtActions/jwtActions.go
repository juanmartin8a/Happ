package jwtActions

// import (
// 	"fmt"
// 	"happ/graph/model"
// 	awsParameterStore "happ/utils/aws/awsParams"
// 	redisUtils "happ/utils/redis"
// 	"math/rand"
// 	"strconv"
// 	"time"

// 	"github.com/golang-jwt/jwt/v5"
// )

// // func CreateTokens(userId string, prevRefreshToken string) *model.TokenResponse { //user *ent.User

// // 	// var keyName string
// // 	// if !prevRefreshToken {
// // 	// 	keyName = "Happ_dev_access_priv_key"
// // 	// } else {
// // 	// 	keyName = "Happ_dev_refresh_priv_key"
// // 	// }

// // 	privAccessKey, err := awsParameterStore.GetRSAPrivKeyParam("Happ_dev_access_priv_key")
// // 	if err != nil {
// // 		// return nil, fmt.Errorf("Error while GetRSAPrivKeyParam: %w", err)
// // 		return &model.TokenResponse{}
// // 	}

// // 	privRefreshKey, err := awsParameterStore.GetRSAPrivKeyParam("Happ_dev_refresh_priv_key")
// // 	if err != nil {
// // 		return &model.TokenResponse{}
// // 		// return nil, fmt.Errorf("Error while GetRSAPrivKeyParam: %w", err)
// // 	}

// // 	// key, err := jwt.ParseRSAPublicKeyFromPEM(pubKey)
// // 	// if err != nil {
// // 	// 	return nil, fmt.Errorf("validate: parse key: %w", err)
// // 	// }

// // 	// accessDir, _ := filepath.Abs("./keys/access/rsa_private.pem")
// // 	// refreshDir, _ := filepath.Abs("./keys/refresh/rsa_private.pem")

// // 	// privAKey, _ := ioutil.ReadFile(accessDir)
// // 	// privRKey, _ := ioutil.ReadFile(refreshDir)

// // 	timeToExpAccess := time.Second * 60 * 60 * 24
// // 	timeToExpRefresh := time.Second * 60 * 60 * 24 * 3

// // 	iat := time.Now()
// // 	expAccess := iat.Add(timeToExpAccess)
// // 	expRefresh := iat.Add(timeToExpRefresh)

// // 	// userIdString := strconv.Itoa(userId)
// // 	randomInt := rand.Intn(9999-0+1) + 0
// // 	roles := []string{"user"}

// // 	payloadAccess := &JWTPayload{
// // 		RegisteredClaims: &jwt.RegisteredClaims{
// // 			ExpiresAt: jwt.NewNumericDate(expAccess),
// // 			IssuedAt:  jwt.NewNumericDate(iat),
// // 		},
// // 		Id:        userId,
// // 		RandomInt: strconv.Itoa(randomInt),
// // 		Roles:     roles,
// // 	}

// // 	payloadRefresh := &JWTPayload{
// // 		RegisteredClaims: &jwt.RegisteredClaims{
// // 			ExpiresAt: jwt.NewNumericDate(expRefresh),
// // 			IssuedAt:  jwt.NewNumericDate(iat),
// // 		},
// // 		Id:        userId,
// // 		RandomInt: strconv.Itoa(randomInt),
// // 		Roles:     roles,
// // 	}

// // 	accessT := jwt.NewWithClaims(jwt.SigningMethodRS256, payloadAccess)
// // 	refreshT := jwt.NewWithClaims(jwt.SigningMethodRS256, payloadRefresh)

// // 	accessToken, _ := accessT.SignedString(privAccessKey)
// // 	refreshToken, _ := refreshT.SignedString(privRefreshKey)

// // 	err = redisUtils.RefreshTokenToRedis(userId, timeToExpRefresh, refreshToken)
// // 	if err != nil {
// // 		return &model.TokenResponse{}
// // 	}

// // 	if prevRefreshToken != "" {
// // 		err = redisUtils.DeleteTokenFromRedis("" + userId + "_" + prevRefreshToken)
// // 		if err != nil {
// // 			fmt.Println("Error deleting token from redis")
// // 		}
// // 	}

// // 	return &model.TokenResponse{
// // 		AccessToken:  accessToken,
// // 		RefreshToken: refreshToken,
// // 	}
// // }

// func ValidateToken(token string, isRefresh bool) (jwt.MapClaims, error) {

// 	// keyDir, _ := filepath.Abs("./keys/access/rsa_public.pem")

// 	// if isRefresh {
// 	// 	keyDir, _ = filepath.Abs("./keys/refresh/rsa_public.pem")
// 	// }

// 	// pubKey, _ := ioutil.ReadFile(keyDir)
// 	var keyName string
// 	if !isRefresh {
// 		keyName = "Happ_dev_access_pub_key"
// 	} else {
// 		keyName = "Happ_dev_refresh_pub_key"
// 	}

// 	pubKey, err := awsParameterStore.GetRSAPubKeyParam(keyName)
// 	if err != nil {
// 		fmt.Println("Error while GetRSAPubKeyParam: %w", err)
// 		return nil, fmt.Errorf("error while GetRSAPubKeyParam: %w", err)
// 	}

// 	key, err := jwt.ParseRSAPublicKeyFromPEM(pubKey)
// 	if err != nil {
// 		fmt.Println("validate: parse key: %w", err)
// 		return nil, fmt.Errorf("validate: parse key: %w", err)
// 	}

// 	tokenPayload, err := jwt.Parse(token, func(token *jwt.Token) (interface{}, error) {
// 		// Verify the signing algorithm and extract the RSA public key for verification
// 		if _, ok := token.Method.(*jwt.SigningMethodRSA); !ok {
// 			fmt.Printf("unexpected signing method: %v", token.Header["alg"])
// 			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
// 		}
// 		return key, nil
// 	})

// 	if err != nil {
// 		return nil, fmt.Errorf("validate: %w", err)
// 	}

// 	payload, ok := tokenPayload.Claims.(jwt.MapClaims) //(*JWTPayload)
// 	if !ok || !tokenPayload.Valid {
// 		return nil, fmt.Errorf("validate: invalid")
// 	}

// 	return payload, nil
// }
