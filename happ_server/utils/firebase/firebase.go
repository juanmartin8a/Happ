package firebaseUtils

import (
	"context"
	"fmt"
	"log"

	"happ/config"
	awsParameterStore "happ/utils/aws/awsParams"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"firebase.google.com/go/v4/messaging"
	"google.golang.org/api/option"
)

var FirebaseApp *firebase.App

var AuthClient *auth.Client
var FCMClient *messaging.Client

func GetFirebaseAuthClient(ctx context.Context) (*auth.Client, error) {
	if FirebaseApp == nil {
		jsonBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.FirebaseSAPrivateKey)
		if err != nil {
			log.Printf("error while getting db password: %s", err)
			return nil, err
		}

		sa := option.WithCredentialsJSON(jsonBytes)

		app, err := firebase.NewApp(ctx, nil, sa)
		if err != nil {
			return nil, fmt.Errorf("error initializing firebase app: %v", err)
		}
		FirebaseApp = app
	}

	authClient, err := FirebaseApp.Auth(ctx)
	if err != nil {
		return nil, fmt.Errorf("error initializing firebase app: %v", err)
	}

	AuthClient = authClient

	return AuthClient, nil
}

func GetFirebaseMessageClient(ctx context.Context) (*messaging.Client, error) {
	if FirebaseApp == nil {
		jsonBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.FirebaseSAPrivateKey)
		if err != nil {
			log.Printf("error while getting db password: %s", err)
			return nil, err
		}

		sa := option.WithCredentialsJSON(jsonBytes)
		app, err := firebase.NewApp(ctx, nil, sa)
		if err != nil {
			return nil, fmt.Errorf("error initializing firebase app: %v", err)
		}
		FirebaseApp = app
	}

	fcmClient, err := FirebaseApp.Messaging(ctx)
	if err != nil {
		return nil, fmt.Errorf("error initializing firebase app: %v", err)
	}

	FCMClient = fcmClient

	return FCMClient, nil
}
