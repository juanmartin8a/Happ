package database

import (
	"fmt"
	"happ/config"
	"happ/ent"
	awsParameterStore "happ/utils/aws/awsParams"

	"entgo.io/ent/dialect"
	"github.com/go-sql-driver/mysql"
)

func New() string {
	params := map[string]string{
		"parseTime": config.C.Database.Params.ParseTime,
		"charset":   config.C.Database.Params.Charset,
	}
	if config.C.Database.Params.TLS != "" {
		params["tls"] = config.C.Database.Params.TLS
	}

	// Get from values from database
	userBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.Database.User)
	if err != nil {
		panic(fmt.Sprintf("error while getting db user: %s", err))
	}

	addressBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.Database.Addr)
	if err != nil {
		panic(fmt.Sprintf("error while getting db address: %s", err))
	}

	passwordBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.Database.Password)
	if err != nil {
		panic(fmt.Sprintf("error while getting db password: %s", err))
	}

	user := string(userBytes)
	address := string(addressBytes)
	password := string(passwordBytes)

	fmt.Println(user)
	fmt.Println(address)
	fmt.Println(password)

	mc := mysql.Config{
		User:                 user,     //config.C.Database.User,
		Passwd:               password, //config.C.Database.Password,
		Net:                  config.C.Database.Net,
		Addr:                 address, //config.C.Database.Addr,
		DBName:               config.C.Database.DBName,
		AllowNativePasswords: config.C.Database.AllowNativePasswords,
		Params:               params,
	}

	return mc.FormatDSN()
}

// NewClientOptions is an option for NewClient.
type NewClientOptions struct {
	Debug bool
}

// NewClient returns an orm client
func NewClient(options NewClientOptions) (*ent.Client, error) {
	var entOptions []ent.Option

	if options.Debug {
		entOptions = append(entOptions, ent.Debug())
	}

	d := New()

	return ent.Open(dialect.MySQL, d, entOptions...)
}
