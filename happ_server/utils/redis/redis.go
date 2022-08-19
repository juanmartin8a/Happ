package redisUtils

import (
	"context"
	"encoding/json"
	"time"

	"github.com/go-redis/redis/v9"
)

var ctx = context.Background()

type redisValue struct {
	UserId string
	Token  string
}

func RefreshTokenToRedis(userId string, ex time.Duration, token string) {
	redisClient := GetRedisClient()

	redisValue := &redisValue{
		userId,
		token,
	}

	redisValueToJsonBytes, _ := json.Marshal(redisValue)

	key := "" + userId + "_" + token
	value := string(redisValueToJsonBytes)

	redisClient.SetNX(ctx, key, value, ex).Result()
}

func DeleteTokenFromRedis(key string) {
	redisClient := GetRedisClient()

	redisClient.Del(ctx, key)
}

func VerifyTokenFromRedis(key string) bool {
	redisClient := GetRedisClient()

	_, err := redisClient.Get(ctx, key).Result()

	// if err == redis.Nil {
	// 	return false
	// }

	return err != redis.Nil
}
