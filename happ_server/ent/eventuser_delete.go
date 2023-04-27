// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"happ/ent/eventuser"
	"happ/ent/predicate"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
)

// EventUserDelete is the builder for deleting a EventUser entity.
type EventUserDelete struct {
	config
	hooks    []Hook
	mutation *EventUserMutation
}

// Where appends a list predicates to the EventUserDelete builder.
func (eud *EventUserDelete) Where(ps ...predicate.EventUser) *EventUserDelete {
	eud.mutation.Where(ps...)
	return eud
}

// Exec executes the deletion query and returns how many vertices were deleted.
func (eud *EventUserDelete) Exec(ctx context.Context) (int, error) {
	return withHooks[int, EventUserMutation](ctx, eud.sqlExec, eud.mutation, eud.hooks)
}

// ExecX is like Exec, but panics if an error occurs.
func (eud *EventUserDelete) ExecX(ctx context.Context) int {
	n, err := eud.Exec(ctx)
	if err != nil {
		panic(err)
	}
	return n
}

func (eud *EventUserDelete) sqlExec(ctx context.Context) (int, error) {
	_spec := sqlgraph.NewDeleteSpec(eventuser.Table, nil)
	if ps := eud.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	affected, err := sqlgraph.DeleteNodes(ctx, eud.driver, _spec)
	if err != nil && sqlgraph.IsConstraintError(err) {
		err = &ConstraintError{msg: err.Error(), wrap: err}
	}
	eud.mutation.done = true
	return affected, err
}

// EventUserDeleteOne is the builder for deleting a single EventUser entity.
type EventUserDeleteOne struct {
	eud *EventUserDelete
}

// Where appends a list predicates to the EventUserDelete builder.
func (eudo *EventUserDeleteOne) Where(ps ...predicate.EventUser) *EventUserDeleteOne {
	eudo.eud.mutation.Where(ps...)
	return eudo
}

// Exec executes the deletion query.
func (eudo *EventUserDeleteOne) Exec(ctx context.Context) error {
	n, err := eudo.eud.Exec(ctx)
	switch {
	case err != nil:
		return err
	case n == 0:
		return &NotFoundError{eventuser.Label}
	default:
		return nil
	}
}

// ExecX is like Exec, but panics if an error occurs.
func (eudo *EventUserDeleteOne) ExecX(ctx context.Context) {
	if err := eudo.Exec(ctx); err != nil {
		panic(err)
	}
}