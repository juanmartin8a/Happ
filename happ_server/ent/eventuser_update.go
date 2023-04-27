// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"happ/ent/event"
	"happ/ent/eventuser"
	"happ/ent/predicate"
	"happ/ent/user"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// EventUserUpdate is the builder for updating EventUser entities.
type EventUserUpdate struct {
	config
	hooks    []Hook
	mutation *EventUserMutation
}

// Where appends a list predicates to the EventUserUpdate builder.
func (euu *EventUserUpdate) Where(ps ...predicate.EventUser) *EventUserUpdate {
	euu.mutation.Where(ps...)
	return euu
}

// SetEventID sets the "event_id" field.
func (euu *EventUserUpdate) SetEventID(i int) *EventUserUpdate {
	euu.mutation.SetEventID(i)
	return euu
}

// SetUserID sets the "user_id" field.
func (euu *EventUserUpdate) SetUserID(i int) *EventUserUpdate {
	euu.mutation.SetUserID(i)
	return euu
}

// SetInvitedBy sets the "invited_by" field.
func (euu *EventUserUpdate) SetInvitedBy(i int) *EventUserUpdate {
	euu.mutation.ResetInvitedBy()
	euu.mutation.SetInvitedBy(i)
	return euu
}

// AddInvitedBy adds i to the "invited_by" field.
func (euu *EventUserUpdate) AddInvitedBy(i int) *EventUserUpdate {
	euu.mutation.AddInvitedBy(i)
	return euu
}

// SetAdmin sets the "admin" field.
func (euu *EventUserUpdate) SetAdmin(b bool) *EventUserUpdate {
	euu.mutation.SetAdmin(b)
	return euu
}

// SetNillableAdmin sets the "admin" field if the given value is not nil.
func (euu *EventUserUpdate) SetNillableAdmin(b *bool) *EventUserUpdate {
	if b != nil {
		euu.SetAdmin(*b)
	}
	return euu
}

// SetCreator sets the "creator" field.
func (euu *EventUserUpdate) SetCreator(b bool) *EventUserUpdate {
	euu.mutation.SetCreator(b)
	return euu
}

// SetNillableCreator sets the "creator" field if the given value is not nil.
func (euu *EventUserUpdate) SetNillableCreator(b *bool) *EventUserUpdate {
	if b != nil {
		euu.SetCreator(*b)
	}
	return euu
}

// SetConfirmed sets the "confirmed" field.
func (euu *EventUserUpdate) SetConfirmed(b bool) *EventUserUpdate {
	euu.mutation.SetConfirmed(b)
	return euu
}

// SetNillableConfirmed sets the "confirmed" field if the given value is not nil.
func (euu *EventUserUpdate) SetNillableConfirmed(b *bool) *EventUserUpdate {
	if b != nil {
		euu.SetConfirmed(*b)
	}
	return euu
}

// SetEvent sets the "event" edge to the Event entity.
func (euu *EventUserUpdate) SetEvent(e *Event) *EventUserUpdate {
	return euu.SetEventID(e.ID)
}

// SetUser sets the "user" edge to the User entity.
func (euu *EventUserUpdate) SetUser(u *User) *EventUserUpdate {
	return euu.SetUserID(u.ID)
}

// Mutation returns the EventUserMutation object of the builder.
func (euu *EventUserUpdate) Mutation() *EventUserMutation {
	return euu.mutation
}

// ClearEvent clears the "event" edge to the Event entity.
func (euu *EventUserUpdate) ClearEvent() *EventUserUpdate {
	euu.mutation.ClearEvent()
	return euu
}

// ClearUser clears the "user" edge to the User entity.
func (euu *EventUserUpdate) ClearUser() *EventUserUpdate {
	euu.mutation.ClearUser()
	return euu
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (euu *EventUserUpdate) Save(ctx context.Context) (int, error) {
	return withHooks[int, EventUserMutation](ctx, euu.sqlSave, euu.mutation, euu.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (euu *EventUserUpdate) SaveX(ctx context.Context) int {
	affected, err := euu.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (euu *EventUserUpdate) Exec(ctx context.Context) error {
	_, err := euu.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (euu *EventUserUpdate) ExecX(ctx context.Context) {
	if err := euu.Exec(ctx); err != nil {
		panic(err)
	}
}

// check runs all checks and user-defined validators on the builder.
func (euu *EventUserUpdate) check() error {
	if _, ok := euu.mutation.EventID(); euu.mutation.EventCleared() && !ok {
		return errors.New(`ent: clearing a required unique edge "EventUser.event"`)
	}
	if _, ok := euu.mutation.UserID(); euu.mutation.UserCleared() && !ok {
		return errors.New(`ent: clearing a required unique edge "EventUser.user"`)
	}
	return nil
}

func (euu *EventUserUpdate) sqlSave(ctx context.Context) (n int, err error) {
	if err := euu.check(); err != nil {
		return n, err
	}
	_spec := sqlgraph.NewUpdateSpec(eventuser.Table, eventuser.Columns, sqlgraph.NewFieldSpec(eventuser.FieldEventID, field.TypeInt), sqlgraph.NewFieldSpec(eventuser.FieldUserID, field.TypeInt))
	if ps := euu.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := euu.mutation.InvitedBy(); ok {
		_spec.SetField(eventuser.FieldInvitedBy, field.TypeInt, value)
	}
	if value, ok := euu.mutation.AddedInvitedBy(); ok {
		_spec.AddField(eventuser.FieldInvitedBy, field.TypeInt, value)
	}
	if value, ok := euu.mutation.Admin(); ok {
		_spec.SetField(eventuser.FieldAdmin, field.TypeBool, value)
	}
	if value, ok := euu.mutation.Creator(); ok {
		_spec.SetField(eventuser.FieldCreator, field.TypeBool, value)
	}
	if value, ok := euu.mutation.Confirmed(); ok {
		_spec.SetField(eventuser.FieldConfirmed, field.TypeBool, value)
	}
	if euu.mutation.EventCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.EventTable,
			Columns: []string{eventuser.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euu.mutation.EventIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.EventTable,
			Columns: []string{eventuser.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if euu.mutation.UserCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.UserTable,
			Columns: []string{eventuser.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euu.mutation.UserIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.UserTable,
			Columns: []string{eventuser.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if n, err = sqlgraph.UpdateNodes(ctx, euu.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{eventuser.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	euu.mutation.done = true
	return n, nil
}

// EventUserUpdateOne is the builder for updating a single EventUser entity.
type EventUserUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *EventUserMutation
}

// SetEventID sets the "event_id" field.
func (euuo *EventUserUpdateOne) SetEventID(i int) *EventUserUpdateOne {
	euuo.mutation.SetEventID(i)
	return euuo
}

// SetUserID sets the "user_id" field.
func (euuo *EventUserUpdateOne) SetUserID(i int) *EventUserUpdateOne {
	euuo.mutation.SetUserID(i)
	return euuo
}

// SetInvitedBy sets the "invited_by" field.
func (euuo *EventUserUpdateOne) SetInvitedBy(i int) *EventUserUpdateOne {
	euuo.mutation.ResetInvitedBy()
	euuo.mutation.SetInvitedBy(i)
	return euuo
}

// AddInvitedBy adds i to the "invited_by" field.
func (euuo *EventUserUpdateOne) AddInvitedBy(i int) *EventUserUpdateOne {
	euuo.mutation.AddInvitedBy(i)
	return euuo
}

// SetAdmin sets the "admin" field.
func (euuo *EventUserUpdateOne) SetAdmin(b bool) *EventUserUpdateOne {
	euuo.mutation.SetAdmin(b)
	return euuo
}

// SetNillableAdmin sets the "admin" field if the given value is not nil.
func (euuo *EventUserUpdateOne) SetNillableAdmin(b *bool) *EventUserUpdateOne {
	if b != nil {
		euuo.SetAdmin(*b)
	}
	return euuo
}

// SetCreator sets the "creator" field.
func (euuo *EventUserUpdateOne) SetCreator(b bool) *EventUserUpdateOne {
	euuo.mutation.SetCreator(b)
	return euuo
}

// SetNillableCreator sets the "creator" field if the given value is not nil.
func (euuo *EventUserUpdateOne) SetNillableCreator(b *bool) *EventUserUpdateOne {
	if b != nil {
		euuo.SetCreator(*b)
	}
	return euuo
}

// SetConfirmed sets the "confirmed" field.
func (euuo *EventUserUpdateOne) SetConfirmed(b bool) *EventUserUpdateOne {
	euuo.mutation.SetConfirmed(b)
	return euuo
}

// SetNillableConfirmed sets the "confirmed" field if the given value is not nil.
func (euuo *EventUserUpdateOne) SetNillableConfirmed(b *bool) *EventUserUpdateOne {
	if b != nil {
		euuo.SetConfirmed(*b)
	}
	return euuo
}

// SetEvent sets the "event" edge to the Event entity.
func (euuo *EventUserUpdateOne) SetEvent(e *Event) *EventUserUpdateOne {
	return euuo.SetEventID(e.ID)
}

// SetUser sets the "user" edge to the User entity.
func (euuo *EventUserUpdateOne) SetUser(u *User) *EventUserUpdateOne {
	return euuo.SetUserID(u.ID)
}

// Mutation returns the EventUserMutation object of the builder.
func (euuo *EventUserUpdateOne) Mutation() *EventUserMutation {
	return euuo.mutation
}

// ClearEvent clears the "event" edge to the Event entity.
func (euuo *EventUserUpdateOne) ClearEvent() *EventUserUpdateOne {
	euuo.mutation.ClearEvent()
	return euuo
}

// ClearUser clears the "user" edge to the User entity.
func (euuo *EventUserUpdateOne) ClearUser() *EventUserUpdateOne {
	euuo.mutation.ClearUser()
	return euuo
}

// Where appends a list predicates to the EventUserUpdate builder.
func (euuo *EventUserUpdateOne) Where(ps ...predicate.EventUser) *EventUserUpdateOne {
	euuo.mutation.Where(ps...)
	return euuo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (euuo *EventUserUpdateOne) Select(field string, fields ...string) *EventUserUpdateOne {
	euuo.fields = append([]string{field}, fields...)
	return euuo
}

// Save executes the query and returns the updated EventUser entity.
func (euuo *EventUserUpdateOne) Save(ctx context.Context) (*EventUser, error) {
	return withHooks[*EventUser, EventUserMutation](ctx, euuo.sqlSave, euuo.mutation, euuo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (euuo *EventUserUpdateOne) SaveX(ctx context.Context) *EventUser {
	node, err := euuo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (euuo *EventUserUpdateOne) Exec(ctx context.Context) error {
	_, err := euuo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (euuo *EventUserUpdateOne) ExecX(ctx context.Context) {
	if err := euuo.Exec(ctx); err != nil {
		panic(err)
	}
}

// check runs all checks and user-defined validators on the builder.
func (euuo *EventUserUpdateOne) check() error {
	if _, ok := euuo.mutation.EventID(); euuo.mutation.EventCleared() && !ok {
		return errors.New(`ent: clearing a required unique edge "EventUser.event"`)
	}
	if _, ok := euuo.mutation.UserID(); euuo.mutation.UserCleared() && !ok {
		return errors.New(`ent: clearing a required unique edge "EventUser.user"`)
	}
	return nil
}

func (euuo *EventUserUpdateOne) sqlSave(ctx context.Context) (_node *EventUser, err error) {
	if err := euuo.check(); err != nil {
		return _node, err
	}
	_spec := sqlgraph.NewUpdateSpec(eventuser.Table, eventuser.Columns, sqlgraph.NewFieldSpec(eventuser.FieldEventID, field.TypeInt), sqlgraph.NewFieldSpec(eventuser.FieldUserID, field.TypeInt))
	if id, ok := euuo.mutation.EventID(); !ok {
		return nil, &ValidationError{Name: "event_id", err: errors.New(`ent: missing "EventUser.event_id" for update`)}
	} else {
		_spec.Node.CompositeID[0].Value = id
	}
	if id, ok := euuo.mutation.UserID(); !ok {
		return nil, &ValidationError{Name: "user_id", err: errors.New(`ent: missing "EventUser.user_id" for update`)}
	} else {
		_spec.Node.CompositeID[1].Value = id
	}
	if fields := euuo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, len(fields))
		for i, f := range fields {
			if !eventuser.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			_spec.Node.Columns[i] = f
		}
	}
	if ps := euuo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := euuo.mutation.InvitedBy(); ok {
		_spec.SetField(eventuser.FieldInvitedBy, field.TypeInt, value)
	}
	if value, ok := euuo.mutation.AddedInvitedBy(); ok {
		_spec.AddField(eventuser.FieldInvitedBy, field.TypeInt, value)
	}
	if value, ok := euuo.mutation.Admin(); ok {
		_spec.SetField(eventuser.FieldAdmin, field.TypeBool, value)
	}
	if value, ok := euuo.mutation.Creator(); ok {
		_spec.SetField(eventuser.FieldCreator, field.TypeBool, value)
	}
	if value, ok := euuo.mutation.Confirmed(); ok {
		_spec.SetField(eventuser.FieldConfirmed, field.TypeBool, value)
	}
	if euuo.mutation.EventCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.EventTable,
			Columns: []string{eventuser.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euuo.mutation.EventIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.EventTable,
			Columns: []string{eventuser.EventColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if euuo.mutation.UserCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.UserTable,
			Columns: []string{eventuser.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euuo.mutation.UserIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: false,
			Table:   eventuser.UserTable,
			Columns: []string{eventuser.UserColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	_node = &EventUser{config: euuo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, euuo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{eventuser.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	euuo.mutation.done = true
	return _node, nil
}
