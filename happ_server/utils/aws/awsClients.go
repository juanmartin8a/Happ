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
			config.WithRegion("us-east-2"),
		)
		if err != nil {
			log.Printf("error: %v", err)
			return nil, err
		}

		cfg = preCFG
	}

	return &cfg, nil
}

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
