//go:build ignore
// +build ignore

package main

import (
	// "errors"
	"log"

	"entgo.io/contrib/entgql"
	"entgo.io/ent/entc"
	"entgo.io/ent/entc/gen"
)

func main() {
	// rt := reflect.TypeOf(uuid.UUID{})
	ex, err := entgql.NewExtension(
		// entgql.Skip("Device"),
		entgql.WithSchemaGenerator(),
		entgql.WithSchemaPath("ent.graphql"),
		entgql.WithConfigPath("../gqlgen.yml"),
	)
	if err != nil {
		log.Fatalf("Error: failed creating entgql extension: %v", err)
	}
	opts := []entc.Option{
		entc.Extensions(ex),
	}
	if err := entc.Generate("./schema", &gen.Config{
		Features: []gen.Feature{
			gen.FeatureUpsert,
			gen.FeatureExecQuery,
			gen.FeatureEntQL,
		},
		// IDType: &field.TypeInfo{
		// 	Type: field.TypeString,
		// },
	}, opts...); err != nil {
		log.Fatalf("Error: failed running ent codegen: %v", err)
	}
}

// package main

// import (
// 	"log"

// 	"entgo.io/contrib/entgql"
// 	"entgo.io/ent/entc"
// 	"entgo.io/ent/entc/gen"
// )

// func main() {
// 	ex, err := entgql.NewExtension()
// 	if err != nil {
// 		log.Fatalf("creating entgql extension: %v", err)
// 	}
// 	if err := entc.Generate("./schema", &gen.Config{}, entc.Extensions(ex)); err != nil {
// 		log.Fatalf("running ent codegen: %v", err)
// 	}
// }
