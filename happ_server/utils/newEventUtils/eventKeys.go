package newEventUtils

import (
	"crypto/rand"
	"encoding/base64"
	AES_Encryption "happ/utils/AES-GCM_Encryption"
	awsParameterStore "happ/utils/aws/awsParams"
	"log"
)

func CreateEventKeys() (keyString *string, nonceString *string, err error) {
	nonce := make([]byte, 12)
	rand.Read(nonce)

	key := make([]byte, 32)
	rand.Read(key)

	keyChannel := make(chan awsParameterStore.KeysResGoroutine)
	nonceChannel := make(chan awsParameterStore.KeysResGoroutine)

	go awsParameterStore.GetEventKeyParameterGoroutine("Happ_events_e", keyChannel)
	go awsParameterStore.GetEventKeyParameterGoroutine("Happ_events_o", nonceChannel)

	keyRes, nonceRes := <-keyChannel, <-nonceChannel

	if keyRes.Error != nil {
		log.Printf("error while calling getEventKeyParameterGoroutine: %s", err)
		return nil, nil, err
	}

	if nonceRes.Error != nil {
		log.Printf("error while calling getEventKeyParameterGoroutine: %s", err)
		return nil, nil, err
	}

	keyBytes, nonceBytes := keyRes.Value, nonceRes.Value

	// ENCRYPT USING AES-GCM
	// ...

	encryptedKey, err := AES_Encryption.Encrypt(key, []byte(*keyBytes), []byte(*nonceBytes))
	if err != nil {
		log.Printf("error while encrypting key: %s", err)
		return nil, nil, err
	}

	encryptedNonce, err := AES_Encryption.Encrypt(nonce, []byte(*keyBytes), []byte(*nonceBytes))
	if err != nil {
		log.Printf("error while encrypting nonce: %s", err)
		return nil, nil, err
	}

	encodedEncryptedKey := base64.StdEncoding.EncodeToString(encryptedKey)
	encodedEncryptedNonce := base64.StdEncoding.EncodeToString(encryptedNonce)

	return &encodedEncryptedKey, &encodedEncryptedNonce, nil
}
