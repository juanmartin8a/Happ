package awsS3

import (
	"context"
	"io"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

func UploadToS3(key string, body io.Reader) bool {
	client, err := getS3Client()
	if err != nil {
		return false
	}

	uploader := manager.NewUploader(client)
	_, err = uploader.Upload(context.TODO(), &s3.PutObjectInput{
		Bucket: aws.String("happ-dev-bucket"),
		Key:    aws.String(key),
		Body:   body,
	})

	return err == nil
}
