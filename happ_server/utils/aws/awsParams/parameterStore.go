package awsParameterStore

import (
	"context"
	"crypto/rsa"
	"crypto/x509"
	"encoding/base64"
	"encoding/pem"
	"fmt"
	awsUtils "happ/utils/aws"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/kms"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
)

type KeysResGoroutine struct {
	Value *string
	Error error
}

func GetParamTypeSecretString(name string) ([]byte, error) {
	ssmClient, err := awsUtils.GetSSMClient()
	if err != nil {
		fmt.Println("Error while getting SSM Client: ", err)
		return nil, err
	}

	kmsClient, err := awsUtils.GetKMSClient()
	if err != nil {
		fmt.Println("Error while getting KMS Client: ", err)
		return nil, err
	}

	parameterOutput, err := ssmClient.GetParameter(context.TODO(), &ssm.GetParameterInput{
		Name:           aws.String(name),
		WithDecryption: aws.Bool(true),
	})
	if err != nil {
		fmt.Println("Error while getting parameter: ", err)
		return nil, err
	}

	decoded, err := base64.StdEncoding.DecodeString(*parameterOutput.Parameter.Value)
	if err != nil {
		fmt.Println("Error while decoding parameter output: ", err)
		return nil, err
	}

	decrypted, err := kmsClient.Decrypt(context.TODO(), &kms.DecryptInput{
		CiphertextBlob: decoded,
	})
	if err != nil {
		fmt.Println("Error while decrypting decoded parameter output: ", err)
		return nil, err
	}

	// plaintext := string(decrypted.Plaintext)

	return decrypted.Plaintext, nil
}

func GetParamTypeString(name string) (*string, error) {
	ssmClient, err := awsUtils.GetSSMClient()
	if err != nil {
		fmt.Println("Error while getting SSM Client: ", err)
		return nil, err
	}

	parameterOutput, err := ssmClient.GetParameter(context.TODO(), &ssm.GetParameterInput{
		Name:           aws.String("Happ_dev_access_priv_key"),
		WithDecryption: aws.Bool(true),
	})

	if err != nil {
		fmt.Println("Error while getting parameter: ", err)
		return nil, err
	}

	plaintext := string(*parameterOutput.Parameter.Value)

	return &plaintext, nil
}

func GetRSAPubKeyParam(name string) ([]byte, error) {
	ssmClient, err := awsUtils.GetSSMClient()
	if err != nil {
		fmt.Println("Error while getting SSM Client: ", err)
		return nil, err
	}

	parameterOutput, err := ssmClient.GetParameter(context.TODO(), &ssm.GetParameterInput{
		Name:           aws.String(name),
		WithDecryption: aws.Bool(true),
	})
	if err != nil {
		fmt.Println("Error while getting parameter: ", err)
		return nil, err
	}

	decoded, err := base64.StdEncoding.DecodeString(*parameterOutput.Parameter.Value)
	if err != nil {
		fmt.Println("Error while decoding parameter output: ", err)
		return nil, err
	}

	pemPublicKey := pem.EncodeToMemory(&pem.Block{Type: "RSA PUBLIC KEY", Bytes: decoded})

	return pemPublicKey, nil
}

func GetRSAPrivKeyParam(name string) (*rsa.PrivateKey, error) {
	bytes, err := GetParamTypeSecretString(name)
	if err != nil {
		fmt.Println("Error while calling: GetParamTypeSecretString()", err)
		return nil, err
	}

	privateKey, err := x509.ParsePKCS1PrivateKey(bytes)
	if err != nil {
		fmt.Println("Error while parsing private key: ", err)
		return nil, err
	}
	// plaintext := string(*parameterOutput.Parameter.Value)

	return privateKey, nil
}

func GetEventKeyParameter(name string) (*string, error) {
	bytes, err := GetParamTypeSecretString(name)
	if err != nil {
		fmt.Println("Error while calling: GetParamTypeSecretString()", err)
		return nil, err
	}

	decoded, err := base64.StdEncoding.DecodeString(string(bytes))
	if err != nil {
		fmt.Println("Error while decoding decrypted event key", err)
	}

	plaintext := string(decoded)

	return &plaintext, nil
}

func GetEventKeyParameterGoroutine(name string, c chan KeysResGoroutine) {
	bytes, err := GetParamTypeSecretString(name)
	if err != nil {
		fmt.Println("Error while calling: GetParamTypeSecretString()", err)
		c <- KeysResGoroutine{
			Value: nil,
			Error: err,
		}
	}

	decoded, err := base64.StdEncoding.DecodeString(string(bytes))
	if err != nil {
		fmt.Println("Error while decoding decrypted event key", err)
	}

	plaintext := string(decoded)

	c <- KeysResGoroutine{
		Value: &plaintext,
		Error: nil,
	}
}
