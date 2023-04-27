// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"happ/ent/device"
	"happ/ent/predicate"
	"happ/ent/user"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// DeviceUpdate is the builder for updating Device entities.
type DeviceUpdate struct {
	config
	hooks    []Hook
	mutation *DeviceMutation
}

// Where appends a list predicates to the DeviceUpdate builder.
func (du *DeviceUpdate) Where(ps ...predicate.Device) *DeviceUpdate {
	du.mutation.Where(ps...)
	return du
}

// SetUserID sets the "user_id" field.
func (du *DeviceUpdate) SetUserID(i int) *DeviceUpdate {
	du.mutation.ResetUserID()
	du.mutation.SetUserID(i)
	return du
}

// AddUserID adds i to the "user_id" field.
func (du *DeviceUpdate) AddUserID(i int) *DeviceUpdate {
	du.mutation.AddUserID(i)
	return du
}

// SetOwnerID sets the "owner" edge to the User entity by ID.
func (du *DeviceUpdate) SetOwnerID(id int) *DeviceUpdate {
	du.mutation.SetOwnerID(id)
	return du
}

// SetNillableOwnerID sets the "owner" edge to the User entity by ID if the given value is not nil.
func (du *DeviceUpdate) SetNillableOwnerID(id *int) *DeviceUpdate {
	if id != nil {
		du = du.SetOwnerID(*id)
	}
	return du
}

// SetOwner sets the "owner" edge to the User entity.
func (du *DeviceUpdate) SetOwner(u *User) *DeviceUpdate {
	return du.SetOwnerID(u.ID)
}

// Mutation returns the DeviceMutation object of the builder.
func (du *DeviceUpdate) Mutation() *DeviceMutation {
	return du.mutation
}

// ClearOwner clears the "owner" edge to the User entity.
func (du *DeviceUpdate) ClearOwner() *DeviceUpdate {
	du.mutation.ClearOwner()
	return du
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (du *DeviceUpdate) Save(ctx context.Context) (int, error) {
	return withHooks[int, DeviceMutation](ctx, du.sqlSave, du.mutation, du.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (du *DeviceUpdate) SaveX(ctx context.Context) int {
	affected, err := du.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (du *DeviceUpdate) Exec(ctx context.Context) error {
	_, err := du.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (du *DeviceUpdate) ExecX(ctx context.Context) {
	if err := du.Exec(ctx); err != nil {
		panic(err)
	}
}

func (du *DeviceUpdate) sqlSave(ctx context.Context) (n int, err error) {
	_spec := sqlgraph.NewUpdateSpec(device.Table, device.Columns, sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt))
	if ps := du.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := du.mutation.UserID(); ok {
		_spec.SetField(device.FieldUserID, field.TypeInt, value)
	}
	if value, ok := du.mutation.AddedUserID(); ok {
		_spec.AddField(device.FieldUserID, field.TypeInt, value)
	}
	if du.mutation.OwnerCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   device.OwnerTable,
			Columns: []string{device.OwnerColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := du.mutation.OwnerIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   device.OwnerTable,
			Columns: []string{device.OwnerColumn},
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
	if n, err = sqlgraph.UpdateNodes(ctx, du.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{device.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	du.mutation.done = true
	return n, nil
}

// DeviceUpdateOne is the builder for updating a single Device entity.
type DeviceUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *DeviceMutation
}

// SetUserID sets the "user_id" field.
func (duo *DeviceUpdateOne) SetUserID(i int) *DeviceUpdateOne {
	duo.mutation.ResetUserID()
	duo.mutation.SetUserID(i)
	return duo
}

// AddUserID adds i to the "user_id" field.
func (duo *DeviceUpdateOne) AddUserID(i int) *DeviceUpdateOne {
	duo.mutation.AddUserID(i)
	return duo
}

// SetOwnerID sets the "owner" edge to the User entity by ID.
func (duo *DeviceUpdateOne) SetOwnerID(id int) *DeviceUpdateOne {
	duo.mutation.SetOwnerID(id)
	return duo
}

// SetNillableOwnerID sets the "owner" edge to the User entity by ID if the given value is not nil.
func (duo *DeviceUpdateOne) SetNillableOwnerID(id *int) *DeviceUpdateOne {
	if id != nil {
		duo = duo.SetOwnerID(*id)
	}
	return duo
}

// SetOwner sets the "owner" edge to the User entity.
func (duo *DeviceUpdateOne) SetOwner(u *User) *DeviceUpdateOne {
	return duo.SetOwnerID(u.ID)
}

// Mutation returns the DeviceMutation object of the builder.
func (duo *DeviceUpdateOne) Mutation() *DeviceMutation {
	return duo.mutation
}

// ClearOwner clears the "owner" edge to the User entity.
func (duo *DeviceUpdateOne) ClearOwner() *DeviceUpdateOne {
	duo.mutation.ClearOwner()
	return duo
}

// Where appends a list predicates to the DeviceUpdate builder.
func (duo *DeviceUpdateOne) Where(ps ...predicate.Device) *DeviceUpdateOne {
	duo.mutation.Where(ps...)
	return duo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (duo *DeviceUpdateOne) Select(field string, fields ...string) *DeviceUpdateOne {
	duo.fields = append([]string{field}, fields...)
	return duo
}

// Save executes the query and returns the updated Device entity.
func (duo *DeviceUpdateOne) Save(ctx context.Context) (*Device, error) {
	return withHooks[*Device, DeviceMutation](ctx, duo.sqlSave, duo.mutation, duo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (duo *DeviceUpdateOne) SaveX(ctx context.Context) *Device {
	node, err := duo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (duo *DeviceUpdateOne) Exec(ctx context.Context) error {
	_, err := duo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (duo *DeviceUpdateOne) ExecX(ctx context.Context) {
	if err := duo.Exec(ctx); err != nil {
		panic(err)
	}
}

func (duo *DeviceUpdateOne) sqlSave(ctx context.Context) (_node *Device, err error) {
	_spec := sqlgraph.NewUpdateSpec(device.Table, device.Columns, sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt))
	id, ok := duo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "id", err: errors.New(`ent: missing "Device.id" for update`)}
	}
	_spec.Node.ID.Value = id
	if fields := duo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, device.FieldID)
		for _, f := range fields {
			if !device.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			if f != device.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, f)
			}
		}
	}
	if ps := duo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := duo.mutation.UserID(); ok {
		_spec.SetField(device.FieldUserID, field.TypeInt, value)
	}
	if value, ok := duo.mutation.AddedUserID(); ok {
		_spec.AddField(device.FieldUserID, field.TypeInt, value)
	}
	if duo.mutation.OwnerCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   device.OwnerTable,
			Columns: []string{device.OwnerColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := duo.mutation.OwnerIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2O,
			Inverse: true,
			Table:   device.OwnerTable,
			Columns: []string{device.OwnerColumn},
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
	_node = &Device{config: duo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, duo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{device.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	duo.mutation.done = true
	return _node, nil
}
