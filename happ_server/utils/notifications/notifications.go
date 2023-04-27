package notifications

import (
	"context"
	"fmt"
	"happ/ent"
	"happ/ent/device"
	firebaseUtils "happ/utils/firebase"
	"log"
)

func SendPushNotifications(client *ent.Client, userId int, title string, body string) {
	fmt.Println("called goroutine notifications")

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

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

func SendManyPushNotifications(client *ent.Client, userIds []int, title string, body string) {
	fmt.Println("called goroutine notifications")

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

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

func SendPushNotificationsWithDevices(client *ent.Client, devices []string, title string, body string) {
	fmt.Println("called goroutine notifications")

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	_, err := firebaseUtils.SendManyPushNotifications(title, body, devices, ctx)
	if err != nil {
		log.Printf("Error: %s", err)
	}
}
