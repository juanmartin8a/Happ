package typesUtils

import (
	"fmt"
	"strconv"

	"github.com/99designs/gqlgen/graphql"
)

type CustomID string

func MarshalCustomID(id CustomID) graphql.Marshaler {
	return graphql.MarshalString(string(id))
}

func UnmarshalCustomID(v interface{}) (CustomID, error) {
	switch value := v.(type) {
	case string:
		return CustomID(value), nil
	case int:
		return CustomID(strconv.Itoa(value)), nil
	case int32:
		return CustomID(strconv.FormatInt(int64(value), 10)), nil
	case int64:
		return CustomID(strconv.FormatInt(value, 10)), nil
	default:
		return "", fmt.Errorf("CustomID must be a string or an int, got %T", v)
	}
}
