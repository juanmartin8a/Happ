// Code generated by ent, DO NOT EDIT.

package eventuser

import (
	"happ/ent/predicate"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

// EventID applies equality check predicate on the "event_id" field. It's identical to EventIDEQ.
func EventID(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldEventID, v))
}

// UserID applies equality check predicate on the "user_id" field. It's identical to UserIDEQ.
func UserID(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldUserID, v))
}

// InvitedBy applies equality check predicate on the "invited_by" field. It's identical to InvitedByEQ.
func InvitedBy(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldInvitedBy, v))
}

// Admin applies equality check predicate on the "admin" field. It's identical to AdminEQ.
func Admin(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldAdmin, v))
}

// Creator applies equality check predicate on the "creator" field. It's identical to CreatorEQ.
func Creator(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldCreator, v))
}

// Confirmed applies equality check predicate on the "confirmed" field. It's identical to ConfirmedEQ.
func Confirmed(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldConfirmed, v))
}

// CreatedAt applies equality check predicate on the "created_at" field. It's identical to CreatedAtEQ.
func CreatedAt(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldCreatedAt, v))
}

// EventIDEQ applies the EQ predicate on the "event_id" field.
func EventIDEQ(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldEventID, v))
}

// EventIDNEQ applies the NEQ predicate on the "event_id" field.
func EventIDNEQ(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldEventID, v))
}

// EventIDIn applies the In predicate on the "event_id" field.
func EventIDIn(vs ...int) predicate.EventUser {
	return predicate.EventUser(sql.FieldIn(FieldEventID, vs...))
}

// EventIDNotIn applies the NotIn predicate on the "event_id" field.
func EventIDNotIn(vs ...int) predicate.EventUser {
	return predicate.EventUser(sql.FieldNotIn(FieldEventID, vs...))
}

// UserIDEQ applies the EQ predicate on the "user_id" field.
func UserIDEQ(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldUserID, v))
}

// UserIDNEQ applies the NEQ predicate on the "user_id" field.
func UserIDNEQ(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldUserID, v))
}

// UserIDIn applies the In predicate on the "user_id" field.
func UserIDIn(vs ...int) predicate.EventUser {
	return predicate.EventUser(sql.FieldIn(FieldUserID, vs...))
}

// UserIDNotIn applies the NotIn predicate on the "user_id" field.
func UserIDNotIn(vs ...int) predicate.EventUser {
	return predicate.EventUser(sql.FieldNotIn(FieldUserID, vs...))
}

// InvitedByEQ applies the EQ predicate on the "invited_by" field.
func InvitedByEQ(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldInvitedBy, v))
}

// InvitedByNEQ applies the NEQ predicate on the "invited_by" field.
func InvitedByNEQ(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldInvitedBy, v))
}

// InvitedByIn applies the In predicate on the "invited_by" field.
func InvitedByIn(vs ...int) predicate.EventUser {
	return predicate.EventUser(sql.FieldIn(FieldInvitedBy, vs...))
}

// InvitedByNotIn applies the NotIn predicate on the "invited_by" field.
func InvitedByNotIn(vs ...int) predicate.EventUser {
	return predicate.EventUser(sql.FieldNotIn(FieldInvitedBy, vs...))
}

// InvitedByGT applies the GT predicate on the "invited_by" field.
func InvitedByGT(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldGT(FieldInvitedBy, v))
}

// InvitedByGTE applies the GTE predicate on the "invited_by" field.
func InvitedByGTE(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldGTE(FieldInvitedBy, v))
}

// InvitedByLT applies the LT predicate on the "invited_by" field.
func InvitedByLT(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldLT(FieldInvitedBy, v))
}

// InvitedByLTE applies the LTE predicate on the "invited_by" field.
func InvitedByLTE(v int) predicate.EventUser {
	return predicate.EventUser(sql.FieldLTE(FieldInvitedBy, v))
}

// AdminEQ applies the EQ predicate on the "admin" field.
func AdminEQ(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldAdmin, v))
}

// AdminNEQ applies the NEQ predicate on the "admin" field.
func AdminNEQ(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldAdmin, v))
}

// CreatorEQ applies the EQ predicate on the "creator" field.
func CreatorEQ(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldCreator, v))
}

// CreatorNEQ applies the NEQ predicate on the "creator" field.
func CreatorNEQ(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldCreator, v))
}

// ConfirmedEQ applies the EQ predicate on the "confirmed" field.
func ConfirmedEQ(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldConfirmed, v))
}

// ConfirmedNEQ applies the NEQ predicate on the "confirmed" field.
func ConfirmedNEQ(v bool) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldConfirmed, v))
}

// CreatedAtEQ applies the EQ predicate on the "created_at" field.
func CreatedAtEQ(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldEQ(FieldCreatedAt, v))
}

// CreatedAtNEQ applies the NEQ predicate on the "created_at" field.
func CreatedAtNEQ(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldNEQ(FieldCreatedAt, v))
}

// CreatedAtIn applies the In predicate on the "created_at" field.
func CreatedAtIn(vs ...time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldIn(FieldCreatedAt, vs...))
}

// CreatedAtNotIn applies the NotIn predicate on the "created_at" field.
func CreatedAtNotIn(vs ...time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldNotIn(FieldCreatedAt, vs...))
}

// CreatedAtGT applies the GT predicate on the "created_at" field.
func CreatedAtGT(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldGT(FieldCreatedAt, v))
}

// CreatedAtGTE applies the GTE predicate on the "created_at" field.
func CreatedAtGTE(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldGTE(FieldCreatedAt, v))
}

// CreatedAtLT applies the LT predicate on the "created_at" field.
func CreatedAtLT(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldLT(FieldCreatedAt, v))
}

// CreatedAtLTE applies the LTE predicate on the "created_at" field.
func CreatedAtLTE(v time.Time) predicate.EventUser {
	return predicate.EventUser(sql.FieldLTE(FieldCreatedAt, v))
}

// HasEvent applies the HasEdge predicate on the "event" edge.
func HasEvent() predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, EventColumn),
			sqlgraph.Edge(sqlgraph.M2O, false, EventTable, EventColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasEventWith applies the HasEdge predicate on the "event" edge with a given conditions (other predicates).
func HasEventWith(preds ...predicate.Event) predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
		step := newEventStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// HasUser applies the HasEdge predicate on the "user" edge.
func HasUser() predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
		step := sqlgraph.NewStep(
			sqlgraph.From(Table, UserColumn),
			sqlgraph.Edge(sqlgraph.M2O, false, UserTable, UserColumn),
		)
		sqlgraph.HasNeighbors(s, step)
	})
}

// HasUserWith applies the HasEdge predicate on the "user" edge with a given conditions (other predicates).
func HasUserWith(preds ...predicate.User) predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
		step := newUserStep()
		sqlgraph.HasNeighborsWith(s, step, func(s *sql.Selector) {
			for _, p := range preds {
				p(s)
			}
		})
	})
}

// And groups predicates with the AND operator between them.
func And(predicates ...predicate.EventUser) predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
		s1 := s.Clone().SetP(nil)
		for _, p := range predicates {
			p(s1)
		}
		s.Where(s1.P())
	})
}

// Or groups predicates with the OR operator between them.
func Or(predicates ...predicate.EventUser) predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
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
func Not(p predicate.EventUser) predicate.EventUser {
	return predicate.EventUser(func(s *sql.Selector) {
		p(s.Not())
	})
}
