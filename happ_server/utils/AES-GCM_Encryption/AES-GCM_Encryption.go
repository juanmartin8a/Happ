package AES_Encryption

import (
	"crypto/aes"
	"crypto/cipher"
)

func Encrypt(plaintext []byte, key []byte, nonce []byte) (ciphertext []byte, err error) {
	// Generate a random nonce
	// nonce = make([]byte, 12)
	// rand.Read(nonce)

	// key = make([]byte, 32)
	// rand.Read(key)

	// Create a new AES-GCM cipher using the provided key
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}
	aead, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	// Encrypt the plaintext using the AES-GCM cipher
	ciphertext = aead.Seal(nil, nonce, plaintext, nil)

	// Return the encrypted ciphertext and the nonce used for encryption
	return ciphertext, nil
}

func Decrypt(ciphertext []byte, key []byte, nonce []byte) (plaintext []byte, err error) {
	// Create a new AES-GCM cipher using the provided key
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}
	aead, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	// Decrypt the ciphertext using the AES-GCM cipher
	plaintext, err = aead.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return nil, err
	}

	// Return the decrypted plaintext
	return plaintext, nil
}
