package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// User holds the schema definition for the User entity.
type EventUser struct {
	ent.Schema
}

func (EventUser) Annotations() []schema.Annotation {
	return []schema.Annotation{
		field.ID("event_id", "user_id"),
		// entgql.QueryField(),
		// entgql.Mutations(entgql.MutationCreate()),
	}
}

// Fields of the Event.
func (EventUser) Fields() []ent.Field {
	return []ent.Field{
		field.Int("event_id"),
		field.Int("user_id"),
		field.Int("invited_by"),
		field.Bool("admin").Default(false),
		field.Bool("creator").Default(false),
		field.Bool("confirmed").Default(false),
		field.Time("created_at").
			Default(time.Now).
			SchemaType(map[string]string{
				dialect.MySQL: "datetime",
			}).
			Annotations(&entsql.Annotation{
				Default: "CURRENT_TIMESTAMP",
			}).
			Immutable(),
	}
}

// Edges of the User.
func (EventUser) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("event", Event.Type).
			Unique().
			Required().
			Field("event_id"),
		edge.To("user", User.Type).
			Unique().
			Required().
			Field("user_id"),
	}
}
