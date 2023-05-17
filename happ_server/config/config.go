package config

import (
	"fmt"
	"log"
	"os"
	"path"
	"path/filepath"
	"runtime"

	"github.com/spf13/viper"
)

type config struct {
	AppEnv   string
	Database struct {
		User                 string
		Password             string
		Net                  string
		Addr                 string
		DBName               string
		AllowNativePasswords bool
		Params               struct {
			ParseTime string
			Charset   string
			TLS       string
		}
	}
	MeilisearchMK        string
	FirebaseSAPrivateKey string
	MapsAPIKey           string
}

var C config

const (
	Development = "dev"
	Production  = "prod"
)

type ReadConfigOption struct {
	AppEnv string
}

func ReadConfig(option ReadConfigOption) {
	Config := &C

	e := appEnv(option)

	if e == Production {
		setProd()
	} else {
		setDev()
	}

	viper.SetConfigType("yml")
	viper.AutomaticEnv()

	if err := viper.ReadInConfig(); err != nil {
		fmt.Println(err)
		log.Fatalln(err)
	}

	if err := viper.Unmarshal(&Config); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func appEnv(option ReadConfigOption) string {
	if option.AppEnv != "" {
		return option.AppEnv
	}
	if os.Getenv("APP_ENV") != "" {
		return os.Getenv("APP_ENV")
	}

	return Development
}

func rootDir() string {
	_, b, _, _ := runtime.Caller(0)
	d := path.Join(path.Dir(b))
	return filepath.Dir(d)
}

func setDev() {
	viper.AddConfigPath(filepath.Join(rootDir(), "config"))
	viper.SetConfigName("config.dev")
}

func setProd() {
	viper.AddConfigPath(filepath.Join(rootDir(), "config"))
	viper.SetConfigName("config.prod")
}
