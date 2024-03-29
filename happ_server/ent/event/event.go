// Code generated by ent, DO NOT EDIT.

package event

import (
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

const (
	// Label holds the string label denoting the event type in the database.
	Label = "event"
	// FieldID holds the string denoting the id field in the database.
	FieldID = "id"
	// FieldName holds the string denoting the name field in the database.
	FieldName = "name"
	// FieldDescription holds the string denoting the description field in the database.
	FieldDescription = "description"
	// FieldEventPlace holds the string denoting the event_place field in the database.
	FieldEventPlace = "event_place"
	// FieldConfirmedCount holds the string denoting the confirmed_count field in the database.
	FieldConfirmedCount = "confirmed_count"
	// FieldConfirmedHosts holds the string denoting the confirmed_hosts field in the database.
	FieldConfirmedHosts = "confirmed_hosts"
	// FieldEventPics holds the string denoting the event_pics field in the database.
	FieldEventPics = "event_pics"
	// FieldLightEventPics holds the string denoting the light_event_pics field in the database.
	FieldLightEventPics = "light_event_pics"
	// FieldEventKey holds the string denoting the event_key field in the database.
	FieldEventKey = "event_key"
	// FieldEventNonce holds the string denoting the event_nonce field in the database.
	FieldEventNonce = "event_nonce"
	// FieldEventDate holds the string denoting the event_date field in the database.
	FieldEventDate = "event_date"
	// FieldCoords holds the string denoting the coords field in the database.
	FieldCoords = "coords"
	// FieldCreatedAt holds the string denoting the created_at field in the database.
	FieldCreatedAt = "created_at"
	// FieldUpdatedAt holds the string denoting the updated_at field in the database.
	FieldUpdatedAt = "updated_at"
	// EdgeUsers holds the string denoting the users edge name in mutations.
	EdgeUsers = "users"
	// EdgeEventReminderNotifications holds the string denoting the event_reminder_notifications edge name in mutations.
	EdgeEventReminderNotifications = "event_reminder_notifications"
	// EdgeEventUsers holds the string denoting the event_users edge name in mutations.
	EdgeEventUsers = "event_users"
	// Table holds the table name of the event in the database.
	Table = "events"
	// UsersTable is the table that holds the users relation/edge. The primary key declared below.
	UsersTable = "event_users"
	// UsersInverseTable is the table name for the User entity.
	// It exists in this package in order to avoid circular dependency with the "user" package.
	UsersInverseTable = "users"
	// EventReminderNotificationsTable is the table that holds the event_reminder_notifications relation/edge.
	EventReminderNotificationsTable = "event_reminder_notifications"
	// EventReminderNotificationsInverseTable is the table name for the EventReminderNotification entity.
	// It exists in this package in order to avoid circular dependency with the "eventremindernotification" package.
	EventReminderNotificationsInverseTable = "event_reminder_notifications"
	// EventReminderNotificationsColumn is the table column denoting the event_reminder_notifications relation/edge.
	EventReminderNotificationsColumn = "event_id"
	// EventUsersTable is the table that holds the event_users relation/edge.
	EventUsersTable = "event_users"
	// EventUsersInverseTable is the table name for the EventUser entity.
	// It exists in this package in order to avoid circular dependency with the "eventuser" package.
	EventUsersInverseTable = "event_users"
	// EventUsersColumn is the table column denoting the event_users relation/edge.
	EventUsersColumn = "event_id"
)

// Columns holds all SQL columns for event fields.
var Columns = []string{
	FieldID,
	FieldName,
	FieldDescription,
	FieldEventPlace,
	FieldConfirmedCount,
	FieldConfirmedHosts,
	FieldEventPics,
	FieldLightEventPics,
	FieldEventKey,
	FieldEventNonce,
	FieldEventDate,
	FieldCoords,
	FieldCreatedAt,
	FieldUpdatedAt,
}

var (
	// UsersPrimaryKey and UsersColumn2 are the table columns denoting the
	// primary key for the users relation (M2M).
	UsersPrimaryKey = []string{"event_id", "user_id"}
)

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
	// NameValidator is a validator for the "name" field. It is called by the builders before save.
	NameValidator func(string) error
	// DescriptionValidator is a validator for the "description" field. It is called by the builders before save.
	DescriptionValidator func(string) error
	// EventPlaceValidator is a validator for the "event_place" field. It is called by the builders before save.
	EventPlaceValidator func(string) error
	// DefaultConfirmedCount holds the default value on creation for the "confirmed_count" field.
	DefaultConfirmedCount int
	// DefaultConfirmedHosts holds the default value on creation for the "confirmed_hosts" field.
	DefaultConfirmedHosts int
	// EventKeyValidator is a validator for the "event_key" field. It is called by the builders before save.
	EventKeyValidator func(string) error
	// EventNonceValidator is a validator for the "event_nonce" field. It is called by the builders before save.
	EventNonceValidator func(string) error
	// DefaultCreatedAt holds the default value on creation for the "created_at" field.
	DefaultCreatedAt func() time.Time
	// DefaultUpdatedAt holds the default value on creation for the "updated_at" field.
	DefaultUpdatedAt func() time.Time
)

// OrderOption defines the ordering options for the Event queries.
type OrderOption func(*sql.Selector)

// ByID orders the results by the id field.
func ByID(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldID, opts...).ToFunc()
}

// ByName orders the results by the name field.
func ByName(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldName, opts...).ToFunc()
}

// ByDescription orders the results by the description field.
func ByDescription(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldDescription, opts...).ToFunc()
}

// ByEventPlace orders the results by the event_place field.
func ByEventPlace(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEventPlace, opts...).ToFunc()
}

// ByConfirmedCount orders the results by the confirmed_count field.
func ByConfirmedCount(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldConfirmedCount, opts...).ToFunc()
}

// ByConfirmedHosts orders the results by the confirmed_hosts field.
func ByConfirmedHosts(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldConfirmedHosts, opts...).ToFunc()
}

// ByEventKey orders the results by the event_key field.
func ByEventKey(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEventKey, opts...).ToFunc()
}

// ByEventNonce orders the results by the event_nonce field.
func ByEventNonce(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEventNonce, opts...).ToFunc()
}

// ByEventDate orders the results by the event_date field.
func ByEventDate(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldEventDate, opts...).ToFunc()
}

// ByCoords orders the results by the coords field.
func ByCoords(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCoords, opts...).ToFunc()
}

// ByCreatedAt orders the results by the created_at field.
func ByCreatedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldCreatedAt, opts...).ToFunc()
}

// ByUpdatedAt orders the results by the updated_at field.
func ByUpdatedAt(opts ...sql.OrderTermOption) OrderOption {
	return sql.OrderByField(FieldUpdatedAt, opts...).ToFunc()
}

// ByUsersCount orders the results by users count.
func ByUsersCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newUsersStep(), opts...)
	}
}

// ByUsers orders the results by users terms.
func ByUsers(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newUsersStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// ByEventReminderNotificationsCount orders the results by event_reminder_notifications count.
func ByEventReminderNotificationsCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newEventReminderNotificationsStep(), opts...)
	}
}

// ByEventReminderNotifications orders the results by event_reminder_notifications terms.
func ByEventReminderNotifications(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventReminderNotificationsStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}

// ByEventUsersCount orders the results by event_users count.
func ByEventUsersCount(opts ...sql.OrderTermOption) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborsCount(s, newEventUsersStep(), opts...)
	}
}

// ByEventUsers orders the results by event_users terms.
func ByEventUsers(term sql.OrderTerm, terms ...sql.OrderTerm) OrderOption {
	return func(s *sql.Selector) {
		sqlgraph.OrderByNeighborTerms(s, newEventUsersStep(), append([]sql.OrderTerm{term}, terms...)...)
	}
}
func newUsersStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(UsersInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.M2M, false, UsersTable, UsersPrimaryKey...),
	)
}
func newEventReminderNotificationsStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(EventReminderNotificationsInverseTable, FieldID),
		sqlgraph.Edge(sqlgraph.O2M, false, EventReminderNotificationsTable, EventReminderNotificationsColumn),
	)
}
func newEventUsersStep() *sqlgraph.Step {
	return sqlgraph.NewStep(
		sqlgraph.From(Table, FieldID),
		sqlgraph.To(EventUsersInverseTable, EventUsersColumn),
		sqlgraph.Edge(sqlgraph.O2M, true, EventUsersTable, EventUsersColumn),
	)
}
