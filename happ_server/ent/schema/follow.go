package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
	"entgo.io/ent/schema/index"
)

type Follow struct {
	ent.Schema
}

func (Follow) Annotations() []schema.Annotation {
	return []schema.Annotation{
		field.ID("user_id", "follower_id"),
	}
}

// Fields of the Friendship.
func (Follow) Fields() []ent.Field {
	return []ent.Field{
		field.Int("user_id"),
		field.Int("follower_id"),
		field.Bool("valid").Default(true),
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

// Edges of the Friendship.
func (Follow) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("user", User.Type).
			Required().
			Unique().
			Field("user_id"),
		edge.To("follower", User.Type).
			Required().
			Unique().
			Field("follower_id"),
	}
}

// Indexes
func (Follow) Indexes() []ent.Index {
	return []ent.Index{
		index.Fields("user_id", "follower_id").
			Unique(),
	}
}
