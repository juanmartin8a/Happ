package awsS3

import (
	"context"
	"fmt"
	awsUtils "happ/utils/aws"
	"io"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/s3/types"
)

func UploadToS3(key string, body io.Reader) bool {
	client, err := awsUtils.GetS3Client()
	if err != nil {
		fmt.Println(err)
		return false
	}

	uploader := manager.NewUploader(client)
	_, err = uploader.Upload(context.TODO(), &s3.PutObjectInput{
		Bucket: aws.String("happ-dev-bucket"),
		Key:    aws.String(key),
		Body:   body,
	})

	fmt.Println(err)

	return err == nil
}

func DeleteFromS3(objectKeys []string) bool {
	client, err := awsUtils.GetS3Client()
	if err != nil {
		fmt.Println(err)
		return false
	}

	var objectIds []types.ObjectIdentifier
	for _, key := range objectKeys {
		objectIds = append(objectIds, types.ObjectIdentifier{Key: aws.String(key)})
	}
	_, err = client.DeleteObjects(context.TODO(), &s3.DeleteObjectsInput{
		Bucket: aws.String("happ-dev-bucket"),
		Delete: &types.Delete{Objects: objectIds},
	})
	return err == nil
}
