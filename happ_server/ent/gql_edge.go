// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"

	"github.com/99designs/gqlgen/graphql"
)

func (d *Device) Owner(ctx context.Context) (*User, error) {
	result, err := d.Edges.OwnerOrErr()
	if IsNotLoaded(err) {
		result, err = d.QueryOwner().Only(ctx)
	}
	return result, MaskNotFound(err)
}

func (e *Event) Users(ctx context.Context) (result []*User, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = e.NamedUsers(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = e.Edges.UsersOrErr()
	}
	if IsNotLoaded(err) {
		result, err = e.QueryUsers().All(ctx)
	}
	return result, err
}

func (e *Event) EventReminderNotifications(ctx context.Context) (result []*EventReminderNotification, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = e.NamedEventReminderNotifications(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = e.Edges.EventReminderNotificationsOrErr()
	}
	if IsNotLoaded(err) {
		result, err = e.QueryEventReminderNotifications().All(ctx)
	}
	return result, err
}

func (ern *EventReminderNotification) Event(ctx context.Context) (*Event, error) {
	result, err := ern.Edges.EventOrErr()
	if IsNotLoaded(err) {
		result, err = ern.QueryEvent().Only(ctx)
	}
	return result, err
}

func (ern *EventReminderNotification) User(ctx context.Context) (*User, error) {
	result, err := ern.Edges.UserOrErr()
	if IsNotLoaded(err) {
		result, err = ern.QueryUser().Only(ctx)
	}
	return result, err
}

func (u *User) Events(ctx context.Context) (result []*Event, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = u.NamedEvents(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = u.Edges.EventsOrErr()
	}
	if IsNotLoaded(err) {
		result, err = u.QueryEvents().All(ctx)
	}
	return result, err
}

func (u *User) Followers(ctx context.Context) (result []*User, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = u.NamedFollowers(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = u.Edges.FollowersOrErr()
	}
	if IsNotLoaded(err) {
		result, err = u.QueryFollowers().All(ctx)
	}
	return result, err
}

func (u *User) Following(ctx context.Context) (result []*User, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = u.NamedFollowing(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = u.Edges.FollowingOrErr()
	}
	if IsNotLoaded(err) {
		result, err = u.QueryFollowing().All(ctx)
	}
	return result, err
}

func (u *User) Devices(ctx context.Context) (result []*Device, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = u.NamedDevices(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = u.Edges.DevicesOrErr()
	}
	if IsNotLoaded(err) {
		result, err = u.QueryDevices().All(ctx)
	}
	return result, err
}

func (u *User) EventReminderNotifications(ctx context.Context) (result []*EventReminderNotification, err error) {
	if fc := graphql.GetFieldContext(ctx); fc != nil && fc.Field.Alias != "" {
		result, err = u.NamedEventReminderNotifications(graphql.GetFieldContext(ctx).Field.Alias)
	} else {
		result, err = u.Edges.EventReminderNotificationsOrErr()
	}
	if IsNotLoaded(err) {
		result, err = u.QueryEventReminderNotifications().All(ctx)
	}
	return result, err
}
