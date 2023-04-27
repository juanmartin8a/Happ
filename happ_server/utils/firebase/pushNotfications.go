package firebaseUtils

import (
	"context"

	"firebase.google.com/go/v4/messaging"
)

func SendManyPushNotifications(title string, body string, tokens []string, ctx context.Context) (*messaging.BatchResponse, error) {
	response, err := FCMClient.SendMulticast(ctx, &messaging.MulticastMessage{
		Notification: &messaging.Notification{
			Title: title,
			Body:  body,
		},
		Tokens: tokens,
	})
	if err != nil {
		return nil, err
	}

	return response, nil
}

func SendPushNotification(title string, body string, token string, ctx context.Context) error {
	_, err := FCMClient.Send(ctx, &messaging.Message{
		Notification: &messaging.Notification{
			Title: title,
			Body:  body,
		},
		Token: token, // it's a single device token
	})
	if err != nil {
		return err
	}

	return nil
}
