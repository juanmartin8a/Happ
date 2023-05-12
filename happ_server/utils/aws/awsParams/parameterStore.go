package awsParameterStore

import (
	"context"
	"encoding/base64"
	awsUtils "happ/utils/aws"
	"log"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/kms"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
)

type KeysResGoroutine struct {
	Value *string
	Error error
}

func GetParamTypeSecretString(name string) ([]byte, error) {

	parameterOutput, err := awsUtils.SSMClient.GetParameter(context.TODO(), &ssm.GetParameterInput{
		Name:           aws.String(name),
		WithDecryption: aws.Bool(true),
	})
	if err != nil {
		log.Println("Error while getting parameter: ", err)
		return nil, err
	}

	decoded, err := base64.StdEncoding.DecodeString(*parameterOutput.Parameter.Value)
	if err != nil {
		log.Println("Error while decoding parameter output: ", err)
		return nil, err
	}

	decrypted, err := awsUtils.KMSClient.Decrypt(context.TODO(), &kms.DecryptInput{
		CiphertextBlob: decoded,
	})
	if err != nil {
		log.Println("Error while decrypting decoded parameter output: ", err)
		return nil, err
	}

	return decrypted.Plaintext, nil
}

func GetEventKeyParameter(name string) (*string, error) {
	bytes, err := GetParamTypeSecretString(name)
	if err != nil {
		log.Println("Error while calling: GetParamTypeSecretString()", err)
		return nil, err
	}

	decoded, err := base64.StdEncoding.DecodeString(string(bytes))
	if err != nil {
		log.Println("Error while decoding decrypted event key", err)
	}

	plaintext := string(decoded)

	return &plaintext, nil
}

func GetEventKeyParameterGoroutine(name string, c chan KeysResGoroutine) {
	bytes, err := GetParamTypeSecretString(name)
	if err != nil {
		log.Println("Error while calling: GetParamTypeSecretString()", err)
		c <- KeysResGoroutine{
			Value: nil,
			Error: err,
		}
	}

	decoded, err := base64.StdEncoding.DecodeString(string(bytes))
	if err != nil {
		log.Println("Error while decoding decrypted event key", err)
	}

	plaintext := string(decoded)

	c <- KeysResGoroutine{
		Value: &plaintext,
		Error: nil,
	}
}
