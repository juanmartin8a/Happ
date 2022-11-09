package schema

import (
	"time"

	"entgo.io/ent"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema/edge"
	"entgo.io/ent/schema/field"
)

// func (User) Annotations() []schema.Annotation {
// 	return []schema.Annotation{
// 		// field.ID("user_id", "follower_id"),
// 		entgql.QueryField(),
// 		entgql.Mutations(entgql.MutationCreate()),
// 	}
// }

// User holds the schema definition for the User entity.
type User struct {
	ent.Schema
}

// Fields of the User.
func (User) Fields() []ent.Field {
	return []ent.Field{
		field.String("name").
			NotEmpty().
			MaxLen(255),
		field.String("username").
			NotEmpty().
			MaxLen(255).
			Unique(),
		field.String("email").
			NotEmpty().
			MaxLen(255).
			Unique(),
		field.String("profile_pic").
			NotEmpty().
			MaxLen(255),
		field.Time("birthday").
			SchemaType(map[string]string{
				dialect.MySQL: "date",
			}),
		field.String("password").
			NotEmpty().
			MaxLen(255),
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
func (User) Edges() []ent.Edge {
	return []ent.Edge{
		edge.From("events", Event.Type).
			Ref("users").
			Through("event_user", EventUser.Type),
		edge.To("friends", User.Type).
			Through("friendships", Friendship.Type),
		edge.To("following", User.Type).
			From("followers").
			Through("follow", Follow.Type),

		// Through("friendships", Friendship.Type),

		// edge.To("following", User.Type).
		// 	From("followers"),
		// edge.To("friends", User.Type),
	}
}
