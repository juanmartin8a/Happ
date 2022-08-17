package ent

import (
	"database/sql"

	"entgo.io/ent/dialect"
	entsql "entgo.io/ent/dialect/sql"
)

// DB provides sql.DB
func (c *Client) DB() *sql.DB {
	if c.debug {
		return c.driver.(*dialect.DebugDriver).Driver.(*entsql.Driver).DB()
	}
	return c.driver.(*entsql.Driver).DB()
}
