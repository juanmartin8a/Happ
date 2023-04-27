package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/dialect"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
)

// User holds the schema definition for the User entity.
type EventReminderNotification struct {
	ent.Schema
}

// Fields of the Event.
func (EventReminderNotification) Fields() []ent.Field {
	return []ent.Field{
		field.Int("event_id"),
		field.Int("user_id"),
		field.Int("days_left"),
		field.Time("sent_at").
			SchemaType(map[string]string{
				dialect.MySQL: "datetime",
			}),
	}
}

func (EventReminderNotification) Indexes() []ent.Index {
	return []ent.Index{
		// non-unique index.
		index.Fields("event_id", "user_id").Unique(),
	}
}

// Edges of the User.
func (EventReminderNotification) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("event", Event.Type).
			Ref("event_reminder_notifications").
			Field("event_id").
			Unique().
			Required(),

		edge.From("user", User.Type).
			Ref("event_reminder_notifications").
			Field("user_id").
			Unique().
			Required(),
	}
}
