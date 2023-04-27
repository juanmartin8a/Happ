// Code generated by ent, DO NOT EDIT.

package event

import (
	"happ/ent/predicate"
	"happ/ent/schema/schematype"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

// ID filters vertices based on their ID field.
func ID(id int) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldID, id))
}

// IDEQ applies the EQ predicate on the ID field.
func IDEQ(id int) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldID, id))
}

// IDNEQ applies the NEQ predicate on the ID field.
func IDNEQ(id int) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldID, id))
}

// IDIn applies the In predicate on the ID field.
func IDIn(ids ...int) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldID, ids...))
}

// IDNotIn applies the NotIn predicate on the ID field.
func IDNotIn(ids ...int) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldID, ids...))
}

// IDGT applies the GT predicate on the ID field.
func IDGT(id int) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldID, id))
}

// IDGTE applies the GTE predicate on the ID field.
func IDGTE(id int) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldID, id))
}

// IDLT applies the LT predicate on the ID field.
func IDLT(id int) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldID, id))
}

// IDLTE applies the LTE predicate on the ID field.
func IDLTE(id int) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldID, id))
}

// Name applies equality check predicate on the "name" field. It's identical to NameEQ.
func Name(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldName, v))
}

// Description applies equality check predicate on the "description" field. It's identical to DescriptionEQ.
func Description(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldDescription, v))
}

// EventPlace applies equality check predicate on the "event_place" field. It's identical to EventPlaceEQ.
func EventPlace(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventPlace, v))
}

// ConfirmedCount applies equality check predicate on the "confirmed_count" field. It's identical to ConfirmedCountEQ.
func ConfirmedCount(v int) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldConfirmedCount, v))
}

// ConfirmedHosts applies equality check predicate on the "confirmed_hosts" field. It's identical to ConfirmedHostsEQ.
func ConfirmedHosts(v int) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldConfirmedHosts, v))
}

// EventKey applies equality check predicate on the "event_key" field. It's identical to EventKeyEQ.
func EventKey(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventKey, v))
}

// EventNonce applies equality check predicate on the "event_nonce" field. It's identical to EventNonceEQ.
func EventNonce(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventNonce, v))
}

// EventDate applies equality check predicate on the "event_date" field. It's identical to EventDateEQ.
func EventDate(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventDate, v))
}

// Coords applies equality check predicate on the "coords" field. It's identical to CoordsEQ.
func Coords(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldCoords, v))
}

// CreatedAt applies equality check predicate on the "created_at" field. It's identical to CreatedAtEQ.
func CreatedAt(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldCreatedAt, v))
}

// UpdatedAt applies equality check predicate on the "updated_at" field. It's identical to UpdatedAtEQ.
func UpdatedAt(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldUpdatedAt, v))
}

// NameEQ applies the EQ predicate on the "name" field.
func NameEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldName, v))
}

// NameNEQ applies the NEQ predicate on the "name" field.
func NameNEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldName, v))
}

// NameIn applies the In predicate on the "name" field.
func NameIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldName, vs...))
}

// NameNotIn applies the NotIn predicate on the "name" field.
func NameNotIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldName, vs...))
}

// NameGT applies the GT predicate on the "name" field.
func NameGT(v string) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldName, v))
}

// NameGTE applies the GTE predicate on the "name" field.
func NameGTE(v string) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldName, v))
}

// NameLT applies the LT predicate on the "name" field.
func NameLT(v string) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldName, v))
}

// NameLTE applies the LTE predicate on the "name" field.
func NameLTE(v string) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldName, v))
}

// NameContains applies the Contains predicate on the "name" field.
func NameContains(v string) predicate.Event {
	return predicate.Event(sql.FieldContains(FieldName, v))
}

// NameHasPrefix applies the HasPrefix predicate on the "name" field.
func NameHasPrefix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasPrefix(FieldName, v))
}

// NameHasSuffix applies the HasSuffix predicate on the "name" field.
func NameHasSuffix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasSuffix(FieldName, v))
}

// NameEqualFold applies the EqualFold predicate on the "name" field.
func NameEqualFold(v string) predicate.Event {
	return predicate.Event(sql.FieldEqualFold(FieldName, v))
}

// NameContainsFold applies the ContainsFold predicate on the "name" field.
func NameContainsFold(v string) predicate.Event {
	return predicate.Event(sql.FieldContainsFold(FieldName, v))
}

// DescriptionEQ applies the EQ predicate on the "description" field.
func DescriptionEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldDescription, v))
}

// DescriptionNEQ applies the NEQ predicate on the "description" field.
func DescriptionNEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldDescription, v))
}

// DescriptionIn applies the In predicate on the "description" field.
func DescriptionIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldDescription, vs...))
}

// DescriptionNotIn applies the NotIn predicate on the "description" field.
func DescriptionNotIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldDescription, vs...))
}

// DescriptionGT applies the GT predicate on the "description" field.
func DescriptionGT(v string) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldDescription, v))
}

// DescriptionGTE applies the GTE predicate on the "description" field.
func DescriptionGTE(v string) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldDescription, v))
}

// DescriptionLT applies the LT predicate on the "description" field.
func DescriptionLT(v string) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldDescription, v))
}

// DescriptionLTE applies the LTE predicate on the "description" field.
func DescriptionLTE(v string) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldDescription, v))
}

// DescriptionContains applies the Contains predicate on the "description" field.
func DescriptionContains(v string) predicate.Event {
	return predicate.Event(sql.FieldContains(FieldDescription, v))
}

// DescriptionHasPrefix applies the HasPrefix predicate on the "description" field.
func DescriptionHasPrefix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasPrefix(FieldDescription, v))
}

// DescriptionHasSuffix applies the HasSuffix predicate on the "description" field.
func DescriptionHasSuffix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasSuffix(FieldDescription, v))
}

// DescriptionEqualFold applies the EqualFold predicate on the "description" field.
func DescriptionEqualFold(v string) predicate.Event {
	return predicate.Event(sql.FieldEqualFold(FieldDescription, v))
}

// DescriptionContainsFold applies the ContainsFold predicate on the "description" field.
func DescriptionContainsFold(v string) predicate.Event {
	return predicate.Event(sql.FieldContainsFold(FieldDescription, v))
}

// EventPlaceEQ applies the EQ predicate on the "event_place" field.
func EventPlaceEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventPlace, v))
}

// EventPlaceNEQ applies the NEQ predicate on the "event_place" field.
func EventPlaceNEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldEventPlace, v))
}

// EventPlaceIn applies the In predicate on the "event_place" field.
func EventPlaceIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldEventPlace, vs...))
}

// EventPlaceNotIn applies the NotIn predicate on the "event_place" field.
func EventPlaceNotIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldEventPlace, vs...))
}

// EventPlaceGT applies the GT predicate on the "event_place" field.
func EventPlaceGT(v string) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldEventPlace, v))
}

// EventPlaceGTE applies the GTE predicate on the "event_place" field.
func EventPlaceGTE(v string) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldEventPlace, v))
}

// EventPlaceLT applies the LT predicate on the "event_place" field.
func EventPlaceLT(v string) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldEventPlace, v))
}

// EventPlaceLTE applies the LTE predicate on the "event_place" field.
func EventPlaceLTE(v string) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldEventPlace, v))
}

// EventPlaceContains applies the Contains predicate on the "event_place" field.
func EventPlaceContains(v string) predicate.Event {
	return predicate.Event(sql.FieldContains(FieldEventPlace, v))
}

// EventPlaceHasPrefix applies the HasPrefix predicate on the "event_place" field.
func EventPlaceHasPrefix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasPrefix(FieldEventPlace, v))
}

// EventPlaceHasSuffix applies the HasSuffix predicate on the "event_place" field.
func EventPlaceHasSuffix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasSuffix(FieldEventPlace, v))
}

// EventPlaceEqualFold applies the EqualFold predicate on the "event_place" field.
func EventPlaceEqualFold(v string) predicate.Event {
	return predicate.Event(sql.FieldEqualFold(FieldEventPlace, v))
}

// EventPlaceContainsFold applies the ContainsFold predicate on the "event_place" field.
func EventPlaceContainsFold(v string) predicate.Event {
	return predicate.Event(sql.FieldContainsFold(FieldEventPlace, v))
}

// ConfirmedCountEQ applies the EQ predicate on the "confirmed_count" field.
func ConfirmedCountEQ(v int) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldConfirmedCount, v))
}

// ConfirmedCountNEQ applies the NEQ predicate on the "confirmed_count" field.
func ConfirmedCountNEQ(v int) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldConfirmedCount, v))
}

// ConfirmedCountIn applies the In predicate on the "confirmed_count" field.
func ConfirmedCountIn(vs ...int) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldConfirmedCount, vs...))
}

// ConfirmedCountNotIn applies the NotIn predicate on the "confirmed_count" field.
func ConfirmedCountNotIn(vs ...int) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldConfirmedCount, vs...))
}

// ConfirmedCountGT applies the GT predicate on the "confirmed_count" field.
func ConfirmedCountGT(v int) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldConfirmedCount, v))
}

// ConfirmedCountGTE applies the GTE predicate on the "confirmed_count" field.
func ConfirmedCountGTE(v int) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldConfirmedCount, v))
}

// ConfirmedCountLT applies the LT predicate on the "confirmed_count" field.
func ConfirmedCountLT(v int) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldConfirmedCount, v))
}

// ConfirmedCountLTE applies the LTE predicate on the "confirmed_count" field.
func ConfirmedCountLTE(v int) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldConfirmedCount, v))
}

// ConfirmedHostsEQ applies the EQ predicate on the "confirmed_hosts" field.
func ConfirmedHostsEQ(v int) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldConfirmedHosts, v))
}

// ConfirmedHostsNEQ applies the NEQ predicate on the "confirmed_hosts" field.
func ConfirmedHostsNEQ(v int) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldConfirmedHosts, v))
}

// ConfirmedHostsIn applies the In predicate on the "confirmed_hosts" field.
func ConfirmedHostsIn(vs ...int) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldConfirmedHosts, vs...))
}

// ConfirmedHostsNotIn applies the NotIn predicate on the "confirmed_hosts" field.
func ConfirmedHostsNotIn(vs ...int) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldConfirmedHosts, vs...))
}

// ConfirmedHostsGT applies the GT predicate on the "confirmed_hosts" field.
func ConfirmedHostsGT(v int) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldConfirmedHosts, v))
}

// ConfirmedHostsGTE applies the GTE predicate on the "confirmed_hosts" field.
func ConfirmedHostsGTE(v int) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldConfirmedHosts, v))
}

// ConfirmedHostsLT applies the LT predicate on the "confirmed_hosts" field.
func ConfirmedHostsLT(v int) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldConfirmedHosts, v))
}

// ConfirmedHostsLTE applies the LTE predicate on the "confirmed_hosts" field.
func ConfirmedHostsLTE(v int) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldConfirmedHosts, v))
}

// EventKeyEQ applies the EQ predicate on the "event_key" field.
func EventKeyEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventKey, v))
}

// EventKeyNEQ applies the NEQ predicate on the "event_key" field.
func EventKeyNEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldEventKey, v))
}

// EventKeyIn applies the In predicate on the "event_key" field.
func EventKeyIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldEventKey, vs...))
}

// EventKeyNotIn applies the NotIn predicate on the "event_key" field.
func EventKeyNotIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldEventKey, vs...))
}

// EventKeyGT applies the GT predicate on the "event_key" field.
func EventKeyGT(v string) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldEventKey, v))
}

// EventKeyGTE applies the GTE predicate on the "event_key" field.
func EventKeyGTE(v string) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldEventKey, v))
}

// EventKeyLT applies the LT predicate on the "event_key" field.
func EventKeyLT(v string) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldEventKey, v))
}

// EventKeyLTE applies the LTE predicate on the "event_key" field.
func EventKeyLTE(v string) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldEventKey, v))
}

// EventKeyContains applies the Contains predicate on the "event_key" field.
func EventKeyContains(v string) predicate.Event {
	return predicate.Event(sql.FieldContains(FieldEventKey, v))
}

// EventKeyHasPrefix applies the HasPrefix predicate on the "event_key" field.
func EventKeyHasPrefix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasPrefix(FieldEventKey, v))
}

// EventKeyHasSuffix applies the HasSuffix predicate on the "event_key" field.
func EventKeyHasSuffix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasSuffix(FieldEventKey, v))
}

// EventKeyEqualFold applies the EqualFold predicate on the "event_key" field.
func EventKeyEqualFold(v string) predicate.Event {
	return predicate.Event(sql.FieldEqualFold(FieldEventKey, v))
}

// EventKeyContainsFold applies the ContainsFold predicate on the "event_key" field.
func EventKeyContainsFold(v string) predicate.Event {
	return predicate.Event(sql.FieldContainsFold(FieldEventKey, v))
}

// EventNonceEQ applies the EQ predicate on the "event_nonce" field.
func EventNonceEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventNonce, v))
}

// EventNonceNEQ applies the NEQ predicate on the "event_nonce" field.
func EventNonceNEQ(v string) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldEventNonce, v))
}

// EventNonceIn applies the In predicate on the "event_nonce" field.
func EventNonceIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldEventNonce, vs...))
}

// EventNonceNotIn applies the NotIn predicate on the "event_nonce" field.
func EventNonceNotIn(vs ...string) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldEventNonce, vs...))
}

// EventNonceGT applies the GT predicate on the "event_nonce" field.
func EventNonceGT(v string) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldEventNonce, v))
}

// EventNonceGTE applies the GTE predicate on the "event_nonce" field.
func EventNonceGTE(v string) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldEventNonce, v))
}

// EventNonceLT applies the LT predicate on the "event_nonce" field.
func EventNonceLT(v string) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldEventNonce, v))
}

// EventNonceLTE applies the LTE predicate on the "event_nonce" field.
func EventNonceLTE(v string) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldEventNonce, v))
}

// EventNonceContains applies the Contains predicate on the "event_nonce" field.
func EventNonceContains(v string) predicate.Event {
	return predicate.Event(sql.FieldContains(FieldEventNonce, v))
}

// EventNonceHasPrefix applies the HasPrefix predicate on the "event_nonce" field.
func EventNonceHasPrefix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasPrefix(FieldEventNonce, v))
}

// EventNonceHasSuffix applies the HasSuffix predicate on the "event_nonce" field.
func EventNonceHasSuffix(v string) predicate.Event {
	return predicate.Event(sql.FieldHasSuffix(FieldEventNonce, v))
}

// EventNonceEqualFold applies the EqualFold predicate on the "event_nonce" field.
func EventNonceEqualFold(v string) predicate.Event {
	return predicate.Event(sql.FieldEqualFold(FieldEventNonce, v))
}

// EventNonceContainsFold applies the ContainsFold predicate on the "event_nonce" field.
func EventNonceContainsFold(v string) predicate.Event {
	return predicate.Event(sql.FieldContainsFold(FieldEventNonce, v))
}

// EventDateEQ applies the EQ predicate on the "event_date" field.
func EventDateEQ(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldEventDate, v))
}

// EventDateNEQ applies the NEQ predicate on the "event_date" field.
func EventDateNEQ(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldEventDate, v))
}

// EventDateIn applies the In predicate on the "event_date" field.
func EventDateIn(vs ...time.Time) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldEventDate, vs...))
}

// EventDateNotIn applies the NotIn predicate on the "event_date" field.
func EventDateNotIn(vs ...time.Time) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldEventDate, vs...))
}

// EventDateGT applies the GT predicate on the "event_date" field.
func EventDateGT(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldEventDate, v))
}

// EventDateGTE applies the GTE predicate on the "event_date" field.
func EventDateGTE(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldEventDate, v))
}

// EventDateLT applies the LT predicate on the "event_date" field.
func EventDateLT(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldEventDate, v))
}

// EventDateLTE applies the LTE predicate on the "event_date" field.
func EventDateLTE(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldEventDate, v))
}

// CoordsEQ applies the EQ predicate on the "coords" field.
func CoordsEQ(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldCoords, v))
}

// CoordsNEQ applies the NEQ predicate on the "coords" field.
func CoordsNEQ(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldCoords, v))
}

// CoordsIn applies the In predicate on the "coords" field.
func CoordsIn(vs ...*schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldCoords, vs...))
}

// CoordsNotIn applies the NotIn predicate on the "coords" field.
func CoordsNotIn(vs ...*schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldCoords, vs...))
}

// CoordsGT applies the GT predicate on the "coords" field.
func CoordsGT(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldCoords, v))
}

// CoordsGTE applies the GTE predicate on the "coords" field.
func CoordsGTE(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldCoords, v))
}

// CoordsLT applies the LT predicate on the "coords" field.
func CoordsLT(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldCoords, v))
}

// CoordsLTE applies the LTE predicate on the "coords" field.
func CoordsLTE(v *schematype.Point) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldCoords, v))
}

// CreatedAtEQ applies the EQ predicate on the "created_at" field.
func CreatedAtEQ(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldCreatedAt, v))
}

// CreatedAtNEQ applies the NEQ predicate on the "created_at" field.
func CreatedAtNEQ(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldCreatedAt, v))
}

// CreatedAtIn applies the In predicate on the "created_at" field.
func CreatedAtIn(vs ...time.Time) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldCreatedAt, vs...))
}

// CreatedAtNotIn applies the NotIn predicate on the "created_at" field.
func CreatedAtNotIn(vs ...time.Time) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldCreatedAt, vs...))
}

// CreatedAtGT applies the GT predicate on the "created_at" field.
func CreatedAtGT(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldCreatedAt, v))
}

// CreatedAtGTE applies the GTE predicate on the "created_at" field.
func CreatedAtGTE(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldCreatedAt, v))
}

// CreatedAtLT applies the LT predicate on the "created_at" field.
func CreatedAtLT(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldCreatedAt, v))
}

// CreatedAtLTE applies the LTE predicate on the "created_at" field.
func CreatedAtLTE(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldCreatedAt, v))
}

// UpdatedAtEQ applies the EQ predicate on the "updated_at" field.
func UpdatedAtEQ(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldEQ(FieldUpdatedAt, v))
}

// UpdatedAtNEQ applies the NEQ predicate on the "updated_at" field.
func UpdatedAtNEQ(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldNEQ(FieldUpdatedAt, v))
}

// UpdatedAtIn applies the In predicate on the "updated_at" field.
func UpdatedAtIn(vs ...time.Time) predicate.Event {
	return predicate.Event(sql.FieldIn(FieldUpdatedAt, vs...))
}

// UpdatedAtNotIn applies the NotIn predicate on the "updated_at" field.
func UpdatedAtNotIn(vs ...time.Time) predicate.Event {
	return predicate.Event(sql.FieldNotIn(FieldUpdatedAt, vs...))
}

// UpdatedAtGT applies the GT predicate on the "updated_at" field.
func UpdatedAtGT(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldGT(FieldUpdatedAt, v))
}

// UpdatedAtGTE applies the GTE predicate on the "updated_at" field.
func UpdatedAtGTE(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldGTE(FieldUpdatedAt, v))
}

// UpdatedAtLT applies the LT predicate on the "updated_at" field.
func UpdatedAtLT(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldLT(FieldUpdatedAt, v))
}

// UpdatedAtLTE applies the LTE predicate on the "updated_at" field.
func UpdatedAtLTE(v time.Time) predicate.Event {
	return predicate.Event(sql.FieldLTE(FieldUpdatedAt, v))
}

// HasUsers applies the HasEdge predicate on the "users" edge.
func HasUsers() predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, FieldID),
			sqlgraph.Edge(sqlgraph.M2M, false, UsersTable, UsersPrimaryKey...),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasUsersWith applies the HasEdge predicate on the "users" edge with a given conditions (other predicates).
func HasUsersWith(preds ...predicate.User) predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		step := newUsersStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// HasEventReminderNotifications applies the HasEdge predicate on the "event_reminder_notifications" edge.
func HasEventReminderNotifications() predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, FieldID),
			sqlgraph.Edge(sqlgraph.O2M, false, EventReminderNotificationsTable, EventReminderNotificationsColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasEventReminderNotificationsWith applies the HasEdge predicate on the "event_reminder_notifications" edge with a given conditions (other predicates).
func HasEventReminderNotificationsWith(preds ...predicate.EventReminderNotification) predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		step := newEventReminderNotificationsStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// HasEventUsers applies the HasEdge predicate on the "event_users" edge.
func HasEventUsers() predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, FieldID),
			sqlgraph.Edge(sqlgraph.O2M, true, EventUsersTable, EventUsersColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasEventUsersWith applies the HasEdge predicate on the "event_users" edge with a given conditions (other predicates).
func HasEventUsersWith(preds ...predicate.EventUser) predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		step := newEventUsersStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// And groups predicates with the AND operator between them.
func And(predicates ...predicate.Event) predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		s1 := s.Clone().SetP(nil)
		for _, p := range predicates {
			p(s1)
		}
		s.Where(s1.P())
	})
}

// Or groups predicates with the OR operator between them.
func Or(predicates ...predicate.Event) predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		s1 := s.Clone().SetP(nil)
		for i, p := range predicates {
			if i > 0 {
				s1.Or()
			}
			p(s1)
		}
		s.Where(s1.P())
	})
}

// Not applies the not operator on the given predicate.
func Not(p predicate.Event) predicate.Event {
	return predicate.Event(func(s *sql.Selector) {
		p(s.Not())
	})
}