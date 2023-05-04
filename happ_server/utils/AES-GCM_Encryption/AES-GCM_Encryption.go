package AES_Encryption

import (
	"crypto/aes"
	"crypto/cipher"
)

func Encrypt(plaintext []byte, key []byte, nonce []byte) (ciphertext []byte, err error) {

	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}
	aead, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	ciphertext = aead.Seal(nil, nonce, plaintext, nil)

	return ciphertext, nil
}

func Decrypt(ciphertext []byte, key []byte, nonce []byte) (plaintext []byte, err error) {

	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	aead, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	plaintext, err = aead.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return nil, err
	}

	return plaintext, nil
}
