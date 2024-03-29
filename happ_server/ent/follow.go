// Code generated by ent, DO NOT EDIT.

package ent

import (
	"fmt"
	"happ/ent/follow"
	"happ/ent/user"
	"strings"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// Follow is the model entity for the Follow schema.
type Follow struct {
	config `json:"-"`
	// UserID holds the value of the "user_id" field.
	UserID int `json:"user_id,omitempty"`
	// FollowerID holds the value of the "follower_id" field.
	FollowerID int `json:"follower_id,omitempty"`
	// Valid holds the value of the "valid" field.
	Valid bool `json:"valid,omitempty"`
	// CreatedAt holds the value of the "created_at" field.
	CreatedAt time.Time `json:"created_at,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the FollowQuery when eager-loading is set.
	Edges        FollowEdges `json:"edges"`
	selectValues sql.SelectValues
}

// FollowEdges holds the relations/edges for other nodes in the graph.
type FollowEdges struct {
	// User holds the value of the user edge.
	User *User `json:"user,omitempty"`
	// Follower holds the value of the follower edge.
	Follower *User `json:"follower,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [2]bool
	// totalCount holds the count of the edges above.
	totalCount [2]map[string]int
}

// UserOrErr returns the User value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e FollowEdges) UserOrErr() (*User, error) {
	if e.loadedTypes[0] {
		if e.User == nil {
			// Edge was loaded but was not found.
			return nil, &NotFoundError{label: user.Label}
		}
		return e.User, nil
	}
	return nil, &NotLoadedError{edge: "user"}
}

// FollowerOrErr returns the Follower value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e FollowEdges) FollowerOrErr() (*User, error) {
	if e.loadedTypes[1] {
		if e.Follower == nil {
			// Edge was loaded but was not found.
			return nil, &NotFoundError{label: user.Label}
		}
		return e.Follower, nil
	}
	return nil, &NotLoadedError{edge: "follower"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*Follow) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case follow.FieldValid:
			values[i] = new(sql.NullBool)
		case follow.FieldUserID, follow.FieldFollowerID:
			values[i] = new(sql.NullInt64)
		case follow.FieldCreatedAt:
			values[i] = new(sql.NullTime)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the Follow fields.
func (f *Follow) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case follow.FieldUserID:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field user_id", values[i])
			} else if value.Valid {
				f.UserID = int(value.Int64)
			}
		case follow.FieldFollowerID:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field follower_id", values[i])
			} else if value.Valid {
				f.FollowerID = int(value.Int64)
			}
		case follow.FieldValid:
			if value, ok := values[i].(*sql.NullBool); !ok {
				return fmt.Errorf("unexpected type %T for field valid", values[i])
			} else if value.Valid {
				f.Valid = value.Bool
			}
		case follow.FieldCreatedAt:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field created_at", values[i])
			} else if value.Valid {
				f.CreatedAt = value.Time
			}
		default:
			f.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the Follow.
// This includes values selected through modifiers, order, etc.
func (f *Follow) Value(name string) (ent.Value, error) {
	return f.selectValues.Get(name)
}

// QueryUser queries the "user" edge of the Follow entity.
func (f *Follow) QueryUser() *UserQuery {
	return NewFollowClient(f.config).QueryUser(f)
}

// QueryFollower queries the "follower" edge of the Follow entity.
func (f *Follow) QueryFollower() *UserQuery {
	return NewFollowClient(f.config).QueryFollower(f)
}

// Update returns a builder for updating this Follow.
// Note that you need to call Follow.Unwrap() before calling this method if this Follow
// was returned from a transaction, and the transaction was committed or rolled back.
func (f *Follow) Update() *FollowUpdateOne {
	return NewFollowClient(f.config).UpdateOne(f)
}

// Unwrap unwraps the Follow entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (f *Follow) Unwrap() *Follow {
	_tx, ok := f.config.driver.(*txDriver)
	if !ok {
		panic("ent: Follow is not a transactional entity")
	}
	f.config.driver = _tx.drv
	return f
}

// String implements the fmt.Stringer.
func (f *Follow) String() string {
	var builder strings.Builder
	builder.WriteString("Follow(")
	builder.WriteString("user_id=")
	builder.WriteString(fmt.Sprintf("%v", f.UserID))
	builder.WriteString(", ")
	builder.WriteString("follower_id=")
	builder.WriteString(fmt.Sprintf("%v", f.FollowerID))
	builder.WriteString(", ")
	builder.WriteString("valid=")
	builder.WriteString(fmt.Sprintf("%v", f.Valid))
	builder.WriteString(", ")
	builder.WriteString("created_at=")
	builder.WriteString(f.CreatedAt.Format(time.ANSIC))
	builder.WriteByte(')')
	return builder.String()
}

// Follows is a parsable slice of Follow.
type Follows []*Follow
