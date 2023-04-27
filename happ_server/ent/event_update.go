// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"happ/ent/event"
	"happ/ent/eventremindernotification"
	"happ/ent/predicate"
	"happ/ent/schema/schematype"
	"happ/ent/user"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/dialect/sql/sqljson"
	"entgo.io/ent/schema/field"
)

// EventUpdate is the builder for updating Event entities.
type EventUpdate struct {
	config
	hooks    []Hook
	mutation *EventMutation
}

// Where appends a list predicates to the EventUpdate builder.
func (eu *EventUpdate) Where(ps ...predicate.Event) *EventUpdate {
	eu.mutation.Where(ps...)
	return eu
}

// SetName sets the "name" field.
func (eu *EventUpdate) SetName(s string) *EventUpdate {
	eu.mutation.SetName(s)
	return eu
}

// SetDescription sets the "description" field.
func (eu *EventUpdate) SetDescription(s string) *EventUpdate {
	eu.mutation.SetDescription(s)
	return eu
}

// SetEventPlace sets the "event_place" field.
func (eu *EventUpdate) SetEventPlace(s string) *EventUpdate {
	eu.mutation.SetEventPlace(s)
	return eu
}

// SetConfirmedCount sets the "confirmed_count" field.
func (eu *EventUpdate) SetConfirmedCount(i int) *EventUpdate {
	eu.mutation.ResetConfirmedCount()
	eu.mutation.SetConfirmedCount(i)
	return eu
}

// SetNillableConfirmedCount sets the "confirmed_count" field if the given value is not nil.
func (eu *EventUpdate) SetNillableConfirmedCount(i *int) *EventUpdate {
	if i != nil {
		eu.SetConfirmedCount(*i)
	}
	return eu
}

// AddConfirmedCount adds i to the "confirmed_count" field.
func (eu *EventUpdate) AddConfirmedCount(i int) *EventUpdate {
	eu.mutation.AddConfirmedCount(i)
	return eu
}

// SetConfirmedHosts sets the "confirmed_hosts" field.
func (eu *EventUpdate) SetConfirmedHosts(i int) *EventUpdate {
	eu.mutation.ResetConfirmedHosts()
	eu.mutation.SetConfirmedHosts(i)
	return eu
}

// SetNillableConfirmedHosts sets the "confirmed_hosts" field if the given value is not nil.
func (eu *EventUpdate) SetNillableConfirmedHosts(i *int) *EventUpdate {
	if i != nil {
		eu.SetConfirmedHosts(*i)
	}
	return eu
}

// AddConfirmedHosts adds i to the "confirmed_hosts" field.
func (eu *EventUpdate) AddConfirmedHosts(i int) *EventUpdate {
	eu.mutation.AddConfirmedHosts(i)
	return eu
}

// SetEventPics sets the "event_pics" field.
func (eu *EventUpdate) SetEventPics(s []string) *EventUpdate {
	eu.mutation.SetEventPics(s)
	return eu
}

// AppendEventPics appends s to the "event_pics" field.
func (eu *EventUpdate) AppendEventPics(s []string) *EventUpdate {
	eu.mutation.AppendEventPics(s)
	return eu
}

// SetLightEventPics sets the "light_event_pics" field.
func (eu *EventUpdate) SetLightEventPics(s []string) *EventUpdate {
	eu.mutation.SetLightEventPics(s)
	return eu
}

// AppendLightEventPics appends s to the "light_event_pics" field.
func (eu *EventUpdate) AppendLightEventPics(s []string) *EventUpdate {
	eu.mutation.AppendLightEventPics(s)
	return eu
}

// SetEventKey sets the "event_key" field.
func (eu *EventUpdate) SetEventKey(s string) *EventUpdate {
	eu.mutation.SetEventKey(s)
	return eu
}

// SetEventNonce sets the "event_nonce" field.
func (eu *EventUpdate) SetEventNonce(s string) *EventUpdate {
	eu.mutation.SetEventNonce(s)
	return eu
}

// SetEventDate sets the "event_date" field.
func (eu *EventUpdate) SetEventDate(t time.Time) *EventUpdate {
	eu.mutation.SetEventDate(t)
	return eu
}

// SetCoords sets the "coords" field.
func (eu *EventUpdate) SetCoords(s *schematype.Point) *EventUpdate {
	eu.mutation.SetCoords(s)
	return eu
}

// AddUserIDs adds the "users" edge to the User entity by IDs.
func (eu *EventUpdate) AddUserIDs(ids ...int) *EventUpdate {
	eu.mutation.AddUserIDs(ids...)
	return eu
}

// AddUsers adds the "users" edges to the User entity.
func (eu *EventUpdate) AddUsers(u ...*User) *EventUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return eu.AddUserIDs(ids...)
}

// AddEventReminderNotificationIDs adds the "event_reminder_notifications" edge to the EventReminderNotification entity by IDs.
func (eu *EventUpdate) AddEventReminderNotificationIDs(ids ...int) *EventUpdate {
	eu.mutation.AddEventReminderNotificationIDs(ids...)
	return eu
}

// AddEventReminderNotifications adds the "event_reminder_notifications" edges to the EventReminderNotification entity.
func (eu *EventUpdate) AddEventReminderNotifications(e ...*EventReminderNotification) *EventUpdate {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return eu.AddEventReminderNotificationIDs(ids...)
}

// Mutation returns the EventMutation object of the builder.
func (eu *EventUpdate) Mutation() *EventMutation {
	return eu.mutation
}

// ClearUsers clears all "users" edges to the User entity.
func (eu *EventUpdate) ClearUsers() *EventUpdate {
	eu.mutation.ClearUsers()
	return eu
}

// RemoveUserIDs removes the "users" edge to User entities by IDs.
func (eu *EventUpdate) RemoveUserIDs(ids ...int) *EventUpdate {
	eu.mutation.RemoveUserIDs(ids...)
	return eu
}

// RemoveUsers removes "users" edges to User entities.
func (eu *EventUpdate) RemoveUsers(u ...*User) *EventUpdate {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return eu.RemoveUserIDs(ids...)
}

// ClearEventReminderNotifications clears all "event_reminder_notifications" edges to the EventReminderNotification entity.
func (eu *EventUpdate) ClearEventReminderNotifications() *EventUpdate {
	eu.mutation.ClearEventReminderNotifications()
	return eu
}

// RemoveEventReminderNotificationIDs removes the "event_reminder_notifications" edge to EventReminderNotification entities by IDs.
func (eu *EventUpdate) RemoveEventReminderNotificationIDs(ids ...int) *EventUpdate {
	eu.mutation.RemoveEventReminderNotificationIDs(ids...)
	return eu
}

// RemoveEventReminderNotifications removes "event_reminder_notifications" edges to EventReminderNotification entities.
func (eu *EventUpdate) RemoveEventReminderNotifications(e ...*EventReminderNotification) *EventUpdate {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return eu.RemoveEventReminderNotificationIDs(ids...)
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (eu *EventUpdate) Save(ctx context.Context) (int, error) {
	return withHooks[int, EventMutation](ctx, eu.sqlSave, eu.mutation, eu.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (eu *EventUpdate) SaveX(ctx context.Context) int {
	affected, err := eu.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (eu *EventUpdate) Exec(ctx context.Context) error {
	_, err := eu.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (eu *EventUpdate) ExecX(ctx context.Context) {
	if err := eu.Exec(ctx); err != nil {
		panic(err)
	}
}

// check runs all checks and user-defined validators on the builder.
func (eu *EventUpdate) check() error {
	if v, ok := eu.mutation.Name(); ok {
		if err := event.NameValidator(v); err != nil {
			return &ValidationError{Name: "name", err: fmt.Errorf(`ent: validator failed for field "Event.name": %w`, err)}
		}
	}
	if v, ok := eu.mutation.Description(); ok {
		if err := event.DescriptionValidator(v); err != nil {
			return &ValidationError{Name: "description", err: fmt.Errorf(`ent: validator failed for field "Event.description": %w`, err)}
		}
	}
	if v, ok := eu.mutation.EventPlace(); ok {
		if err := event.EventPlaceValidator(v); err != nil {
			return &ValidationError{Name: "event_place", err: fmt.Errorf(`ent: validator failed for field "Event.event_place": %w`, err)}
		}
	}
	if v, ok := eu.mutation.EventKey(); ok {
		if err := event.EventKeyValidator(v); err != nil {
			return &ValidationError{Name: "event_key", err: fmt.Errorf(`ent: validator failed for field "Event.event_key": %w`, err)}
		}
	}
	if v, ok := eu.mutation.EventNonce(); ok {
		if err := event.EventNonceValidator(v); err != nil {
			return &ValidationError{Name: "event_nonce", err: fmt.Errorf(`ent: validator failed for field "Event.event_nonce": %w`, err)}
		}
	}
	return nil
}

func (eu *EventUpdate) sqlSave(ctx context.Context) (n int, err error) {
	if err := eu.check(); err != nil {
		return n, err
	}
	_spec := sqlgraph.NewUpdateSpec(event.Table, event.Columns, sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt))
	if ps := eu.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := eu.mutation.Name(); ok {
		_spec.SetField(event.FieldName, field.TypeString, value)
	}
	if value, ok := eu.mutation.Description(); ok {
		_spec.SetField(event.FieldDescription, field.TypeString, value)
	}
	if value, ok := eu.mutation.EventPlace(); ok {
		_spec.SetField(event.FieldEventPlace, field.TypeString, value)
	}
	if value, ok := eu.mutation.ConfirmedCount(); ok {
		_spec.SetField(event.FieldConfirmedCount, field.TypeInt, value)
	}
	if value, ok := eu.mutation.AddedConfirmedCount(); ok {
		_spec.AddField(event.FieldConfirmedCount, field.TypeInt, value)
	}
	if value, ok := eu.mutation.ConfirmedHosts(); ok {
		_spec.SetField(event.FieldConfirmedHosts, field.TypeInt, value)
	}
	if value, ok := eu.mutation.AddedConfirmedHosts(); ok {
		_spec.AddField(event.FieldConfirmedHosts, field.TypeInt, value)
	}
	if value, ok := eu.mutation.EventPics(); ok {
		_spec.SetField(event.FieldEventPics, field.TypeJSON, value)
	}
	if value, ok := eu.mutation.AppendedEventPics(); ok {
		_spec.AddModifier(func(u *sql.UpdateBuilder) {
			sqljson.Append(u, event.FieldEventPics, value)
		})
	}
	if value, ok := eu.mutation.LightEventPics(); ok {
		_spec.SetField(event.FieldLightEventPics, field.TypeJSON, value)
	}
	if value, ok := eu.mutation.AppendedLightEventPics(); ok {
		_spec.AddModifier(func(u *sql.UpdateBuilder) {
			sqljson.Append(u, event.FieldLightEventPics, value)
		})
	}
	if value, ok := eu.mutation.EventKey(); ok {
		_spec.SetField(event.FieldEventKey, field.TypeString, value)
	}
	if value, ok := eu.mutation.EventNonce(); ok {
		_spec.SetField(event.FieldEventNonce, field.TypeString, value)
	}
	if value, ok := eu.mutation.EventDate(); ok {
		_spec.SetField(event.FieldEventDate, field.TypeTime, value)
	}
	if value, ok := eu.mutation.Coords(); ok {
		_spec.SetField(event.FieldCoords, field.TypeOther, value)
	}
	if eu.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   event.UsersTable,
			Columns: event.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		createE := &EventUserCreate{config: eu.config, mutation: newEventUserMutation(eu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := eu.mutation.RemovedUsersIDs(); len(nodes) > 0 && !eu.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   event.UsersTable,
			Columns: event.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: eu.config, mutation: newEventUserMutation(eu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := eu.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   event.UsersTable,
			Columns: event.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: eu.config, mutation: newEventUserMutation(eu.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if eu.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   event.EventReminderNotificationsTable,
			Columns: []string{event.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := eu.mutation.RemovedEventReminderNotificationsIDs(); len(nodes) > 0 && !eu.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   event.EventReminderNotificationsTable,
			Columns: []string{event.EventReminderNotificationsColumn},
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
	if nodes := eu.mutation.EventReminderNotificationsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   event.EventReminderNotificationsTable,
			Columns: []string{event.EventReminderNotificationsColumn},
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
	if n, err = sqlgraph.UpdateNodes(ctx, eu.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{event.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	eu.mutation.done = true
	return n, nil
}

// EventUpdateOne is the builder for updating a single Event entity.
type EventUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *EventMutation
}

// SetName sets the "name" field.
func (euo *EventUpdateOne) SetName(s string) *EventUpdateOne {
	euo.mutation.SetName(s)
	return euo
}

// SetDescription sets the "description" field.
func (euo *EventUpdateOne) SetDescription(s string) *EventUpdateOne {
	euo.mutation.SetDescription(s)
	return euo
}

// SetEventPlace sets the "event_place" field.
func (euo *EventUpdateOne) SetEventPlace(s string) *EventUpdateOne {
	euo.mutation.SetEventPlace(s)
	return euo
}

// SetConfirmedCount sets the "confirmed_count" field.
func (euo *EventUpdateOne) SetConfirmedCount(i int) *EventUpdateOne {
	euo.mutation.ResetConfirmedCount()
	euo.mutation.SetConfirmedCount(i)
	return euo
}

// SetNillableConfirmedCount sets the "confirmed_count" field if the given value is not nil.
func (euo *EventUpdateOne) SetNillableConfirmedCount(i *int) *EventUpdateOne {
	if i != nil {
		euo.SetConfirmedCount(*i)
	}
	return euo
}

// AddConfirmedCount adds i to the "confirmed_count" field.
func (euo *EventUpdateOne) AddConfirmedCount(i int) *EventUpdateOne {
	euo.mutation.AddConfirmedCount(i)
	return euo
}

// SetConfirmedHosts sets the "confirmed_hosts" field.
func (euo *EventUpdateOne) SetConfirmedHosts(i int) *EventUpdateOne {
	euo.mutation.ResetConfirmedHosts()
	euo.mutation.SetConfirmedHosts(i)
	return euo
}

// SetNillableConfirmedHosts sets the "confirmed_hosts" field if the given value is not nil.
func (euo *EventUpdateOne) SetNillableConfirmedHosts(i *int) *EventUpdateOne {
	if i != nil {
		euo.SetConfirmedHosts(*i)
	}
	return euo
}

// AddConfirmedHosts adds i to the "confirmed_hosts" field.
func (euo *EventUpdateOne) AddConfirmedHosts(i int) *EventUpdateOne {
	euo.mutation.AddConfirmedHosts(i)
	return euo
}

// SetEventPics sets the "event_pics" field.
func (euo *EventUpdateOne) SetEventPics(s []string) *EventUpdateOne {
	euo.mutation.SetEventPics(s)
	return euo
}

// AppendEventPics appends s to the "event_pics" field.
func (euo *EventUpdateOne) AppendEventPics(s []string) *EventUpdateOne {
	euo.mutation.AppendEventPics(s)
	return euo
}

// SetLightEventPics sets the "light_event_pics" field.
func (euo *EventUpdateOne) SetLightEventPics(s []string) *EventUpdateOne {
	euo.mutation.SetLightEventPics(s)
	return euo
}

// AppendLightEventPics appends s to the "light_event_pics" field.
func (euo *EventUpdateOne) AppendLightEventPics(s []string) *EventUpdateOne {
	euo.mutation.AppendLightEventPics(s)
	return euo
}

// SetEventKey sets the "event_key" field.
func (euo *EventUpdateOne) SetEventKey(s string) *EventUpdateOne {
	euo.mutation.SetEventKey(s)
	return euo
}

// SetEventNonce sets the "event_nonce" field.
func (euo *EventUpdateOne) SetEventNonce(s string) *EventUpdateOne {
	euo.mutation.SetEventNonce(s)
	return euo
}

// SetEventDate sets the "event_date" field.
func (euo *EventUpdateOne) SetEventDate(t time.Time) *EventUpdateOne {
	euo.mutation.SetEventDate(t)
	return euo
}

// SetCoords sets the "coords" field.
func (euo *EventUpdateOne) SetCoords(s *schematype.Point) *EventUpdateOne {
	euo.mutation.SetCoords(s)
	return euo
}

// AddUserIDs adds the "users" edge to the User entity by IDs.
func (euo *EventUpdateOne) AddUserIDs(ids ...int) *EventUpdateOne {
	euo.mutation.AddUserIDs(ids...)
	return euo
}

// AddUsers adds the "users" edges to the User entity.
func (euo *EventUpdateOne) AddUsers(u ...*User) *EventUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return euo.AddUserIDs(ids...)
}

// AddEventReminderNotificationIDs adds the "event_reminder_notifications" edge to the EventReminderNotification entity by IDs.
func (euo *EventUpdateOne) AddEventReminderNotificationIDs(ids ...int) *EventUpdateOne {
	euo.mutation.AddEventReminderNotificationIDs(ids...)
	return euo
}

// AddEventReminderNotifications adds the "event_reminder_notifications" edges to the EventReminderNotification entity.
func (euo *EventUpdateOne) AddEventReminderNotifications(e ...*EventReminderNotification) *EventUpdateOne {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return euo.AddEventReminderNotificationIDs(ids...)
}

// Mutation returns the EventMutation object of the builder.
func (euo *EventUpdateOne) Mutation() *EventMutation {
	return euo.mutation
}

// ClearUsers clears all "users" edges to the User entity.
func (euo *EventUpdateOne) ClearUsers() *EventUpdateOne {
	euo.mutation.ClearUsers()
	return euo
}

// RemoveUserIDs removes the "users" edge to User entities by IDs.
func (euo *EventUpdateOne) RemoveUserIDs(ids ...int) *EventUpdateOne {
	euo.mutation.RemoveUserIDs(ids...)
	return euo
}

// RemoveUsers removes "users" edges to User entities.
func (euo *EventUpdateOne) RemoveUsers(u ...*User) *EventUpdateOne {
	ids := make([]int, len(u))
	for i := range u {
		ids[i] = u[i].ID
	}
	return euo.RemoveUserIDs(ids...)
}

// ClearEventReminderNotifications clears all "event_reminder_notifications" edges to the EventReminderNotification entity.
func (euo *EventUpdateOne) ClearEventReminderNotifications() *EventUpdateOne {
	euo.mutation.ClearEventReminderNotifications()
	return euo
}

// RemoveEventReminderNotificationIDs removes the "event_reminder_notifications" edge to EventReminderNotification entities by IDs.
func (euo *EventUpdateOne) RemoveEventReminderNotificationIDs(ids ...int) *EventUpdateOne {
	euo.mutation.RemoveEventReminderNotificationIDs(ids...)
	return euo
}

// RemoveEventReminderNotifications removes "event_reminder_notifications" edges to EventReminderNotification entities.
func (euo *EventUpdateOne) RemoveEventReminderNotifications(e ...*EventReminderNotification) *EventUpdateOne {
	ids := make([]int, len(e))
	for i := range e {
		ids[i] = e[i].ID
	}
	return euo.RemoveEventReminderNotificationIDs(ids...)
}

// Where appends a list predicates to the EventUpdate builder.
func (euo *EventUpdateOne) Where(ps ...predicate.Event) *EventUpdateOne {
	euo.mutation.Where(ps...)
	return euo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (euo *EventUpdateOne) Select(field string, fields ...string) *EventUpdateOne {
	euo.fields = append([]string{field}, fields...)
	return euo
}

// Save executes the query and returns the updated Event entity.
func (euo *EventUpdateOne) Save(ctx context.Context) (*Event, error) {
	return withHooks[*Event, EventMutation](ctx, euo.sqlSave, euo.mutation, euo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (euo *EventUpdateOne) SaveX(ctx context.Context) *Event {
	node, err := euo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (euo *EventUpdateOne) Exec(ctx context.Context) error {
	_, err := euo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (euo *EventUpdateOne) ExecX(ctx context.Context) {
	if err := euo.Exec(ctx); err != nil {
		panic(err)
	}
}

// check runs all checks and user-defined validators on the builder.
func (euo *EventUpdateOne) check() error {
	if v, ok := euo.mutation.Name(); ok {
		if err := event.NameValidator(v); err != nil {
			return &ValidationError{Name: "name", err: fmt.Errorf(`ent: validator failed for field "Event.name": %w`, err)}
		}
	}
	if v, ok := euo.mutation.Description(); ok {
		if err := event.DescriptionValidator(v); err != nil {
			return &ValidationError{Name: "description", err: fmt.Errorf(`ent: validator failed for field "Event.description": %w`, err)}
		}
	}
	if v, ok := euo.mutation.EventPlace(); ok {
		if err := event.EventPlaceValidator(v); err != nil {
			return &ValidationError{Name: "event_place", err: fmt.Errorf(`ent: validator failed for field "Event.event_place": %w`, err)}
		}
	}
	if v, ok := euo.mutation.EventKey(); ok {
		if err := event.EventKeyValidator(v); err != nil {
			return &ValidationError{Name: "event_key", err: fmt.Errorf(`ent: validator failed for field "Event.event_key": %w`, err)}
		}
	}
	if v, ok := euo.mutation.EventNonce(); ok {
		if err := event.EventNonceValidator(v); err != nil {
			return &ValidationError{Name: "event_nonce", err: fmt.Errorf(`ent: validator failed for field "Event.event_nonce": %w`, err)}
		}
	}
	return nil
}

func (euo *EventUpdateOne) sqlSave(ctx context.Context) (_node *Event, err error) {
	if err := euo.check(); err != nil {
		return _node, err
	}
	_spec := sqlgraph.NewUpdateSpec(event.Table, event.Columns, sqlgraph.NewFieldSpec(event.FieldID, field.TypeInt))
	id, ok := euo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "id", err: errors.New(`ent: missing "Event.id" for update`)}
	}
	_spec.Node.ID.Value = id
	if fields := euo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, event.FieldID)
		for _, f := range fields {
			if !event.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			if f != event.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, f)
			}
		}
	}
	if ps := euo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := euo.mutation.Name(); ok {
		_spec.SetField(event.FieldName, field.TypeString, value)
	}
	if value, ok := euo.mutation.Description(); ok {
		_spec.SetField(event.FieldDescription, field.TypeString, value)
	}
	if value, ok := euo.mutation.EventPlace(); ok {
		_spec.SetField(event.FieldEventPlace, field.TypeString, value)
	}
	if value, ok := euo.mutation.ConfirmedCount(); ok {
		_spec.SetField(event.FieldConfirmedCount, field.TypeInt, value)
	}
	if value, ok := euo.mutation.AddedConfirmedCount(); ok {
		_spec.AddField(event.FieldConfirmedCount, field.TypeInt, value)
	}
	if value, ok := euo.mutation.ConfirmedHosts(); ok {
		_spec.SetField(event.FieldConfirmedHosts, field.TypeInt, value)
	}
	if value, ok := euo.mutation.AddedConfirmedHosts(); ok {
		_spec.AddField(event.FieldConfirmedHosts, field.TypeInt, value)
	}
	if value, ok := euo.mutation.EventPics(); ok {
		_spec.SetField(event.FieldEventPics, field.TypeJSON, value)
	}
	if value, ok := euo.mutation.AppendedEventPics(); ok {
		_spec.AddModifier(func(u *sql.UpdateBuilder) {
			sqljson.Append(u, event.FieldEventPics, value)
		})
	}
	if value, ok := euo.mutation.LightEventPics(); ok {
		_spec.SetField(event.FieldLightEventPics, field.TypeJSON, value)
	}
	if value, ok := euo.mutation.AppendedLightEventPics(); ok {
		_spec.AddModifier(func(u *sql.UpdateBuilder) {
			sqljson.Append(u, event.FieldLightEventPics, value)
		})
	}
	if value, ok := euo.mutation.EventKey(); ok {
		_spec.SetField(event.FieldEventKey, field.TypeString, value)
	}
	if value, ok := euo.mutation.EventNonce(); ok {
		_spec.SetField(event.FieldEventNonce, field.TypeString, value)
	}
	if value, ok := euo.mutation.EventDate(); ok {
		_spec.SetField(event.FieldEventDate, field.TypeTime, value)
	}
	if value, ok := euo.mutation.Coords(); ok {
		_spec.SetField(event.FieldCoords, field.TypeOther, value)
	}
	if euo.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   event.UsersTable,
			Columns: event.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		createE := &EventUserCreate{config: euo.config, mutation: newEventUserMutation(euo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euo.mutation.RemovedUsersIDs(); len(nodes) > 0 && !euo.mutation.UsersCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   event.UsersTable,
			Columns: event.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: euo.config, mutation: newEventUserMutation(euo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euo.mutation.UsersIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.M2M,
			Inverse: false,
			Table:   event.UsersTable,
			Columns: event.UsersPrimaryKey,
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(user.FieldID, field.TypeInt),
			},
		}
		for _, k := range nodes {
			edge.Target.Nodes = append(edge.Target.Nodes, k)
		}
		createE := &EventUserCreate{config: euo.config, mutation: newEventUserMutation(euo.config, OpCreate)}
		createE.defaults()
		_, specE := createE.createSpec()
		edge.Target.Fields = specE.Fields
		_spec.Edges.Add = append(_spec.Edges.Add, edge)
	}
	if euo.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   event.EventReminderNotificationsTable,
			Columns: []string{event.EventReminderNotificationsColumn},
			Bidi:    false,
			Target: &sqlgraph.EdgeTarget{
				IDSpec: sqlgraph.NewFieldSpec(eventremindernotification.FieldID, field.TypeInt),
			},
		}
		_spec.Edges.Clear = append(_spec.Edges.Clear, edge)
	}
	if nodes := euo.mutation.RemovedEventReminderNotificationsIDs(); len(nodes) > 0 && !euo.mutation.EventReminderNotificationsCleared() {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   event.EventReminderNotificationsTable,
			Columns: []string{event.EventReminderNotificationsColumn},
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
	if nodes := euo.mutation.EventReminderNotificationsIDs(); len(nodes) > 0 {
		edge := &sqlgraph.EdgeSpec{
			Rel:     sqlgraph.O2M,
			Inverse: false,
			Table:   event.EventReminderNotificationsTable,
			Columns: []string{event.EventReminderNotificationsColumn},
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
	_node = &Event{config: euo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, euo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{event.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	euo.mutation.done = true
	return _node, nil
}