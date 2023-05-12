package notifications

import (
	"context"
	"happ/ent"
	"happ/ent/device"
	firebaseUtils "happ/utils/firebase"
	"log"
)

func SendPushNotifications(client *ent.Client, ctx context.Context, userId int, title string, body string) {

	devices, err := client.Device.Query().
		Where(
			device.UserID(userId),
		).
		Select(device.FieldToken).
		Strings(ctx)
	if err != nil {
		log.Printf("Error: %s", err)
	}

	_, err = firebaseUtils.SendManyPushNotifications(title, body, devices, ctx)
	if err != nil {
		log.Printf("Error: %s", err)
	}
}

func SendManyPushNotifications(client *ent.Client, ctx context.Context, userIds []int, title string, body string) {

	devices, err := client.Device.Query().
		Where(
			device.UserIDIn(userIds...),
		).
		Select(device.FieldToken).
		Strings(ctx)
	if err != nil {
		log.Printf("Error: %s", err)
	}

	_, err = firebaseUtils.SendManyPushNotifications(title, body, devices, ctx)
	if err != nil {
		log.Printf("Error: %s", err)
	}
}

func SendPushNotificationsWithDevices(ctx context.Context, devices []string, title string, body string) {

	_, err := firebaseUtils.SendManyPushNotifications(title, body, devices, ctx)
	if err != nil {
		log.Printf("Error: %s", err)
	}
}
