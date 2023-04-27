// Code generated by ent, DO NOT EDIT.

package ent

import (
	"encoding/json"
	"fmt"
	"happ/ent/event"
	"happ/ent/schema/schematype"
	"strings"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
)

// Event is the model entity for the Event schema.
type Event struct {
	config `json:"-"`
	// ID of the ent.
	ID int `json:"id,omitempty"`
	// Name holds the value of the "name" field.
	Name string `json:"name,omitempty"`
	// Description holds the value of the "description" field.
	Description string `json:"description,omitempty"`
	// EventPlace holds the value of the "event_place" field.
	EventPlace string `json:"event_place,omitempty"`
	// ConfirmedCount holds the value of the "confirmed_count" field.
	ConfirmedCount int `json:"confirmed_count,omitempty"`
	// ConfirmedHosts holds the value of the "confirmed_hosts" field.
	ConfirmedHosts int `json:"confirmed_hosts,omitempty"`
	// EventPics holds the value of the "event_pics" field.
	EventPics []string `json:"event_pics,omitempty"`
	// LightEventPics holds the value of the "light_event_pics" field.
	LightEventPics []string `json:"light_event_pics,omitempty"`
	// EventKey holds the value of the "event_key" field.
	EventKey string `json:"event_key,omitempty"`
	// EventNonce holds the value of the "event_nonce" field.
	EventNonce string `json:"event_nonce,omitempty"`
	// EventDate holds the value of the "event_date" field.
	EventDate time.Time `json:"event_date,omitempty"`
	// Coords holds the value of the "coords" field.
	Coords *schematype.Point `json:"coords,omitempty"`
	// CreatedAt holds the value of the "created_at" field.
	CreatedAt time.Time `json:"created_at,omitempty"`
	// UpdatedAt holds the value of the "updated_at" field.
	UpdatedAt time.Time `json:"updated_at,omitempty"`
	// Edges holds the relations/edges for other nodes in the graph.
	// The values are being populated by the EventQuery when eager-loading is set.
	Edges        EventEdges `json:"edges"`
	selectValues sql.SelectValues
}

// EventEdges holds the relations/edges for other nodes in the graph.
type EventEdges struct {
	// Users holds the value of the users edge.
	Users []*User `json:"users,omitempty"`
	// EventReminderNotifications holds the value of the event_reminder_notifications edge.
	EventReminderNotifications []*EventReminderNotification `json:"event_reminder_notifications,omitempty"`
	// EventUsers holds the value of the event_users edge.
	EventUsers []*EventUser `json:"event_users,omitempty"`
	// loadedTypes holds the information for reporting if a
	// type was loaded (or requested) in eager-loading or not.
	loadedTypes [3]bool
	// totalCount holds the count of the edges above.
	totalCount [2]map[string]int

	namedUsers                      map[string][]*User
	namedEventReminderNotifications map[string][]*EventReminderNotification
	namedEventUsers                 map[string][]*EventUser
}

// UsersOrErr returns the Users value or an error if the edge
// was not loaded in eager-loading.
func (e EventEdges) UsersOrErr() ([]*User, error) {
	if e.loadedTypes[0] {
		return e.Users, nil
	}
	return nil, &NotLoadedError{edge: "users"}
}

// EventReminderNotificationsOrErr returns the EventReminderNotifications value or an error if the edge
// was not loaded in eager-loading.
func (e EventEdges) EventReminderNotificationsOrErr() ([]*EventReminderNotification, error) {
	if e.loadedTypes[1] {
		return e.EventReminderNotifications, nil
	}
	return nil, &NotLoadedError{edge: "event_reminder_notifications"}
}

// EventUsersOrErr returns the EventUsers value or an error if the edge
// was not loaded in eager-loading.
func (e EventEdges) EventUsersOrErr() ([]*EventUser, error) {
	if e.loadedTypes[2] {
		return e.EventUsers, nil
	}
	return nil, &NotLoadedError{edge: "event_users"}
}

// scanValues returns the types for scanning values from sql.Rows.
func (*Event) scanValues(columns []string) ([]any, error) {
	values := make([]any, len(columns))
	for i := range columns {
		switch columns[i] {
		case event.FieldEventPics, event.FieldLightEventPics:
			values[i] = new([]byte)
		case event.FieldCoords:
			values[i] = new(schematype.Point)
		case event.FieldID, event.FieldConfirmedCount, event.FieldConfirmedHosts:
			values[i] = new(sql.NullInt64)
		case event.FieldName, event.FieldDescription, event.FieldEventPlace, event.FieldEventKey, event.FieldEventNonce:
			values[i] = new(sql.NullString)
		case event.FieldEventDate, event.FieldCreatedAt, event.FieldUpdatedAt:
			values[i] = new(sql.NullTime)
		default:
			values[i] = new(sql.UnknownType)
		}
	}
	return values, nil
}

// assignValues assigns the values that were returned from sql.Rows (after scanning)
// to the Event fields.
func (e *Event) assignValues(columns []string, values []any) error {
	if m, n := len(values), len(columns); m < n {
		return fmt.Errorf("mismatch number of scan values: %d != %d", m, n)
	}
	for i := range columns {
		switch columns[i] {
		case event.FieldID:
			value, ok := values[i].(*sql.NullInt64)
			if !ok {
				return fmt.Errorf("unexpected type %T for field id", value)
			}
			e.ID = int(value.Int64)
		case event.FieldName:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field name", values[i])
			} else if value.Valid {
				e.Name = value.String
			}
		case event.FieldDescription:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field description", values[i])
			} else if value.Valid {
				e.Description = value.String
			}
		case event.FieldEventPlace:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field event_place", values[i])
			} else if value.Valid {
				e.EventPlace = value.String
			}
		case event.FieldConfirmedCount:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field confirmed_count", values[i])
			} else if value.Valid {
				e.ConfirmedCount = int(value.Int64)
			}
		case event.FieldConfirmedHosts:
			if value, ok := values[i].(*sql.NullInt64); !ok {
				return fmt.Errorf("unexpected type %T for field confirmed_hosts", values[i])
			} else if value.Valid {
				e.ConfirmedHosts = int(value.Int64)
			}
		case event.FieldEventPics:
			if value, ok := values[i].(*[]byte); !ok {
				return fmt.Errorf("unexpected type %T for field event_pics", values[i])
			} else if value != nil && len(*value) > 0 {
				if err := json.Unmarshal(*value, &e.EventPics); err != nil {
					return fmt.Errorf("unmarshal field event_pics: %w", err)
				}
			}
		case event.FieldLightEventPics:
			if value, ok := values[i].(*[]byte); !ok {
				return fmt.Errorf("unexpected type %T for field light_event_pics", values[i])
			} else if value != nil && len(*value) > 0 {
				if err := json.Unmarshal(*value, &e.LightEventPics); err != nil {
					return fmt.Errorf("unmarshal field light_event_pics: %w", err)
				}
			}
		case event.FieldEventKey:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field event_key", values[i])
			} else if value.Valid {
				e.EventKey = value.String
			}
		case event.FieldEventNonce:
			if value, ok := values[i].(*sql.NullString); !ok {
				return fmt.Errorf("unexpected type %T for field event_nonce", values[i])
			} else if value.Valid {
				e.EventNonce = value.String
			}
		case event.FieldEventDate:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field event_date", values[i])
			} else if value.Valid {
				e.EventDate = value.Time
			}
		case event.FieldCoords:
			if value, ok := values[i].(*schematype.Point); !ok {
				return fmt.Errorf("unexpected type %T for field coords", values[i])
			} else if value != nil {
				e.Coords = value
			}
		case event.FieldCreatedAt:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field created_at", values[i])
			} else if value.Valid {
				e.CreatedAt = value.Time
			}
		case event.FieldUpdatedAt:
			if value, ok := values[i].(*sql.NullTime); !ok {
				return fmt.Errorf("unexpected type %T for field updated_at", values[i])
			} else if value.Valid {
				e.UpdatedAt = value.Time
			}
		default:
			e.selectValues.Set(columns[i], values[i])
		}
	}
	return nil
}

// Value returns the ent.Value that was dynamically selected and assigned to the Event.
// This includes values selected through modifiers, order, etc.
func (e *Event) Value(name string) (ent.Value, error) {
	return e.selectValues.Get(name)
}

// QueryUsers queries the "users" edge of the Event entity.
func (e *Event) QueryUsers() *UserQuery {
	return NewEventClient(e.config).QueryUsers(e)
}

// QueryEventReminderNotifications queries the "event_reminder_notifications" edge of the Event entity.
func (e *Event) QueryEventReminderNotifications() *EventReminderNotificationQuery {
	return NewEventClient(e.config).QueryEventReminderNotifications(e)
}

// QueryEventUsers queries the "event_users" edge of the Event entity.
func (e *Event) QueryEventUsers() *EventUserQuery {
	return NewEventClient(e.config).QueryEventUsers(e)
}

// Update returns a builder for updating this Event.
// Note that you need to call Event.Unwrap() before calling this method if this Event
// was returned from a transaction, and the transaction was committed or rolled back.
func (e *Event) Update() *EventUpdateOne {
	return NewEventClient(e.config).UpdateOne(e)
}

// Unwrap unwraps the Event entity that was returned from a transaction after it was closed,
// so that all future queries will be executed through the driver which created the transaction.
func (e *Event) Unwrap() *Event {
	_tx, ok := e.config.driver.(*txDriver)
	if !ok {
		panic("ent: Event is not a transactional entity")
	}
	e.config.driver = _tx.drv
	return e
}

// String implements the fmt.Stringer.
func (e *Event) String() string {
	var builder strings.Builder
	builder.WriteString("Event(")
	builder.WriteString(fmt.Sprintf("id=%v, ", e.ID))
	builder.WriteString("name=")
	builder.WriteString(e.Name)
	builder.WriteString(", ")
	builder.WriteString("description=")
	builder.WriteString(e.Description)
	builder.WriteString(", ")
	builder.WriteString("event_place=")
	builder.WriteString(e.EventPlace)
	builder.WriteString(", ")
	builder.WriteString("confirmed_count=")
	builder.WriteString(fmt.Sprintf("%v", e.ConfirmedCount))
	builder.WriteString(", ")
	builder.WriteString("confirmed_hosts=")
	builder.WriteString(fmt.Sprintf("%v", e.ConfirmedHosts))
	builder.WriteString(", ")
	builder.WriteString("event_pics=")
	builder.WriteString(fmt.Sprintf("%v", e.EventPics))
	builder.WriteString(", ")
	builder.WriteString("light_event_pics=")
	builder.WriteString(fmt.Sprintf("%v", e.LightEventPics))
	builder.WriteString(", ")
	builder.WriteString("event_key=")
	builder.WriteString(e.EventKey)
	builder.WriteString(", ")
	builder.WriteString("event_nonce=")
	builder.WriteString(e.EventNonce)
	builder.WriteString(", ")
	builder.WriteString("event_date=")
	builder.WriteString(e.EventDate.Format(time.ANSIC))
	builder.WriteString(", ")
	builder.WriteString("coords=")
	builder.WriteString(fmt.Sprintf("%v", e.Coords))
	builder.WriteString(", ")
	builder.WriteString("created_at=")
	builder.WriteString(e.CreatedAt.Format(time.ANSIC))
	builder.WriteString(", ")
	builder.WriteString("updated_at=")
	builder.WriteString(e.UpdatedAt.Format(time.ANSIC))
	builder.WriteByte(')')
	return builder.String()
}

// NamedUsers returns the Users named value or an error if the edge was not
// loaded in eager-loading with this name.
func (e *Event) NamedUsers(name string) ([]*User, error) {
	if e.Edges.namedUsers == nil {
		return nil, &NotLoadedError{edge: name}
	}
	nodes, ok := e.Edges.namedUsers[name]
	if !ok {
		return nil, &NotLoadedError{edge: name}
	}
	return nodes, nil
}

func (e *Event) appendNamedUsers(name string, edges ...*User) {
	if e.Edges.namedUsers == nil {
		e.Edges.namedUsers = make(map[string][]*User)
	}
	if len(edges) == 0 {
		e.Edges.namedUsers[name] = []*User{}
	} else {
		e.Edges.namedUsers[name] = append(e.Edges.namedUsers[name], edges...)
	}
}

// NamedEventReminderNotifications returns the EventReminderNotifications named value or an error if the edge was not
// loaded in eager-loading with this name.
func (e *Event) NamedEventReminderNotifications(name string) ([]*EventReminderNotification, error) {
	if e.Edges.namedEventReminderNotifications == nil {
		return nil, &NotLoadedError{edge: name}
	}
	nodes, ok := e.Edges.namedEventReminderNotifications[name]
	if !ok {
		return nil, &NotLoadedError{edge: name}
	}
	return nodes, nil
}

func (e *Event) appendNamedEventReminderNotifications(name string, edges ...*EventReminderNotification) {
	if e.Edges.namedEventReminderNotifications == nil {
		e.Edges.namedEventReminderNotifications = make(map[string][]*EventReminderNotification)
	}
	if len(edges) == 0 {
		e.Edges.namedEventReminderNotifications[name] = []*EventReminderNotification{}
	} else {
		e.Edges.namedEventReminderNotifications[name] = append(e.Edges.namedEventReminderNotifications[name], edges...)
	}
}

// NamedEventUsers returns the EventUsers named value or an error if the edge was not
// loaded in eager-loading with this name.
func (e *Event) NamedEventUsers(name string) ([]*EventUser, error) {
	if e.Edges.namedEventUsers == nil {
		return nil, &NotLoadedError{edge: name}
	}
	nodes, ok := e.Edges.namedEventUsers[name]
	if !ok {
		return nil, &NotLoadedError{edge: name}
	}
	return nodes, nil
}

func (e *Event) appendNamedEventUsers(name string, edges ...*EventUser) {
	if e.Edges.namedEventUsers == nil {
		e.Edges.namedEventUsers = make(map[string][]*EventUser)
	}
	if len(edges) == 0 {
		e.Edges.namedEventUsers[name] = []*EventUser{}
	} else {
		e.Edges.namedEventUsers[name] = append(e.Edges.namedEventUsers[name], edges...)
	}
}

// Events is a parsable slice of Event.
type Events []*Event