package database

import (
	"happ/config"
	"happ/ent"

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

	mc := mysql.Config{
		User:                 config.C.Database.User,
		Passwd:               config.C.Database.Password,
		Net:                  config.C.Database.Net,
		Addr:                 config.C.Database.Addr,
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
