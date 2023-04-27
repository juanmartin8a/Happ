package main

// func main() {
// 	cfg, err := config.LoadDefaultConfig(context.TODO())
// 	if err != nil {
// 		log.Printf("error: %v", err)
// 		// return nil, err
// 		return
// 	}

// 	// // Create a new AWS SSM client
// 	svc := ssm.NewFromConfig(cfg)

// 	kmsClient := kms.NewFromConfig(cfg)

// 	// // Define the parameter name and CMK ID
// 	name := "Happ_event_keys"
// 	// plainText := "6zmmadu9vefc.us-east-4.psdb.cloud"
// 	keyID := "arn:aws:kms:us-east-2:113054727247:key/bec048c3-86e2-4126-847b-e854e22f5b4e"

// 	key := make([]byte, 32)
// 	rand.Read(key)

// 	nonce := make([]byte, 12)
// 	rand.Read(nonce)

// 	fmt.Println(key)
// 	fmt.Println(nonce)

// 	//Convert the byte array to a string
// 	encodedKey := base64.StdEncoding.EncodeToString(key)
// 	fmt.Println(encodedKey)

// 	encodedNonce := base64.StdEncoding.EncodeToString(nonce)
// 	fmt.Println(encodedNonce)

// 	encryptedKeyOutput, err := kmsClient.Encrypt(context.TODO(), &kms.EncryptInput{
// 		KeyId:     &keyID,
// 		Plaintext: []byte(encodedKey),
// 	})
// 	if err != nil {
// 		fmt.Println(err)
// 	}

// 	encryptedNonceOutput, err := kmsClient.Encrypt(context.TODO(), &kms.EncryptInput{
// 		KeyId:     &keyID,
// 		Plaintext: []byte(encodedNonce),
// 	})
// 	if err != nil {
// 		fmt.Println(err)
// 	}

// 	encodedKey = base64.StdEncoding.EncodeToString(encryptedKeyOutput.CiphertextBlob)
// 	encodedNonce = base64.StdEncoding.EncodeToString(encryptedNonceOutput.CiphertextBlob)

// 	fmt.Println(encodedKey)

// 	keys := map[string]interface{}{
// 		"e": encodedKey,
// 		"o": encodedNonce,
// 	}

// 	// Encrypt the parameter value using KMS
// 	inputKey := &ssm.PutParameterInput{
// 		Name:      &name,
// 		Value:     &encodedKey,
// 		Type:      types.ParameterTypeSecureString,
// 		KeyId:     &keyID,
// 		Overwrite: aws.Bool(true),
// 	}

// 	_, err = svc.PutParameter(context.TODO(), input)
// 	if err != nil {
// 		fmt.Println("Error putting parameter 1 value: ", err)
// 		return
// 	}

// 	output, _ := svc.GetParameter(context.TODO(), &ssm.GetParameterInput{
// 		Name:           &name,
// 		WithDecryption: aws.Bool(true),
// 	})

// 	fmt.Println(*output.Parameter.Value)

// 	decoded, err := base64.StdEncoding.DecodeString(*output.Parameter.Value)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println(decoded)

// 	decryptedOutput, err := kmsClient.Decrypt(context.TODO(), &kms.DecryptInput{
// 		CiphertextBlob: decoded,
// 	})
// 	if err != nil {
// 		fmt.Println("Error getting parameter 1 value: ", err)
// 		return
// 	}

// 	decoded, err = base64.StdEncoding.DecodeString(string(decryptedOutput.Plaintext))
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println(decoded)

// 	// decoded2, err := base64.StdEncoding.DecodeString(string(decryptedOutput1.Plaintext))
// 	// if err != nil {
// 	// 	log.Fatal(err)
// 	// }

// 	// decryptedOutput2, err := kmsClient.Decrypt(context.TODO(), &kms.DecryptInput{
// 	// 	CiphertextBlob: decoded2,
// 	// })
// 	// if err != nil {
// 	// 	fmt.Println("Error getting parameter 2 value: ", err)
// 	// 	return
// 	// }

// 	// fmt.Println(decryptedOutput1)

// 	// decryptedValue1 := string(decryptedOutput1.Plaintext)

// 	// decryptedValue2 := string(decryptedOutput2.Plaintext)

// 	// fmt.Println(decryptedOutput1.Plaintext)
// 	// fmt.Println(decryptedValue2)

// 	// fmt.Println("1")
// }

// func main() {
// 	cfg, err := config.LoadDefaultConfig(context.TODO())
// 	if err != nil {
// 		log.Printf("error: %v", err)
// 		// return nil, err
// 		return
// 	}

// 	// // Create a new AWS SSM client
// 	svc := ssm.NewFromConfig(cfg)

// 	kmsClient := kms.NewFromConfig(cfg)

// 	// // Define the parameter name and CMK ID
// 	// name := "Random_Test"
// 	// plainText := "6zmmadu9vefc.us-east-4.psdb.cloud"
// 	keyID := "arn:aws:kms:us-east-2:113054727247:key/bec048c3-86e2-4126-847b-e854e22f5b4e"

// 	privateKey, err := rsa.GenerateKey(rand.Reader, 2048)
// 	if err != nil {
// 		panic(err)
// 	}

// 	publicKey := &privateKey.PublicKey

// 	privateKeyBytes := x509.MarshalPKCS1PrivateKey(privateKey)
// 	// privateKeyBase64 := base64.StdEncoding.EncodeToString(privateKeyBytes)

// 	publicKeyBytes, err := x509.MarshalPKIXPublicKey(publicKey)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println(privateKeyBytes)
// 	fmt.Println("#########################")
// 	fmt.Println(publicKeyBytes)
// 	fmt.Println("#########################")

// 	publicKeyBase64 := base64.StdEncoding.EncodeToString(publicKeyBytes)

// 	encryptedOutput1, err := kmsClient.Encrypt(context.TODO(), &kms.EncryptInput{
// 		KeyId:     &keyID,
// 		Plaintext: privateKeyBytes, //[]byte(privateKeyBase64),
// 	})
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	// encryptedOutput2, err := kmsClient.Encrypt(context.TODO(), &kms.EncryptInput{
// 	// 	KeyId:     &keyID,
// 	// 	Plaintext: []byte(publicKeyBase64),
// 	// })

// 	ciphertext1 := base64.StdEncoding.EncodeToString(encryptedOutput1.CiphertextBlob)

// 	// ciphertext2 := base64.StdEncoding.EncodeToString(encryptedOutput2.CiphertextBlob)

// 	// key := make([]byte, 32)
// 	// rand.Read(key)

// 	// Convert the byte array to a string
// 	// encoded := base64.StdEncoding.EncodeToString(key)

// 	// Encrypt the parameter value using KMS
// 	input1 := &ssm.PutParameterInput{
// 		Name:      aws.String("Happ_dev_refresh_priv_key"),
// 		Value:     &ciphertext1,
// 		Type:      types.ParameterTypeSecureString,
// 		KeyId:     &keyID,
// 		Overwrite: aws.Bool(true),
// 	}

// 	input2 := &ssm.PutParameterInput{
// 		Name:  aws.String("Happ_dev_refresh_pub_key"),
// 		Value: &publicKeyBase64,
// 		Type:  types.ParameterTypeString,
// 		// KeyId:     &keyID,
// 		Overwrite: aws.Bool(true),
// 	}

// 	_, err = svc.PutParameter(context.TODO(), input1)
// 	if err != nil {
// 		fmt.Println("Error putting parameter 1 value: ", err)
// 		return
// 	}

// 	_, err = svc.PutParameter(context.TODO(), input2)
// 	if err != nil {
// 		fmt.Println("Error putting parameter 2 value: ", err)
// 		return
// 	}

// 	output1, _ := svc.GetParameter(context.TODO(), &ssm.GetParameterInput{
// 		Name:           aws.String("Happ_dev_access_priv_key"),
// 		WithDecryption: aws.Bool(true),
// 	})

// 	output2, _ := svc.GetParameter(context.TODO(), &ssm.GetParameterInput{
// 		Name:           aws.String("Happ_dev_access_pub_key"),
// 		WithDecryption: aws.Bool(true),
// 	})

// 	// fmt.Println(*output.Parameter.Value)

// 	decoded1, err := base64.StdEncoding.DecodeString(*output1.Parameter.Value)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	decoded2, err := base64.StdEncoding.DecodeString(*output2.Parameter.Value)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println(decoded1)
// 	fmt.Println("-----------------------")
// 	fmt.Println(decoded2)

// 	fmt.Println("-----------------------")

// 	decryptedOutput1, err := kmsClient.Decrypt(context.TODO(), &kms.DecryptInput{
// 		CiphertextBlob: decoded1,
// 	})
// 	if err != nil {
// 		fmt.Println("Error getting parameter 1 value: ", err)
// 		return
// 	}

// 	// decryptedOutput2, err := kmsClient.Decrypt(context.TODO(), &kms.DecryptInput{
// 	// 	CiphertextBlob: decoded2,
// 	// })
// 	// if err != nil {
// 	// 	fmt.Println("Error getting parameter 2 value: ", err)
// 	// 	return
// 	// }

// 	// fmt.Println(decryptedOutput1)

// 	// decryptedValue1 := string(decryptedOutput1.Plaintext)

// 	// decryptedValue2 := string(decryptedOutput2.Plaintext)

// 	fmt.Println(decryptedOutput1.Plaintext)
// 	// fmt.Println(decryptedValue2)

// 	fmt.Println("1")

// 	privateKeyGet, err := x509.ParsePKCS1PrivateKey(decryptedOutput1.Plaintext)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println("2")

// 	publicKeyGet, err := x509.ParsePKIXPublicKey(decoded2)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println("Private Key:")
// 	fmt.Printf("%#v\n", privateKeyGet)

// 	fmt.Println("Public Key:")
// 	fmt.Printf("%#v\n", publicKeyGet)
// }
