package awsS3

import (
	"context"
	"happ/config"
	awsUtils "happ/utils/aws"
	"io"
	"log"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/s3/types"
)

func UploadToS3(key string, body io.Reader) bool {

	var bucket *string

	if config.C.AppEnv == "prod" {
		bucket = aws.String("happ-prod-bucket")
	} else if config.C.AppEnv == "dev" {
		bucket = aws.String("happ-dev-bucket")
	}

	uploader := manager.NewUploader(awsUtils.S3Client)
	_, err := uploader.Upload(context.TODO(), &s3.PutObjectInput{
		Bucket: bucket,
		Key:    aws.String(key),
		Body:   body,
	})

	log.Println(err)

	return err == nil
}

func DeleteFromS3(objectKeys []string) bool {

	var objectIds []types.ObjectIdentifier
	for _, key := range objectKeys {
		objectIds = append(objectIds, types.ObjectIdentifier{Key: aws.String(key)})
	}

	var bucket *string

	if config.C.AppEnv == "prod" {
		bucket = aws.String("happ-prod-bucket")
	} else if config.C.AppEnv == "dev" {
		bucket = aws.String("happ-dev-bucket")
	}

	_, err := awsUtils.S3Client.DeleteObjects(context.TODO(), &s3.DeleteObjectsInput{
		Bucket: bucket,
		Delete: &types.Delete{Objects: objectIds},
	})
	return err == nil
}
