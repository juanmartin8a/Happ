// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"happ/ent/device"
	"happ/ent/event"
	"happ/ent/eventremindernotification"
	"happ/ent/predicate"
	"happ/ent/user"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
)

// UserUpdate is the builder for updating User entities.
type UserUpdate struct {
	config
	hooks    []Hook
	mutation *UserMutation
}

// Where appends a list predicates to the UserUpdate builder.
func (uu *UserUpdate) Where(ps ...predicate.User) *UserUpdate {
	uu.mutation.Where(ps...)
	return uu
}

// SetFUID sets the "FUID" field.
func (uu *UserUpdate) SetFUID(s string) *UserUpdate {
	uu.mutation.SetFUID(s)
	return uu
}

// SetName sets the "name" field.
func (uu *UserUpdate) SetName(s string) *UserUpdate {
	uu.mutation.SetName(s)
	return uu
}

// SetUsername sets the "username" field.
func (uu *UserUpdate) SetUsername(s string) *UserUpdate {
	uu.mutation.SetUsername(s)
	return uu
}

// SetEmail sets the "email" field.
func (uu *UserUpdate) SetEmail(s string) *UserUpdate {
	uu.mutation.SetEmail(s)
	return uu
}

// SetProfilePic sets the "profile_pic" field.
func (uu *UserUpdate) SetProfilePic(s string) *UserUpdate {
	uu.mutation.SetProfilePic(s)
	return uu
}

// AddEventIDs adds the "events" edge to the Event entity by IDs.
func (uu *UserUpdate) AddEventIDs(ids ...int) *UserUpdate {
	uu.mutation.AddEventIDs(ids...)
	return uu
}

// AddEvents adds the "events" edges to the Event entity.
func (uu *UserUpdate) AddEvents(e ...*Event) *UserUpdate {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uu.AddEventIDs(ids...)
}

// AddFollowerIDs adds the "followers" edge to the User entity by IDs.
func (uu *UserUpdate) AddFollowerIDs(ids ...int) *UserUpdate {
	uu.mutation.AddFollowerIDs(ids...)
	return uu
}

// AddFollowers adds the "followers" edges to the User entity.
func (uu *UserUpdate) AddFollowers(u ...*User) *UserUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uu.AddFollowerIDs(ids...)
}

// AddFollowingIDs adds the "following" edge to the User entity by IDs.
func (uu *UserUpdate) AddFollowingIDs(ids ...int) *UserUpdate {
	uu.mutation.AddFollowingIDs(ids...)
	return uu
}

// AddFollowing adds the "following" edges to the User entity.
func (uu *UserUpdate) AddFollowing(u ...*User) *UserUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uu.AddFollowingIDs(ids...)
}

// AddDeviceIDs adds the "devices" edge to the Device entity by IDs.
func (uu *UserUpdate) AddDeviceIDs(ids ...int) *UserUpdate {
	uu.mutation.AddDeviceIDs(ids...)
	return uu
}

// AddDevices adds the "devices" edges to the Device entity.
func (uu *UserUpdate) AddDevices(d ...*Device) *UserUpdate {
	ids := make([]int, len(d))
	for i := range d {
		ids[i] = d[i].ID
	}
	return uu.AddDeviceIDs(ids...)
}

// AddEventReminderNotificationIDs adds the "event_reminder_notifications" edge to the EventReminderNotification entity by IDs.
func (uu *UserUpdate) AddEventReminderNotificationIDs(ids ...int) *UserUpdate {
	uu.mutation.AddEventReminderNotificationIDs(ids...)
	return uu
}

// AddEventReminderNotifications adds the "event_reminder_notifications" edges to the EventReminderNotification entity.
func (uu *UserUpdate) AddEventReminderNotifications(e ...*EventReminderNotification) *UserUpdate {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uu.AddEventReminderNotificationIDs(ids...)
}

// Mutation returns the UserMutation object of the builder.
func (uu *UserUpdate) Mutation() *UserMutation {
	return uu.mutation
}

// ClearEvents clears all "events" edges to the Event entity.
func (uu *UserUpdate) ClearEvents() *UserUpdate {
	uu.mutation.ClearEvents()
	return uu
}

// RemoveEventIDs removes the "events" edge to Event entities by IDs.
func (uu *UserUpdate) RemoveEventIDs(ids ...int) *UserUpdate {
	uu.mutation.RemoveEventIDs(ids...)
	return uu
}

// RemoveEvents removes "events" edges to Event entities.
func (uu *UserUpdate) RemoveEvents(e ...*Event) *UserUpdate {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uu.RemoveEventIDs(ids...)
}

// ClearFollowers clears all "followers" edges to the User entity.
func (uu *UserUpdate) ClearFollowers() *UserUpdate {
	uu.mutation.ClearFollowers()
	return uu
}

// RemoveFollowerIDs removes the "followers" edge to User entities by IDs.
func (uu *UserUpdate) RemoveFollowerIDs(ids ...int) *UserUpdate {
	uu.mutation.RemoveFollowerIDs(ids...)
	return uu
}

// RemoveFollowers removes "followers" edges to User entities.
func (uu *UserUpdate) RemoveFollowers(u ...*User) *UserUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uu.RemoveFollowerIDs(ids...)
}

// ClearFollowing clears all "following" edges to the User entity.
func (uu *UserUpdate) ClearFollowing() *UserUpdate {
	uu.mutation.ClearFollowing()
	return uu
}

// RemoveFollowingIDs removes the "following" edge to User entities by IDs.
func (uu *UserUpdate) RemoveFollowingIDs(ids ...int) *UserUpdate {
	uu.mutation.RemoveFollowingIDs(ids...)
	return uu
}

// RemoveFollowing removes "following" edges to User entities.
func (uu *UserUpdate) RemoveFollowing(u ...*User) *UserUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uu.RemoveFollowingIDs(ids...)
}

// ClearDevices clears all "devices" edges to the Device entity.
func (uu *UserUpdate) ClearDevices() *UserUpdate {
	uu.mutation.ClearDevices()
	return uu
}

// RemoveDeviceIDs removes the "devices" edge to Device entities by IDs.
func (uu *UserUpdate) RemoveDeviceIDs(ids ...int) *UserUpdate {
	uu.mutation.RemoveDeviceIDs(ids...)
	return uu
}

// RemoveDevices removes "devices" edges to Device entities.
func (uu *UserUpdate) RemoveDevices(d ...*Device) *UserUpdate {
	ids := make([]int, len(d))
	for i := range d {
		ids[i] = d[i].ID
	}
	return uu.RemoveDeviceIDs(ids...)
}

// ClearEventReminderNotifications clears all "event_reminder_notifications" edges to the EventReminderNotification entity.
func (uu *UserUpdate) ClearEventReminderNotifications() *UserUpdate {
	uu.mutation.ClearEventReminderNotifications()
	return uu
}

// RemoveEventReminderNotificationIDs removes the "event_reminder_notifications" edge to EventReminderNotification entities by IDs.
func (uu *UserUpdate) RemoveEventReminderNotificationIDs(ids ...int) *UserUpdate {
	uu.mutation.RemoveEventReminderNotificationIDs(ids...)
	return uu
}

// RemoveEventReminderNotifications removes "event_reminder_notifications" edges to EventReminderNotification entities.
func (uu *UserUpdate) RemoveEventReminderNotifications(e ...*EventReminderNotification) *UserUpdate {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uu.RemoveEventReminderNotificationIDs(ids...)
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (uu *UserUpdate) Save(ctx context.Context) (int, error) {
	return withHooks(ctx, uu.sqlSave, uu.mutation, uu.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (uu *UserUpdate) SaveX(ctx context.Context) int {
	affected, err := uu.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (uu *UserUpdate) Exec(ctx context.Context) error {
	_, err := uu.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (uu *UserUpdate) ExecX(ctx context.Context) {
	if err := uu.Exec(ctx); err != nil {
		panic(err)
	}
}

// check runs all checks and user-defined validators on the builder.
func (uu *UserUpdate) check() error {
	if v, ok := uu.mutation.FUID(); ok {
		if err := user.FUIDValidator(v); err != nil {
			return &ValidationError{Name: "FUID", err: fmt.Errorf(`ent: validator failed for field "User.FUID": %w`, err)}
		}
	}
	if v, ok := uu.mutation.Name(); ok {
		if err := user.NameValidator(v); err != nil {
			return &ValidationError{Name: "name", err: fmt.Errorf(`ent: validator failed for field "User.name": %w`, err)}
		}
	}
	if v, ok := uu.mutation.Username(); ok {
		if err := user.UsernameValidator(v); err != nil {
			return &ValidationError{Name: "username", err: fmt.Errorf(`ent: validator failed for field "User.username": %w`, err)}
		}
	}
	if v, ok := uu.mutation.Email(); ok {
		if err := user.EmailValidator(v); err != nil {
			return &ValidationError{Name: "email", err: fmt.Errorf(`ent: validator failed for field "User.email": %w`, err)}
		}
	}
	if v, ok := uu.mutation.ProfilePic(); ok {
		if err := user.ProfilePicValidator(v); err != nil {
			return &ValidationError{Name: "profile_pic", err: fmt.Errorf(`ent: validator failed for field "User.profile_pic": %w`, err)}
		}
	}
	return nil
}

func (uu *UserUpdate) sqlSave(ctx context.Context) (n int, err error) {
	if err := uu.check(); err != nil {
		return n, err
	}
	_spec := sqlgraph.NewUpdateSpec(user.Table, user.Columns, sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt))
	if ps := uu.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := uu.mutation.FUID(); ok {
		_spec.SetField(user.FieldFUID, field.TypeString, value)
	}
	if value, ok := uu.mutation.Name(); ok {
		_spec.SetField(user.FieldName, field.TypeString, value)
	}
	if value, ok := uu.mutation.Username(); ok {
		_spec.SetField(user.FieldUsername, field.TypeString, value)
	}
	if value, ok := uu.mutation.Email(); ok {
		_spec.SetField(user.FieldEmail, field.TypeString, value)
	}
	if value, ok := uu.mutation.ProfilePic(); ok {
		_spec.SetField(user.FieldProfilePic, field.TypeString, value)
	}
	if uu.mutation.EventsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.EventsTable,
			Columns: user.EventsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		createE := &EventUserCreate{config: uu.config, mutation: newEventUserMutation(uu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.RemovedEventsIDs(); len(nodes) > 0 && !uu.mutation.EventsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.EventsTable,
			Columns: user.EventsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: uu.config, mutation: newEventUserMutation(uu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.EventsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.EventsTable,
			Columns: user.EventsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: uu.config, mutation: newEventUserMutation(uu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if uu.mutation.FollowersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.FollowersTable,
			Columns: user.FollowersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		createE := &FollowCreate{config: uu.config, mutation: newFollowMutation(uu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.RemovedFollowersIDs(); len(nodes) > 0 && !uu.mutation.FollowersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.FollowersTable,
			Columns: user.FollowersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &FollowCreate{config: uu.config, mutation: newFollowMutation(uu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.FollowersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.FollowersTable,
			Columns: user.FollowersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &FollowCreate{config: uu.config, mutation: newFollowMutation(uu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if uu.mutation.FollowingCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   user.FollowingTable,
			Columns: user.FollowingPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.RemovedFollowingIDs(); len(nodes) > 0 && !uu.mutation.FollowingCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   user.FollowingTable,
			Columns: user.FollowingPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.FollowingIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   user.FollowingTable,
			Columns: user.FollowingPrimaryKey,
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
	if uu.mutation.DevicesCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.DevicesTable,
			Columns: []string{user.DevicesColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.RemovedDevicesIDs(); len(nodes) > 0 && !uu.mutation.DevicesCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.DevicesTable,
			Columns: []string{user.DevicesColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.DevicesIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.DevicesTable,
			Columns: []string{user.DevicesColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if uu.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.EventReminderNotificationsTable,
			Columns: []string{user.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.RemovedEventReminderNotificationsIDs(); len(nodes) > 0 && !uu.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.EventReminderNotificationsTable,
			Columns: []string{user.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uu.mutation.EventReminderNotificationsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.EventReminderNotificationsTable,
			Columns: []string{user.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if n, err = sqlgraph.UpdateNodes(ctx, uu.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{user.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	uu.mutation.done = true
	return n, nil
}

// UserUpdateOne is the builder for updating a single User entity.
type UserUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *UserMutation
}

// SetFUID sets the "FUID" field.
func (uuo *UserUpdateOne) SetFUID(s string) *UserUpdateOne {
	uuo.mutation.SetFUID(s)
	return uuo
}

// SetName sets the "name" field.
func (uuo *UserUpdateOne) SetName(s string) *UserUpdateOne {
	uuo.mutation.SetName(s)
	return uuo
}

// SetUsername sets the "username" field.
func (uuo *UserUpdateOne) SetUsername(s string) *UserUpdateOne {
	uuo.mutation.SetUsername(s)
	return uuo
}

// SetEmail sets the "email" field.
func (uuo *UserUpdateOne) SetEmail(s string) *UserUpdateOne {
	uuo.mutation.SetEmail(s)
	return uuo
}

// SetProfilePic sets the "profile_pic" field.
func (uuo *UserUpdateOne) SetProfilePic(s string) *UserUpdateOne {
	uuo.mutation.SetProfilePic(s)
	return uuo
}

// AddEventIDs adds the "events" edge to the Event entity by IDs.
func (uuo *UserUpdateOne) AddEventIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.AddEventIDs(ids...)
	return uuo
}

// AddEvents adds the "events" edges to the Event entity.
func (uuo *UserUpdateOne) AddEvents(e ...*Event) *UserUpdateOne {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uuo.AddEventIDs(ids...)
}

// AddFollowerIDs adds the "followers" edge to the User entity by IDs.
func (uuo *UserUpdateOne) AddFollowerIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.AddFollowerIDs(ids...)
	return uuo
}

// AddFollowers adds the "followers" edges to the User entity.
func (uuo *UserUpdateOne) AddFollowers(u ...*User) *UserUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uuo.AddFollowerIDs(ids...)
}

// AddFollowingIDs adds the "following" edge to the User entity by IDs.
func (uuo *UserUpdateOne) AddFollowingIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.AddFollowingIDs(ids...)
	return uuo
}

// AddFollowing adds the "following" edges to the User entity.
func (uuo *UserUpdateOne) AddFollowing(u ...*User) *UserUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uuo.AddFollowingIDs(ids...)
}

// AddDeviceIDs adds the "devices" edge to the Device entity by IDs.
func (uuo *UserUpdateOne) AddDeviceIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.AddDeviceIDs(ids...)
	return uuo
}

// AddDevices adds the "devices" edges to the Device entity.
func (uuo *UserUpdateOne) AddDevices(d ...*Device) *UserUpdateOne {
	ids := make([]int, len(d))
	for i := range d {
		ids[i] = d[i].ID
	}
	return uuo.AddDeviceIDs(ids...)
}

// AddEventReminderNotificationIDs adds the "event_reminder_notifications" edge to the EventReminderNotification entity by IDs.
func (uuo *UserUpdateOne) AddEventReminderNotificationIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.AddEventReminderNotificationIDs(ids...)
	return uuo
}

// AddEventReminderNotifications adds the "event_reminder_notifications" edges to the EventReminderNotification entity.
func (uuo *UserUpdateOne) AddEventReminderNotifications(e ...*EventReminderNotification) *UserUpdateOne {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uuo.AddEventReminderNotificationIDs(ids...)
}

// Mutation returns the UserMutation object of the builder.
func (uuo *UserUpdateOne) Mutation() *UserMutation {
	return uuo.mutation
}

// ClearEvents clears all "events" edges to the Event entity.
func (uuo *UserUpdateOne) ClearEvents() *UserUpdateOne {
	uuo.mutation.ClearEvents()
	return uuo
}

// RemoveEventIDs removes the "events" edge to Event entities by IDs.
func (uuo *UserUpdateOne) RemoveEventIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.RemoveEventIDs(ids...)
	return uuo
}

// RemoveEvents removes "events" edges to Event entities.
func (uuo *UserUpdateOne) RemoveEvents(e ...*Event) *UserUpdateOne {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uuo.RemoveEventIDs(ids...)
}

// ClearFollowers clears all "followers" edges to the User entity.
func (uuo *UserUpdateOne) ClearFollowers() *UserUpdateOne {
	uuo.mutation.ClearFollowers()
	return uuo
}

// RemoveFollowerIDs removes the "followers" edge to User entities by IDs.
func (uuo *UserUpdateOne) RemoveFollowerIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.RemoveFollowerIDs(ids...)
	return uuo
}

// RemoveFollowers removes "followers" edges to User entities.
func (uuo *UserUpdateOne) RemoveFollowers(u ...*User) *UserUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uuo.RemoveFollowerIDs(ids...)
}

// ClearFollowing clears all "following" edges to the User entity.
func (uuo *UserUpdateOne) ClearFollowing() *UserUpdateOne {
	uuo.mutation.ClearFollowing()
	return uuo
}

// RemoveFollowingIDs removes the "following" edge to User entities by IDs.
func (uuo *UserUpdateOne) RemoveFollowingIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.RemoveFollowingIDs(ids...)
	return uuo
}

// RemoveFollowing removes "following" edges to User entities.
func (uuo *UserUpdateOne) RemoveFollowing(u ...*User) *UserUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return uuo.RemoveFollowingIDs(ids...)
}

// ClearDevices clears all "devices" edges to the Device entity.
func (uuo *UserUpdateOne) ClearDevices() *UserUpdateOne {
	uuo.mutation.ClearDevices()
	return uuo
}

// RemoveDeviceIDs removes the "devices" edge to Device entities by IDs.
func (uuo *UserUpdateOne) RemoveDeviceIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.RemoveDeviceIDs(ids...)
	return uuo
}

// RemoveDevices removes "devices" edges to Device entities.
func (uuo *UserUpdateOne) RemoveDevices(d ...*Device) *UserUpdateOne {
	ids := make([]int, len(d))
	for i := range d {
		ids[i] = d[i].ID
	}
	return uuo.RemoveDeviceIDs(ids...)
}

// ClearEventReminderNotifications clears all "event_reminder_notifications" edges to the EventReminderNotification entity.
func (uuo *UserUpdateOne) ClearEventReminderNotifications() *UserUpdateOne {
	uuo.mutation.ClearEventReminderNotifications()
	return uuo
}

// RemoveEventReminderNotificationIDs removes the "event_reminder_notifications" edge to EventReminderNotification entities by IDs.
func (uuo *UserUpdateOne) RemoveEventReminderNotificationIDs(ids ...int) *UserUpdateOne {
	uuo.mutation.RemoveEventReminderNotificationIDs(ids...)
	return uuo
}

// RemoveEventReminderNotifications removes "event_reminder_notifications" edges to EventReminderNotification entities.
func (uuo *UserUpdateOne) RemoveEventReminderNotifications(e ...*EventReminderNotification) *UserUpdateOne {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return uuo.RemoveEventReminderNotificationIDs(ids...)
}

// Where appends a list predicates to the UserUpdate builder.
func (uuo *UserUpdateOne) Where(ps ...predicate.User) *UserUpdateOne {
	uuo.mutation.Where(ps...)
	return uuo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (uuo *UserUpdateOne) Select(field string, fields ...string) *UserUpdateOne {
	uuo.fields = append([]string{field}, fields...)
	return uuo
}

// Save executes the query and returns the updated User entity.
func (uuo *UserUpdateOne) Save(ctx context.Context) (*User, error) {
	return withHooks(ctx, uuo.sqlSave, uuo.mutation, uuo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (uuo *UserUpdateOne) SaveX(ctx context.Context) *User {
	node, err := uuo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (uuo *UserUpdateOne) Exec(ctx context.Context) error {
	_, err := uuo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (uuo *UserUpdateOne) ExecX(ctx context.Context) {
	if err := uuo.Exec(ctx); err != nil {
		panic(err)
	}
}

// check runs all checks and user-defined validators on the builder.
func (uuo *UserUpdateOne) check() error {
	if v, ok := uuo.mutation.FUID(); ok {
		if err := user.FUIDValidator(v); err != nil {
			return &ValidationError{Name: "FUID", err: fmt.Errorf(`ent: validator failed for field "User.FUID": %w`, err)}
		}
	}
	if v, ok := uuo.mutation.Name(); ok {
		if err := user.NameValidator(v); err != nil {
			return &ValidationError{Name: "name", err: fmt.Errorf(`ent: validator failed for field "User.name": %w`, err)}
		}
	}
	if v, ok := uuo.mutation.Username(); ok {
		if err := user.UsernameValidator(v); err != nil {
			return &ValidationError{Name: "username", err: fmt.Errorf(`ent: validator failed for field "User.username": %w`, err)}
		}
	}
	if v, ok := uuo.mutation.Email(); ok {
		if err := user.EmailValidator(v); err != nil {
			return &ValidationError{Name: "email", err: fmt.Errorf(`ent: validator failed for field "User.email": %w`, err)}
		}
	}
	if v, ok := uuo.mutation.ProfilePic(); ok {
		if err := user.ProfilePicValidator(v); err != nil {
			return &ValidationError{Name: "profile_pic", err: fmt.Errorf(`ent: validator failed for field "User.profile_pic": %w`, err)}
		}
	}
	return nil
}

func (uuo *UserUpdateOne) sqlSave(ctx context.Context) (_node *User, err error) {
	if err := uuo.check(); err != nil {
		return _node, err
	}
	_spec := sqlgraph.NewUpdateSpec(user.Table, user.Columns, sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt))
	id, ok := uuo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "id", err: errors.New(`ent: missing "User.id" for update`)}
	}
	_spec.Node.ID.Value = id
	if fields := uuo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, user.FieldID)
		for _, f := range fields {
			if !user.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			if f != user.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, f)
			}
		}
	}
	if ps := uuo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := uuo.mutation.FUID(); ok {
		_spec.SetField(user.FieldFUID, field.TypeString, value)
	}
	if value, ok := uuo.mutation.Name(); ok {
		_spec.SetField(user.FieldName, field.TypeString, value)
	}
	if value, ok := uuo.mutation.Username(); ok {
		_spec.SetField(user.FieldUsername, field.TypeString, value)
	}
	if value, ok := uuo.mutation.Email(); ok {
		_spec.SetField(user.FieldEmail, field.TypeString, value)
	}
	if value, ok := uuo.mutation.ProfilePic(); ok {
		_spec.SetField(user.FieldProfilePic, field.TypeString, value)
	}
	if uuo.mutation.EventsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.EventsTable,
			Columns: user.EventsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		createE := &EventUserCreate{config: uuo.config, mutation: newEventUserMutation(uuo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.RemovedEventsIDs(); len(nodes) > 0 && !uuo.mutation.EventsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.EventsTable,
			Columns: user.EventsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: uuo.config, mutation: newEventUserMutation(uuo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.EventsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.EventsTable,
			Columns: user.EventsPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: uuo.config, mutation: newEventUserMutation(uuo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if uuo.mutation.FollowersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.FollowersTable,
			Columns: user.FollowersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		createE := &FollowCreate{config: uuo.config, mutation: newFollowMutation(uuo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.RemovedFollowersIDs(); len(nodes) > 0 && !uuo.mutation.FollowersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.FollowersTable,
			Columns: user.FollowersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &FollowCreate{config: uuo.config, mutation: newFollowMutation(uuo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.FollowersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: true,
			Table:   user.FollowersTable,
			Columns: user.FollowersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &FollowCreate{config: uuo.config, mutation: newFollowMutation(uuo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if uuo.mutation.FollowingCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   user.FollowingTable,
			Columns: user.FollowingPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.RemovedFollowingIDs(); len(nodes) > 0 && !uuo.mutation.FollowingCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   user.FollowingTable,
			Columns: user.FollowingPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.FollowingIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   user.FollowingTable,
			Columns: user.FollowingPrimaryKey,
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
	if uuo.mutation.DevicesCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.DevicesTable,
			Columns: []string{user.DevicesColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.RemovedDevicesIDs(); len(nodes) > 0 && !uuo.mutation.DevicesCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.DevicesTable,
			Columns: []string{user.DevicesColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.DevicesIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.DevicesTable,
			Columns: []string{user.DevicesColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(device.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if uuo.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.EventReminderNotificationsTable,
			Columns: []string{user.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.RemovedEventReminderNotificationsIDs(); len(nodes) > 0 && !uuo.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.EventReminderNotificationsTable,
			Columns: []string{user.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := uuo.mutation.EventReminderNotificationsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   user.EventReminderNotificationsTable,
			Columns: []string{user.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	_node = &User{config: uuo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, uuo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{user.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	uuo.mutation.done = true
	return _node, nil
}
