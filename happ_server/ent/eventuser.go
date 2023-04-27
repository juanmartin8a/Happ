// Code generated by ent, DO NOT EDIT.

package ent

import (
	"fmt"
	"happ/ent/event"
	"happ/ent/eventuser"
	"happ/ent/user"
	"strings"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// EventUser is the model entity for the EventUser schema.
type EventUser struct {
	config `json:"-"`
	// EventID holds the value of the "event_id" field.
	EventID int `json:"event_id,omitempty"`
	// UserID holds the value of the "user_id" field.
	UserID int `json:"user_id,omitempty"`
	// InvitedBy holds the value of the "invited_by" field.
	InvitedBy int `json:"invited_by,omitempty"`
	// Admin holds the value of the "admin" field.
	Admin bool `json:"admin,omitempty"`
	// Creator holds the value of the "creator" field.
	Creator bool `json:"creator,omitempty"`
	// Confirmed holds the value of the "confirmed" field.
	Confirmed bool `json:"confirmed,omitempty"`
	// CreatedAt holds the value of the "created_at" field.
	CreatedAt time.Time `json:"created_at,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the EventUserQuery when eager-loading is set.
	Edges        EventUserEdges `json:"edges"`
	selectValues sql.SelectValues
}

// EventUserEdges holds the relations/edges for other nodes in the graph.
type EventUserEdges struct {
	// Event holds the value of the event edge.
	Event *Event `json:"event,omitempty"`
	// User holds the value of the user edge.
	User *User `json:"user,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [2]bool
	// totalCount holds the count of the edges above.
	totalCount [2]map[string]int
}

// EventOrErr returns the Event value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e EventUserEdges) EventOrErr() (*Event, error) {
	if e.loadedTypes[0] {
		if e.Event == nil {
			// Edge was loaded but was not found.
			return nil, &NotFoundError{label: event.Label}
		}
		return e.Event, nil
	}
	return nil, &NotLoadedError{edge: "event"}
}

// UserOrErr returns the User value or an error if the edge
// was not loaded in eager-loading, or loaded but was not found.
func (e EventUserEdges) UserOrErr() (*User, error) {
	if e.loadedTypes[1] {
		if e.User == nil {
			// Edge was loaded but was not found.
			return nil, &NotFoundError{label: user.Label}
		}
		return e.User, nil
	}
	return nil, &NotLoadedError{edge: "user"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*EventUser) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case eventuser.FieldAdmin, eventuser.FieldCreator, eventuser.FieldConfirmed:
			values[i] = new(sql.NullBool)
		case eventuser.FieldEventID, eventuser.FieldUserID, eventuser.FieldInvitedBy:
			values[i] = new(sql.NullInt64)
		case eventuser.FieldCreatedAt:
			values[i] = new(sql.NullTime)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the EventUser fields.
func (eu *EventUser) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case eventuser.FieldEventID:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field event_id", values[i])
			} else if value.Valid {
				eu.EventID = int(value.Int64)
			}
		case eventuser.FieldUserID:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field user_id", values[i])
			} else if value.Valid {
				eu.UserID = int(value.Int64)
			}
		case eventuser.FieldInvitedBy:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field invited_by", values[i])
			} else if value.Valid {
				eu.InvitedBy = int(value.Int64)
			}
		case eventuser.FieldAdmin:
			if value, ok := values[i].(*sql.NullBool); !ok {
				return fmt.Errorf("unexpected type %T for field admin", values[i])
			} else if value.Valid {
				eu.Admin = value.Bool
			}
		case eventuser.FieldCreator:
			if value, ok := values[i].(*sql.NullBool); !ok {
				return fmt.Errorf("unexpected type %T for field creator", values[i])
			} else if value.Valid {
				eu.Creator = value.Bool
			}
		case eventuser.FieldConfirmed:
			if value, ok := values[i].(*sql.NullBool); !ok {
				return fmt.Errorf("unexpected type %T for field confirmed", values[i])
			} else if value.Valid {
				eu.Confirmed = value.Bool
			}
		case eventuser.FieldCreatedAt:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field created_at", values[i])
			} else if value.Valid {
				eu.CreatedAt = value.Time
			}
		default:
			eu.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the EventUser.
// This includes values selected through modifiers, order, etc.
func (eu *EventUser) Value(name string) (ent.Value, error) {
	return eu.selectValues.Get(name)
}

// QueryEvent queries the "event" edge of the EventUser entity.
func (eu *EventUser) QueryEvent() *EventQuery {
	return NewEventUserClient(eu.config).QueryEvent(eu)
}

// QueryUser queries the "user" edge of the EventUser entity.
func (eu *EventUser) QueryUser() *UserQuery {
	return NewEventUserClient(eu.config).QueryUser(eu)
}

// Update returns a builder for updating this EventUser.
// Note that you need to call EventUser.Unwrap() before calling this method if this EventUser
// was returned from a transaction, and the transaction was committed or rolled back.
func (eu *EventUser) Update() *EventUserUpdateOne {
	return NewEventUserClient(eu.config).UpdateOne(eu)
}

// Unwrap unwraps the EventUser entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (eu *EventUser) Unwrap() *EventUser {
	_tx, ok := eu.config.driver.(*txDriver)
	if !ok {
		panic("ent: EventUser is not a transactional entity")
	}
	eu.config.driver = _tx.drv
	return eu
}

// String implements the fmt.Stringer.
func (eu *EventUser) String() string {
	var builder strings.Builder
	builder.WriteString("EventUser(")
	builder.WriteString("event_id=")
	builder.WriteString(fmt.Sprintf("%v", eu.EventID))
	builder.WriteString(", ")
	builder.WriteString("user_id=")
	builder.WriteString(fmt.Sprintf("%v", eu.UserID))
	builder.WriteString(", ")
	builder.WriteString("invited_by=")
	builder.WriteString(fmt.Sprintf("%v", eu.InvitedBy))
	builder.WriteString(", ")
	builder.WriteString("admin=")
	builder.WriteString(fmt.Sprintf("%v", eu.Admin))
	builder.WriteString(", ")
	builder.WriteString("creator=")
	builder.WriteString(fmt.Sprintf("%v", eu.Creator))
	builder.WriteString(", ")
	builder.WriteString("confirmed=")
	builder.WriteString(fmt.Sprintf("%v", eu.Confirmed))
	builder.WriteString(", ")
	builder.WriteString("created_at=")
	builder.WriteString(eu.CreatedAt.Format(time.ANSIC))
	builder.WriteByte(')')
	return builder.String()
}

// EventUsers is a parsable slice of EventUser.
type EventUsers []*EventUser