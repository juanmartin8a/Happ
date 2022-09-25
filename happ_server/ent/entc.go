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
	ex, err := entgql.NewExtension()
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
	}, opts...); err != nil {
		log.Fatalf("Error: failed running ent codegen: %v", err)
	}
}
