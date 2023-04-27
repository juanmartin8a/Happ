// Code generated by ent, DO NOT EDIT.

package eventuser

import (
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

const (
	// Label holds the string label denoting the eventuser type in the database.
	Label = "event_user"
	// FieldEventID holds the string denoting the event_id field in the database.
	FieldEventID = "event_id"
	// FieldUserID holds the string denoting the user_id field in the database.
	FieldUserID = "user_id"
	// FieldInvitedBy holds the string denoting the invited_by field in the database.
	FieldInvitedBy = "invited_by"
	// FieldAdmin holds the string denoting the admin field in the database.
	FieldAdmin = "admin"
	// FieldCreator holds the string denoting the creator field in the database.
	FieldCreator = "creator"
	// FieldConfirmed holds the string denoting the confirmed field in the database.
	FieldConfirmed = "confirmed"
	// FieldCreatedAt holds the string denoting the created_at field in the database.
	FieldCreatedAt = "created_at"
	// EdgeEvent holds the string denoting the event edge name in mutations.
	EdgeEvent = "event"
	// EdgeUser holds the string denoting the user edge name in mutations.
	EdgeUser = "user"
	// EventFieldID holds the string denoting the ID field of the Event.
	EventFieldID = "id"
	// UserFieldID holds the string denoting the ID field of the User.
	UserFieldID = "id"
	// Table holds the table name of the eventuser in the database.
	Table = "event_users"
	// EventTable is the table that holds the event relation/edge.
	EventTable = "event_users"
	// EventInverseTable is the table name for the Event entity.
	// It exists in this package in order to avoid circular dependency with the "event" package.
	EventInverseTable = "events"
	// EventColumn is the table column denoting the event relation/edge.
	EventColumn = "event_id"
	// UserTable is the table that holds the user relation/edge.
	UserTable = "event_users"
	// UserInverseTable is the table name for the User entity.
	// It exists in this package in order to avoid circular dependency with the "user" package.
	UserInverseTable = "users"
	// UserColumn is the table column denoting the user relation/edge.
	UserColumn = "user_id"
)

// Columns holds all SQL columns for eventuser fields.
var Columns = []string{
	FieldEventID,
	FieldUserID,
	FieldInvitedBy,
	FieldAdmin,
	FieldCreator,
	FieldConfirmed,
	FieldCreatedAt,
}

// ValidColumn reports if the column name is valid (part of the table columns).
func ValidColumn(column string) bool {
	for i := range Columns {
		if column == Columns[i] {
			return true
		}
	}
	return false
}

var (
	// DefaultAdmin holds the default value on creation for the "admin" field.
	DefaultAdmin bool
	// DefaultCreator holds the default value on creation for the "creator" field.
	DefaultCreator bool
	// DefaultConfirmed holds the default value on creation for the "confirmed" field.
	DefaultConfirmed bool
	// DefaultCreatedAt holds the default value on creation for the "created_at" field.
	DefaultCreatedAt func() time.Time
)

// OrderOption defines the ordering options for the EventUser queries.
type OrderOption func(*sql.Selector)

// ByEventID orders the results by the event_id field.
func ByEventID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEventID, opts...).ToFunc()
}

// ByUserID orders the results by the user_id field.
func ByUserID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldUserID, opts...).ToFunc()
}

// ByInvitedBy orders the results by the invited_by field.
func ByInvitedBy(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldInvitedBy, opts...).ToFunc()
}

// ByAdmin orders the results by the admin field.
func ByAdmin(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldAdmin, opts...).ToFunc()
}

// ByCreator orders the results by the creator field.
func ByCreator(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCreator, opts...).ToFunc()
}

// ByConfirmed orders the results by the confirmed field.
func ByConfirmed(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldConfirmed, opts...).ToFunc()
}

// ByCreatedAt orders the results by the created_at field.
func ByCreatedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCreatedAt, opts...).ToFunc()
}

// ByEventField orders the results by event field.
func ByEventField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventStep(), sql.OrderByField(field, opts...))
	}
}

// ByUserField orders the results by user field.
func ByUserField(field string, opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newUserStep(), sql.OrderByField(field, opts...))
	}
}
func newEventStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, EventColumn),
		sqlgraph.To(EventInverseTable, EventFieldID),
		sqlgraph.Edge(sqlgraph.M2O, false, EventTable, EventColumn),
	)
}
func newUserStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, UserColumn),
		sqlgraph.To(UserInverseTable, UserFieldID),
		sqlgraph.Edge(sqlgraph.M2O, false, UserTable, UserColumn),
	)
}