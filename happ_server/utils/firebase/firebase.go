package firebaseUtils

import (
	"context"
	"fmt"

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
		sa := option.WithCredentialsFile("happ-fa9e4-firebase-adminsdk-csnty-1bb60eb9e0.json")
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
		sa := option.WithCredentialsFile("happ-fa9e4-firebase-adminsdk-csnty-1bb60eb9e0.json")
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
