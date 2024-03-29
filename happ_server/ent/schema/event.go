package schema

import (
	"happ/ent/schema/schematype"
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// func (Event) Annotations() []schema.Annotation {
// 	return []schema.Annotation{
// 		// field.ID("user_id", "follower_id"),
// 		entgql.QueryField(),
// 		entgql.Mutations(entgql.MutationCreate()),
// 	}
// }

// User holds the schema definition for the User entity.
type Event struct {
	ent.Schema
}

// event is a many to many relationship because many users can be part of an event and user can be in many events

// Fields of the Event.
func (Event) Fields() []ent.Field {
	return []ent.Field{
		field.String("name").
			NotEmpty().
			MaxLen(255),
		field.String("description").
			NotEmpty(),
		field.String("event_place").
			NotEmpty(),
		field.Int("confirmed_count").
			Default(1),
		field.Int("confirmed_hosts").
			Default(1),
		field.JSON("event_pics", []string{}),
		field.JSON("light_event_pics", []string{}),
		field.String("event_key").
			NotEmpty(),
		field.String("event_nonce").
			NotEmpty(),
		field.Time("event_date").
			SchemaType(map[string]string{
				dialect.MySQL: "datetime",
			}),
		field.Other("coords", &schematype.Point{}).
			SchemaType(schematype.Point{}.SchemaType()),
		field.Time("created_at").
			Default(time.Now).
			SchemaType(map[string]string{
				dialect.MySQL: "datetime",
			}).
			Annotations(&entsql.Annotation{
				Default: "CURRENT_TIMESTAMP",
			}).
			Immutable(),
		field.Time("updated_at").
			Default(time.Now).
			SchemaType(map[string]string{
				dialect.MySQL: "datetime",
			}).
			Annotations(&entsql.Annotation{
				Default: "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP",
			}).
			Immutable(),
	}
}

// Edges of the User.
func (Event) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("users", User.Type).
			Through("event_users", EventUser.Type),

		edge.To("event_reminder_notifications", EventReminderNotification.Type),
	}
}
