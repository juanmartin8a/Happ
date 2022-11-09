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

type Friendship struct {
	ent.Schema
}

func (Friendship) Annotations() []schema.Annotation {
	return []schema.Annotation{
		field.ID("user_id", "friend_id"),
		// entgql.QueryField(),
		// entgql.Mutations(entgql.MutationCreate()),
	}
}

// Fields of the Friendship.
func (Friendship) Fields() []ent.Field {
	return []ent.Field{
		field.Int("user_id"),
		field.Int("friend_id"),
		field.Bool("user_id_friend"),
		field.Bool("friend_id_friend"),
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
func (Friendship) Edges() []ent.Edge {
	return []ent.Edge{
		edge.To("user", User.Type).
			Required().
			Unique().
			Field("user_id"),
		edge.To("friend", User.Type).
			Required().
			Unique().
			Field("friend_id"),
	}
}

// Indexes
// func (Friendship) Indexes() []ent.Index {
// 	return []ent.Index{
// 		index.Fields("user_id", "friend_id").
// 			Unique(),
// 	}
// }
