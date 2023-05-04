package redisUtils

// import (
// 	"context"
// 	"encoding/json"
// 	"time"
// )

// var ctx = context.Background()

// type redisValue struct {
// 	UserId string
// 	Token  string
// }

// func RefreshTokenToRedis(userId string, ex time.Duration, token string) error {
// 	// redisClient := GetRedisClient()

// 	redisValue := &redisValue{
// 		userId,
// 		token,
// 	}

// 	redisValueToJsonBytes, _ := json.Marshal(redisValue)

// 	key := "" + userId + "_" + token
// 	value := string(redisValueToJsonBytes)

// 	_, err := RedisClient.SetNX(ctx, key, value, ex).Result()

// 	return err
// }

// func DeleteTokenFromRedis(key string) error {
// 	// redisClient := GetRedisClient()

// 	_, err := RedisClient.Del(ctx, key).Result()

// 	return err
// }

// func VerifyTokenFromRedis(key string) bool {
// 	// redisClient := GetRedisClient()

// 	_, err := RedisClient.Get(ctx, key).Result()

// 	return err == nil // if redis res has no error return true otherwise false
// }
