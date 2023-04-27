package awsUtils

import (
	"context"
	"log"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/kms"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
)

func getConfig() (*aws.Config, error) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	return &cfg, nil
}

func GetS3Client() (*s3.Client, error) {
	cfg, err := getConfig()
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	client := s3.NewFromConfig(*cfg)

	return client, nil
}

func GetSSMClient() (*ssm.Client, error) {
	cfg, err := getConfig()
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	svcClient := ssm.NewFromConfig(*cfg)

	return svcClient, nil
}

func GetKMSClient() (*kms.Client, error) {
	cfg, err := getConfig()
	if err != nil {
		log.Printf("error: %v", err)
		return nil, err
	}

	kmsClient := kms.NewFromConfig(*cfg)

	return kmsClient, nil
}
