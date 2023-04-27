package redisUtils

import "github.com/go-redis/redis/v9"

var RedisClient *redis.Client

func GetRedisClient() *redis.Client {
	return redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})
}
