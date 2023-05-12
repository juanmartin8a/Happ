package awsUtils

import (
	"context"
	otherConfig "happ/config"
	"log"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/kms"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
)

var S3Client *s3.Client
var SSMClient *ssm.Client
var KMSClient *kms.Client

func getConfig() (*aws.Config, error) {

	appEnv := otherConfig.C.AppEnv

	var cfg aws.Config

	if appEnv == "dev" {
		region := os.Getenv("AWS_REGION")
		accessKeyID := os.Getenv("AWS_ACCESS_KEY_ID")
		secretAccessKey := os.Getenv("AWS_SECRET_ACCESS_KEY")
		sessionToken := os.Getenv("AWS_SESSION_TOKEN")

		creds := credentials.NewStaticCredentialsProvider(accessKeyID, secretAccessKey, sessionToken)
		preCFG, err := config.LoadDefaultConfig(
			context.TODO(),
			config.WithRegion(region),
			config.WithCredentialsProvider(creds),
		)
		if err != nil {
			log.Printf("error: %v", err)
			return nil, err
		}

		cfg = preCFG
	} else if appEnv == "prod" {
		preCFG, err := config.LoadDefaultConfig(
			context.TODO(),
		)
		if err != nil {
			log.Printf("error: %v", err)
			return nil, err
		}

		cfg = preCFG
	}

	return &cfg, nil
}

// docker run -e AWS_ACCESS_KEY_ID=ASIARUUUWHRHV5LJLQB2 -e AWS_SECRET_ACCESS_KEY=BVZTfrgGxd/iUfyiAF5IWBIFvdBZUcBk4AfAaqnM -e AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEHsaCXVzLWVhc3QtMiJIMEYCIQCpSpqYXZfyMDrfwQnKNdRs0Y7zWtZuQhvvrbl6X8U7kwIhAIyLUfnnc7KyKxsKggOwlWbGzF05pm8h/UkMi2SDyECEKqACCJT//////////wEQARoMMTEzMDU0NzI3MjQ3IgwXqfe++5MSu3kZ6UEq9AG56/EBLSTXWtAUIW0Flml3biMwf+mpr1AiP0HXlFRIWcJ4/8fHhh/c4c8ngZYzdV6PWYw2diq+PttMB1oPGFwsAg916EVeQfmg0/GxosFuRTCDf5GpRTVHRheyCGISd1Tae91/IcwFGJoYVwgPx7ccUjnoixE0I6sns6xObj02MwSR/I6oGL/RITaXsZwNlVFkPgz0QpAKls0+aYoMHpnlwGPDyt1nbo5QZt+d5XeOj7Gu1Xyt+UoJF9fLKV8/xx1k0vLM9PqyQ1g/qX3mq6N1KqyOkM9xPRx89fUR3cN0zBujhKCAyJqwwg6UUixq+5VOynk3MPzQ76IGOpwBQe66Z7B0Kew76I7pxr/7jEieRaglrs3buX4R0o2C4nFnM2NpMR/KtLBFXbEAJzeoqfx5fsGwyhJTdLzcybPBhQrH+7WMHw3AGbv7faggrskkArfvmE/FMLMCaB10InTGFEgoIwm87szuOC2MiGLD6838ev2w7zdKPN3Te0LlovxXWqN9GYiBqimtV32ZVlsqLwGIJgjNgtn+D7R7" happ_server

func GetS3Client() (*s3.Client, error) {
	cfg, err := getConfig()
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	S3Client = s3.NewFromConfig(*cfg)

	return S3Client, nil
}

func GetSSMClient() (*ssm.Client, error) {
	cfg, err := getConfig()
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	SSMClient = ssm.NewFromConfig(*cfg)

	return SSMClient, nil
}

func GetKMSClient() (*kms.Client, error) {
	cfg, err := getConfig()
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	KMSClient = kms.NewFromConfig(*cfg)

	return KMSClient, nil
}
