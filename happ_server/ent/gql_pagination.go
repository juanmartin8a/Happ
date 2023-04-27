// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"happ/ent/device"
	"happ/ent/event"
	"happ/ent/eventremindernotification"
	"happ/ent/user"

	"entgo.io/contrib/entgql"
	"entgo.io/ent"
	"entgo.io/ent/dialect/sql"
	"github.com/99designs/gqlgen/graphql"
	"github.com/99designs/gqlgen/graphql/errcode"
	"github.com/vektah/gqlparser/v2/gqlerror"
)

// Common entgql types.
type (
	Cursor         = entgql.Cursor[int]
	PageInfo       = entgql.PageInfo[int]
	OrderDirection = entgql.OrderDirection
)

func orderFunc(o OrderDirection, field string) func(*sql.Selector) {
	if o == entgql.OrderDirectionDesc {
		return Desc(field)
	}
	return Asc(field)
}

const errInvalidPagination = "INVALID_PAGINATION"

func validateFirstLast(first, last *int) (err *gqlerror.Error) {
	switch {
	case first != nil && last != nil:
		err = &gqlerror.Error{
			Message: "Passing both `first` and `last` to paginate a connection is not supported.",
		}
	case first != nil && *first < 0:
		err = &gqlerror.Error{
			Message: "`first` on a connection cannot be less than zero.",
		}
		errcode.Set(err, errInvalidPagination)
	case last != nil && *last < 0:
		err = &gqlerror.Error{
			Message: "`last` on a connection cannot be less than zero.",
		}
		errcode.Set(err, errInvalidPagination)
	}
	return err
}

func collectedField(ctx context.Context, path ...string) *graphql.CollectedField {
	fc := graphql.GetFieldContext(ctx)
	if fc == nil {
		return nil
	}
	field := fc.Field
	oc := graphql.GetOperationContext(ctx)
walk:
	for _, name := range path {
		for _, f := range graphql.CollectFields(oc, field.Selections, nil) {
			if f.Alias == name {
				field = f
				continue walk
			}
		}
		return nil
	}
	return &field
}

func hasCollectedField(ctx context.Context, path ...string) bool {
	if graphql.GetFieldContext(ctx) == nil {
		return true
	}
	return collectedField(ctx, path...) != nil
}

const (
	edgesField      = "edges"
	nodeField       = "node"
	pageInfoField   = "pageInfo"
	totalCountField = "totalCount"
)

func paginateLimit(first, last *int) int {
	var limit int
	if first != nil {
		limit = *first + 1
	} else if last != nil {
		limit = *last + 1
	}
	return limit
}

// DeviceEdge is the edge representation of Device.
type DeviceEdge struct {
	Node   *Device `json:"node"`
	Cursor Cursor  `json:"cursor"`
}

// DeviceConnection is the connection containing edges to Device.
type DeviceConnection struct {
	Edges      []*DeviceEdge `json:"edges"`
	PageInfo   PageInfo      `json:"pageInfo"`
	TotalCount int           `json:"totalCount"`
}

func (c *DeviceConnection) build(nodes []*Device, pager *devicePager, after *Cursor, first *int, before *Cursor, last *int) {
	c.PageInfo.HasNextPage = before != nil
	c.PageInfo.HasPreviousPage = after != nil
	if first != nil && *first+1 == len(nodes) {
		c.PageInfo.HasNextPage = true
		nodes = nodes[:len(nodes)-1]
	} else if last != nil && *last+1 == len(nodes) {
		c.PageInfo.HasPreviousPage = true
		nodes = nodes[:len(nodes)-1]
	}
	var nodeAt func(int) *Device
	if last != nil {
		n := len(nodes) - 1
		nodeAt = func(i int) *Device {
			return nodes[n-i]
		}
	} else {
		nodeAt = func(i int) *Device {
			return nodes[i]
		}
	}
	c.Edges = make([]*DeviceEdge, len(nodes))
	for i := range nodes {
		node := nodeAt(i)
		c.Edges[i] = &DeviceEdge{
			Node:   node,
			Cursor: pager.toCursor(node),
		}
	}
	if l := len(c.Edges); l > 0 {
		c.PageInfo.StartCursor = &c.Edges[0].Cursor
		c.PageInfo.EndCursor = &c.Edges[l-1].Cursor
	}
	if c.TotalCount == 0 {
		c.TotalCount = len(nodes)
	}
}

// DevicePaginateOption enables pagination customization.
type DevicePaginateOption func(*devicePager) error

// WithDeviceOrder configures pagination ordering.
func WithDeviceOrder(order *DeviceOrder) DevicePaginateOption {
	if order == nil {
		order = DefaultDeviceOrder
	}
	o := *order
	return func(pager *devicePager) error {
		if err := o.Direction.Validate(); err != nil {
			return err
		}
		if o.Field == nil {
			o.Field = DefaultDeviceOrder.Field
		}
		pager.order = &o
		return nil
	}
}

// WithDeviceFilter configures pagination filter.
func WithDeviceFilter(filter func(*DeviceQuery) (*DeviceQuery, error)) DevicePaginateOption {
	return func(pager *devicePager) error {
		if filter == nil {
			return errors.New("DeviceQuery filter cannot be nil")
		}
		pager.filter = filter
		return nil
	}
}

type devicePager struct {
	reverse bool
	order   *DeviceOrder
	filter  func(*DeviceQuery) (*DeviceQuery, error)
}

func newDevicePager(opts []DevicePaginateOption, reverse bool) (*devicePager, error) {
	pager := &devicePager{reverse: reverse}
	for _, opt := range opts {
		if err := opt(pager); err != nil {
			return nil, err
		}
	}
	if pager.order == nil {
		pager.order = DefaultDeviceOrder
	}
	return pager, nil
}

func (p *devicePager) applyFilter(query *DeviceQuery) (*DeviceQuery, error) {
	if p.filter != nil {
		return p.filter(query)
	}
	return query, nil
}

func (p *devicePager) toCursor(d *Device) Cursor {
	return p.order.Field.toCursor(d)
}

func (p *devicePager) applyCursors(query *DeviceQuery, after, before *Cursor) (*DeviceQuery, error) {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	for _, predicate := range entgql.CursorsPredicate(after, before, DefaultDeviceOrder.Field.column, p.order.Field.column, direction) {
		query = query.Where(predicate)
	}
	return query, nil
}

func (p *devicePager) applyOrder(query *DeviceQuery) *DeviceQuery {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	query = query.Order(p.order.Field.toTerm(direction.OrderTermOption()))
	if p.order.Field != DefaultDeviceOrder.Field {
		query = query.Order(DefaultDeviceOrder.Field.toTerm(direction.OrderTermOption()))
	}
	return query
}

func (p *devicePager) orderExpr(query *DeviceQuery) sql.Querier {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	return sql.ExprFunc(func(b *sql.Builder) {
		b.Ident(p.order.Field.column).Pad().WriteString(string(direction))
		if p.order.Field != DefaultDeviceOrder.Field {
			b.Comma().Ident(DefaultDeviceOrder.Field.column).Pad().WriteString(string(direction))
		}
	})
}

// Paginate executes the query and returns a relay based cursor connection to Device.
func (d *DeviceQuery) Paginate(
	ctx context.Context, after *Cursor, first *int,
	before *Cursor, last *int, opts ...DevicePaginateOption,
) (*DeviceConnection, error) {
	if err := validateFirstLast(first, last); err != nil {
		return nil, err
	}
	pager, err := newDevicePager(opts, last != nil)
	if err != nil {
		return nil, err
	}
	if d, err = pager.applyFilter(d); err != nil {
		return nil, err
	}
	conn := &DeviceConnection{Edges: []*DeviceEdge{}}
	ignoredEdges := !hasCollectedField(ctx, edgesField)
	if hasCollectedField(ctx, totalCountField) || hasCollectedField(ctx, pageInfoField) {
		hasPagination := after != nil || first != nil || before != nil || last != nil
		if hasPagination || ignoredEdges {
			if conn.TotalCount, err = d.Clone().Count(ctx); err != nil {
				return nil, err
			}
			conn.PageInfo.HasNextPage = first != nil && conn.TotalCount > 0
			conn.PageInfo.HasPreviousPage = last != nil && conn.TotalCount > 0
		}
	}
	if ignoredEdges || (first != nil && *first == 0) || (last != nil && *last == 0) {
		return conn, nil
	}

	if d, err = pager.applyCursors(d, after, before); err != nil {
		return nil, err
	}
	d = pager.applyOrder(d)
	if limit := paginateLimit(first, last); limit != 0 {
		d.Limit(limit)
	}
	if field := collectedField(ctx, edgesField, nodeField); field != nil {
		if err := d.collectField(ctx, graphql.GetOperationContext(ctx), *field, []string{edgesField, nodeField}); err != nil {
			return nil, err
		}
	}

	nodes, err := d.All(ctx)
	if err != nil {
		return nil, err
	}
	conn.build(nodes, pager, after, first, before, last)
	return conn, nil
}

// DeviceOrderField defines the ordering field of Device.
type DeviceOrderField struct {
	// Value extracts the ordering value from the given Device.
	Value    func(*Device) (ent.Value, error)
	column   string // field or computed.
	toTerm   func(...sql.OrderTermOption) device.OrderOption
	toCursor func(*Device) Cursor
}

// DeviceOrder defines the ordering of Device.
type DeviceOrder struct {
	Direction OrderDirection    `json:"direction"`
	Field     *DeviceOrderField `json:"field"`
}

// DefaultDeviceOrder is the default ordering of Device.
var DefaultDeviceOrder = &DeviceOrder{
	Direction: entgql.OrderDirectionAsc,
	Field: &DeviceOrderField{
		Value: func(d *Device) (ent.Value, error) {
			return d.ID, nil
		},
		column: device.FieldID,
		toTerm: device.ByID,
		toCursor: func(d *Device) Cursor {
			return Cursor{ID: d.ID}
		},
	},
}

// ToEdge converts Device into DeviceEdge.
func (d *Device) ToEdge(order *DeviceOrder) *DeviceEdge {
	if order == nil {
		order = DefaultDeviceOrder
	}
	return &DeviceEdge{
		Node:   d,
		Cursor: order.Field.toCursor(d),
	}
}

// EventEdge is the edge representation of Event.
type EventEdge struct {
	Node   *Event `json:"node"`
	Cursor Cursor `json:"cursor"`
}

// EventConnection is the connection containing edges to Event.
type EventConnection struct {
	Edges      []*EventEdge `json:"edges"`
	PageInfo   PageInfo     `json:"pageInfo"`
	TotalCount int          `json:"totalCount"`
}

func (c *EventConnection) build(nodes []*Event, pager *eventPager, after *Cursor, first *int, before *Cursor, last *int) {
	c.PageInfo.HasNextPage = before != nil
	c.PageInfo.HasPreviousPage = after != nil
	if first != nil && *first+1 == len(nodes) {
		c.PageInfo.HasNextPage = true
		nodes = nodes[:len(nodes)-1]
	} else if last != nil && *last+1 == len(nodes) {
		c.PageInfo.HasPreviousPage = true
		nodes = nodes[:len(nodes)-1]
	}
	var nodeAt func(int) *Event
	if last != nil {
		n := len(nodes) - 1
		nodeAt = func(i int) *Event {
			return nodes[n-i]
		}
	} else {
		nodeAt = func(i int) *Event {
			return nodes[i]
		}
	}
	c.Edges = make([]*EventEdge, len(nodes))
	for i := range nodes {
		node := nodeAt(i)
		c.Edges[i] = &EventEdge{
			Node:   node,
			Cursor: pager.toCursor(node),
		}
	}
	if l := len(c.Edges); l > 0 {
		c.PageInfo.StartCursor = &c.Edges[0].Cursor
		c.PageInfo.EndCursor = &c.Edges[l-1].Cursor
	}
	if c.TotalCount == 0 {
		c.TotalCount = len(nodes)
	}
}

// EventPaginateOption enables pagination customization.
type EventPaginateOption func(*eventPager) error

// WithEventOrder configures pagination ordering.
func WithEventOrder(order *EventOrder) EventPaginateOption {
	if order == nil {
		order = DefaultEventOrder
	}
	o := *order
	return func(pager *eventPager) error {
		if err := o.Direction.Validate(); err != nil {
			return err
		}
		if o.Field == nil {
			o.Field = DefaultEventOrder.Field
		}
		pager.order = &o
		return nil
	}
}

// WithEventFilter configures pagination filter.
func WithEventFilter(filter func(*EventQuery) (*EventQuery, error)) EventPaginateOption {
	return func(pager *eventPager) error {
		if filter == nil {
			return errors.New("EventQuery filter cannot be nil")
		}
		pager.filter = filter
		return nil
	}
}

type eventPager struct {
	reverse bool
	order   *EventOrder
	filter  func(*EventQuery) (*EventQuery, error)
}

func newEventPager(opts []EventPaginateOption, reverse bool) (*eventPager, error) {
	pager := &eventPager{reverse: reverse}
	for _, opt := range opts {
		if err := opt(pager); err != nil {
			return nil, err
		}
	}
	if pager.order == nil {
		pager.order = DefaultEventOrder
	}
	return pager, nil
}

func (p *eventPager) applyFilter(query *EventQuery) (*EventQuery, error) {
	if p.filter != nil {
		return p.filter(query)
	}
	return query, nil
}

func (p *eventPager) toCursor(e *Event) Cursor {
	return p.order.Field.toCursor(e)
}

func (p *eventPager) applyCursors(query *EventQuery, after, before *Cursor) (*EventQuery, error) {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	for _, predicate := range entgql.CursorsPredicate(after, before, DefaultEventOrder.Field.column, p.order.Field.column, direction) {
		query = query.Where(predicate)
	}
	return query, nil
}

func (p *eventPager) applyOrder(query *EventQuery) *EventQuery {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	query = query.Order(p.order.Field.toTerm(direction.OrderTermOption()))
	if p.order.Field != DefaultEventOrder.Field {
		query = query.Order(DefaultEventOrder.Field.toTerm(direction.OrderTermOption()))
	}
	return query
}

func (p *eventPager) orderExpr(query *EventQuery) sql.Querier {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	return sql.ExprFunc(func(b *sql.Builder) {
		b.Ident(p.order.Field.column).Pad().WriteString(string(direction))
		if p.order.Field != DefaultEventOrder.Field {
			b.Comma().Ident(DefaultEventOrder.Field.column).Pad().WriteString(string(direction))
		}
	})
}

// Paginate executes the query and returns a relay based cursor connection to Event.
func (e *EventQuery) Paginate(
	ctx context.Context, after *Cursor, first *int,
	before *Cursor, last *int, opts ...EventPaginateOption,
) (*EventConnection, error) {
	if err := validateFirstLast(first, last); err != nil {
		return nil, err
	}
	pager, err := newEventPager(opts, last != nil)
	if err != nil {
		return nil, err
	}
	if e, err = pager.applyFilter(e); err != nil {
		return nil, err
	}
	conn := &EventConnection{Edges: []*EventEdge{}}
	ignoredEdges := !hasCollectedField(ctx, edgesField)
	if hasCollectedField(ctx, totalCountField) || hasCollectedField(ctx, pageInfoField) {
		hasPagination := after != nil || first != nil || before != nil || last != nil
		if hasPagination || ignoredEdges {
			if conn.TotalCount, err = e.Clone().Count(ctx); err != nil {
				return nil, err
			}
			conn.PageInfo.HasNextPage = first != nil && conn.TotalCount > 0
			conn.PageInfo.HasPreviousPage = last != nil && conn.TotalCount > 0
		}
	}
	if ignoredEdges || (first != nil && *first == 0) || (last != nil && *last == 0) {
		return conn, nil
	}

	if e, err = pager.applyCursors(e, after, before); err != nil {
		return nil, err
	}
	e = pager.applyOrder(e)
	if limit := paginateLimit(first, last); limit != 0 {
		e.Limit(limit)
	}
	if field := collectedField(ctx, edgesField, nodeField); field != nil {
		if err := e.collectField(ctx, graphql.GetOperationContext(ctx), *field, []string{edgesField, nodeField}); err != nil {
			return nil, err
		}
	}

	nodes, err := e.All(ctx)
	if err != nil {
		return nil, err
	}
	conn.build(nodes, pager, after, first, before, last)
	return conn, nil
}

// EventOrderField defines the ordering field of Event.
type EventOrderField struct {
	// Value extracts the ordering value from the given Event.
	Value    func(*Event) (ent.Value, error)
	column   string // field or computed.
	toTerm   func(...sql.OrderTermOption) event.OrderOption
	toCursor func(*Event) Cursor
}

// EventOrder defines the ordering of Event.
type EventOrder struct {
	Direction OrderDirection   `json:"direction"`
	Field     *EventOrderField `json:"field"`
}

// DefaultEventOrder is the default ordering of Event.
var DefaultEventOrder = &EventOrder{
	Direction: entgql.OrderDirectionAsc,
	Field: &EventOrderField{
		Value: func(e *Event) (ent.Value, error) {
			return e.ID, nil
		},
		column: event.FieldID,
		toTerm: event.ByID,
		toCursor: func(e *Event) Cursor {
			return Cursor{ID: e.ID}
		},
	},
}

// ToEdge converts Event into EventEdge.
func (e *Event) ToEdge(order *EventOrder) *EventEdge {
	if order == nil {
		order = DefaultEventOrder
	}
	return &EventEdge{
		Node:   e,
		Cursor: order.Field.toCursor(e),
	}
}

// EventReminderNotificationEdge is the edge representation of EventReminderNotification.
type EventReminderNotificationEdge struct {
	Node   *EventReminderNotification `json:"node"`
	Cursor Cursor                     `json:"cursor"`
}

// EventReminderNotificationConnection is the connection containing edges to EventReminderNotification.
type EventReminderNotificationConnection struct {
	Edges      []*EventReminderNotificationEdge `json:"edges"`
	PageInfo   PageInfo                         `json:"pageInfo"`
	TotalCount int                              `json:"totalCount"`
}

func (c *EventReminderNotificationConnection) build(nodes []*EventReminderNotification, pager *eventremindernotificationPager, after *Cursor, first *int, before *Cursor, last *int) {
	c.PageInfo.HasNextPage = before != nil
	c.PageInfo.HasPreviousPage = after != nil
	if first != nil && *first+1 == len(nodes) {
		c.PageInfo.HasNextPage = true
		nodes = nodes[:len(nodes)-1]
	} else if last != nil && *last+1 == len(nodes) {
		c.PageInfo.HasPreviousPage = true
		nodes = nodes[:len(nodes)-1]
	}
	var nodeAt func(int) *EventReminderNotification
	if last != nil {
		n := len(nodes) - 1
		nodeAt = func(i int) *EventReminderNotification {
			return nodes[n-i]
		}
	} else {
		nodeAt = func(i int) *EventReminderNotification {
			return nodes[i]
		}
	}
	c.Edges = make([]*EventReminderNotificationEdge, len(nodes))
	for i := range nodes {
		node := nodeAt(i)
		c.Edges[i] = &EventReminderNotificationEdge{
			Node:   node,
			Cursor: pager.toCursor(node),
		}
	}
	if l := len(c.Edges); l > 0 {
		c.PageInfo.StartCursor = &c.Edges[0].Cursor
		c.PageInfo.EndCursor = &c.Edges[l-1].Cursor
	}
	if c.TotalCount == 0 {
		c.TotalCount = len(nodes)
	}
}

// EventReminderNotificationPaginateOption enables pagination customization.
type EventReminderNotificationPaginateOption func(*eventremindernotificationPager) error

// WithEventReminderNotificationOrder configures pagination ordering.
func WithEventReminderNotificationOrder(order *EventReminderNotificationOrder) EventReminderNotificationPaginateOption {
	if order == nil {
		order = DefaultEventReminderNotificationOrder
	}
	o := *order
	return func(pager *eventremindernotificationPager) error {
		if err := o.Direction.Validate(); err != nil {
			return err
		}
		if o.Field == nil {
			o.Field = DefaultEventReminderNotificationOrder.Field
		}
		pager.order = &o
		return nil
	}
}

// WithEventReminderNotificationFilter configures pagination filter.
func WithEventReminderNotificationFilter(filter func(*EventReminderNotificationQuery) (*EventReminderNotificationQuery, error)) EventReminderNotificationPaginateOption {
	return func(pager *eventremindernotificationPager) error {
		if filter == nil {
			return errors.New("EventReminderNotificationQuery filter cannot be nil")
		}
		pager.filter = filter
		return nil
	}
}

type eventremindernotificationPager struct {
	reverse bool
	order   *EventReminderNotificationOrder
	filter  func(*EventReminderNotificationQuery) (*EventReminderNotificationQuery, error)
}

func newEventReminderNotificationPager(opts []EventReminderNotificationPaginateOption, reverse bool) (*eventremindernotificationPager, error) {
	pager := &eventremindernotificationPager{reverse: reverse}
	for _, opt := range opts {
		if err := opt(pager); err != nil {
			return nil, err
		}
	}
	if pager.order == nil {
		pager.order = DefaultEventReminderNotificationOrder
	}
	return pager, nil
}

func (p *eventremindernotificationPager) applyFilter(query *EventReminderNotificationQuery) (*EventReminderNotificationQuery, error) {
	if p.filter != nil {
		return p.filter(query)
	}
	return query, nil
}

func (p *eventremindernotificationPager) toCursor(ern *EventReminderNotification) Cursor {
	return p.order.Field.toCursor(ern)
}

func (p *eventremindernotificationPager) applyCursors(query *EventReminderNotificationQuery, after, before *Cursor) (*EventReminderNotificationQuery, error) {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	for _, predicate := range entgql.CursorsPredicate(after, before, DefaultEventReminderNotificationOrder.Field.column, p.order.Field.column, direction) {
		query = query.Where(predicate)
	}
	return query, nil
}

func (p *eventremindernotificationPager) applyOrder(query *EventReminderNotificationQuery) *EventReminderNotificationQuery {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	query = query.Order(p.order.Field.toTerm(direction.OrderTermOption()))
	if p.order.Field != DefaultEventReminderNotificationOrder.Field {
		query = query.Order(DefaultEventReminderNotificationOrder.Field.toTerm(direction.OrderTermOption()))
	}
	return query
}

func (p *eventremindernotificationPager) orderExpr(query *EventReminderNotificationQuery) sql.Querier {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	return sql.ExprFunc(func(b *sql.Builder) {
		b.Ident(p.order.Field.column).Pad().WriteString(string(direction))
		if p.order.Field != DefaultEventReminderNotificationOrder.Field {
			b.Comma().Ident(DefaultEventReminderNotificationOrder.Field.column).Pad().WriteString(string(direction))
		}
	})
}

// Paginate executes the query and returns a relay based cursor connection to EventReminderNotification.
func (ern *EventReminderNotificationQuery) Paginate(
	ctx context.Context, after *Cursor, first *int,
	before *Cursor, last *int, opts ...EventReminderNotificationPaginateOption,
) (*EventReminderNotificationConnection, error) {
	if err := validateFirstLast(first, last); err != nil {
		return nil, err
	}
	pager, err := newEventReminderNotificationPager(opts, last != nil)
	if err != nil {
		return nil, err
	}
	if ern, err = pager.applyFilter(ern); err != nil {
		return nil, err
	}
	conn := &EventReminderNotificationConnection{Edges: []*EventReminderNotificationEdge{}}
	ignoredEdges := !hasCollectedField(ctx, edgesField)
	if hasCollectedField(ctx, totalCountField) || hasCollectedField(ctx, pageInfoField) {
		hasPagination := after != nil || first != nil || before != nil || last != nil
		if hasPagination || ignoredEdges {
			if conn.TotalCount, err = ern.Clone().Count(ctx); err != nil {
				return nil, err
			}
			conn.PageInfo.HasNextPage = first != nil && conn.TotalCount > 0
			conn.PageInfo.HasPreviousPage = last != nil && conn.TotalCount > 0
		}
	}
	if ignoredEdges || (first != nil && *first == 0) || (last != nil && *last == 0) {
		return conn, nil
	}

	if ern, err = pager.applyCursors(ern, after, before); err != nil {
		return nil, err
	}
	ern = pager.applyOrder(ern)
	if limit := paginateLimit(first, last); limit != 0 {
		ern.Limit(limit)
	}
	if field := collectedField(ctx, edgesField, nodeField); field != nil {
		if err := ern.collectField(ctx, graphql.GetOperationContext(ctx), *field, []string{edgesField, nodeField}); err != nil {
			return nil, err
		}
	}

	nodes, err := ern.All(ctx)
	if err != nil {
		return nil, err
	}
	conn.build(nodes, pager, after, first, before, last)
	return conn, nil
}

// EventReminderNotificationOrderField defines the ordering field of EventReminderNotification.
type EventReminderNotificationOrderField struct {
	// Value extracts the ordering value from the given EventReminderNotification.
	Value    func(*EventReminderNotification) (ent.Value, error)
	column   string // field or computed.
	toTerm   func(...sql.OrderTermOption) eventremindernotification.OrderOption
	toCursor func(*EventReminderNotification) Cursor
}

// EventReminderNotificationOrder defines the ordering of EventReminderNotification.
type EventReminderNotificationOrder struct {
	Direction OrderDirection                       `json:"direction"`
	Field     *EventReminderNotificationOrderField `json:"field"`
}

// DefaultEventReminderNotificationOrder is the default ordering of EventReminderNotification.
var DefaultEventReminderNotificationOrder = &EventReminderNotificationOrder{
	Direction: entgql.OrderDirectionAsc,
	Field: &EventReminderNotificationOrderField{
		Value: func(ern *EventReminderNotification) (ent.Value, error) {
			return ern.ID, nil
		},
		column: eventremindernotification.FieldID,
		toTerm: eventremindernotification.ByID,
		toCursor: func(ern *EventReminderNotification) Cursor {
			return Cursor{ID: ern.ID}
		},
	},
}

// ToEdge converts EventReminderNotification into EventReminderNotificationEdge.
func (ern *EventReminderNotification) ToEdge(order *EventReminderNotificationOrder) *EventReminderNotificationEdge {
	if order == nil {
		order = DefaultEventReminderNotificationOrder
	}
	return &EventReminderNotificationEdge{
		Node:   ern,
		Cursor: order.Field.toCursor(ern),
	}
}

// UserEdge is the edge representation of User.
type UserEdge struct {
	Node   *User  `json:"node"`
	Cursor Cursor `json:"cursor"`
}

// UserConnection is the connection containing edges to User.
type UserConnection struct {
	Edges      []*UserEdge `json:"edges"`
	PageInfo   PageInfo    `json:"pageInfo"`
	TotalCount int         `json:"totalCount"`
}

func (c *UserConnection) build(nodes []*User, pager *userPager, after *Cursor, first *int, before *Cursor, last *int) {
	c.PageInfo.HasNextPage = before != nil
	c.PageInfo.HasPreviousPage = after != nil
	if first != nil && *first+1 == len(nodes) {
		c.PageInfo.HasNextPage = true
		nodes = nodes[:len(nodes)-1]
	} else if last != nil && *last+1 == len(nodes) {
		c.PageInfo.HasPreviousPage = true
		nodes = nodes[:len(nodes)-1]
	}
	var nodeAt func(int) *User
	if last != nil {
		n := len(nodes) - 1
		nodeAt = func(i int) *User {
			return nodes[n-i]
		}
	} else {
		nodeAt = func(i int) *User {
			return nodes[i]
		}
	}
	c.Edges = make([]*UserEdge, len(nodes))
	for i := range nodes {
		node := nodeAt(i)
		c.Edges[i] = &UserEdge{
			Node:   node,
			Cursor: pager.toCursor(node),
		}
	}
	if l := len(c.Edges); l > 0 {
		c.PageInfo.StartCursor = &c.Edges[0].Cursor
		c.PageInfo.EndCursor = &c.Edges[l-1].Cursor
	}
	if c.TotalCount == 0 {
		c.TotalCount = len(nodes)
	}
}

// UserPaginateOption enables pagination customization.
type UserPaginateOption func(*userPager) error

// WithUserOrder configures pagination ordering.
func WithUserOrder(order *UserOrder) UserPaginateOption {
	if order == nil {
		order = DefaultUserOrder
	}
	o := *order
	return func(pager *userPager) error {
		if err := o.Direction.Validate(); err != nil {
			return err
		}
		if o.Field == nil {
			o.Field = DefaultUserOrder.Field
		}
		pager.order = &o
		return nil
	}
}

// WithUserFilter configures pagination filter.
func WithUserFilter(filter func(*UserQuery) (*UserQuery, error)) UserPaginateOption {
	return func(pager *userPager) error {
		if filter == nil {
			return errors.New("UserQuery filter cannot be nil")
		}
		pager.filter = filter
		return nil
	}
}

type userPager struct {
	reverse bool
	order   *UserOrder
	filter  func(*UserQuery) (*UserQuery, error)
}

func newUserPager(opts []UserPaginateOption, reverse bool) (*userPager, error) {
	pager := &userPager{reverse: reverse}
	for _, opt := range opts {
		if err := opt(pager); err != nil {
			return nil, err
		}
	}
	if pager.order == nil {
		pager.order = DefaultUserOrder
	}
	return pager, nil
}

func (p *userPager) applyFilter(query *UserQuery) (*UserQuery, error) {
	if p.filter != nil {
		return p.filter(query)
	}
	return query, nil
}

func (p *userPager) toCursor(u *User) Cursor {
	return p.order.Field.toCursor(u)
}

func (p *userPager) applyCursors(query *UserQuery, after, before *Cursor) (*UserQuery, error) {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	for _, predicate := range entgql.CursorsPredicate(after, before, DefaultUserOrder.Field.column, p.order.Field.column, direction) {
		query = query.Where(predicate)
	}
	return query, nil
}

func (p *userPager) applyOrder(query *UserQuery) *UserQuery {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	query = query.Order(p.order.Field.toTerm(direction.OrderTermOption()))
	if p.order.Field != DefaultUserOrder.Field {
		query = query.Order(DefaultUserOrder.Field.toTerm(direction.OrderTermOption()))
	}
	return query
}

func (p *userPager) orderExpr(query *UserQuery) sql.Querier {
	direction := p.order.Direction
	if p.reverse {
		direction = direction.Reverse()
	}
	return sql.ExprFunc(func(b *sql.Builder) {
		b.Ident(p.order.Field.column).Pad().WriteString(string(direction))
		if p.order.Field != DefaultUserOrder.Field {
			b.Comma().Ident(DefaultUserOrder.Field.column).Pad().WriteString(string(direction))
		}
	})
}

// Paginate executes the query and returns a relay based cursor connection to User.
func (u *UserQuery) Paginate(
	ctx context.Context, after *Cursor, first *int,
	before *Cursor, last *int, opts ...UserPaginateOption,
) (*UserConnection, error) {
	if err := validateFirstLast(first, last); err != nil {
		return nil, err
	}
	pager, err := newUserPager(opts, last != nil)
	if err != nil {
		return nil, err
	}
	if u, err = pager.applyFilter(u); err != nil {
		return nil, err
	}
	conn := &UserConnection{Edges: []*UserEdge{}}
	ignoredEdges := !hasCollectedField(ctx, edgesField)
	if hasCollectedField(ctx, totalCountField) || hasCollectedField(ctx, pageInfoField) {
		hasPagination := after != nil || first != nil || before != nil || last != nil
		if hasPagination || ignoredEdges {
			if conn.TotalCount, err = u.Clone().Count(ctx); err != nil {
				return nil, err
			}
			conn.PageInfo.HasNextPage = first != nil && conn.TotalCount > 0
			conn.PageInfo.HasPreviousPage = last != nil && conn.TotalCount > 0
		}
	}
	if ignoredEdges || (first != nil && *first == 0) || (last != nil && *last == 0) {
		return conn, nil
	}

	if u, err = pager.applyCursors(u, after, before); err != nil {
		return nil, err
	}
	u = pager.applyOrder(u)
	if limit := paginateLimit(first, last); limit != 0 {
		u.Limit(limit)
	}
	if field := collectedField(ctx, edgesField, nodeField); field != nil {
		if err := u.collectField(ctx, graphql.GetOperationContext(ctx), *field, []string{edgesField, nodeField}); err != nil {
			return nil, err
		}
	}

	nodes, err := u.All(ctx)
	if err != nil {
		return nil, err
	}
	conn.build(nodes, pager, after, first, before, last)
	return conn, nil
}

// UserOrderField defines the ordering field of User.
type UserOrderField struct {
	// Value extracts the ordering value from the given User.
	Value    func(*User) (ent.Value, error)
	column   string // field or computed.
	toTerm   func(...sql.OrderTermOption) user.OrderOption
	toCursor func(*User) Cursor
}

// UserOrder defines the ordering of User.
type UserOrder struct {
	Direction OrderDirection  `json:"direction"`
	Field     *UserOrderField `json:"field"`
}

// DefaultUserOrder is the default ordering of User.
var DefaultUserOrder = &UserOrder{
	Direction: entgql.OrderDirectionAsc,
	Field: &UserOrderField{
		Value: func(u *User) (ent.Value, error) {
			return u.ID, nil
		},
		column: user.FieldID,
		toTerm: user.ByID,
		toCursor: func(u *User) Cursor {
			return Cursor{ID: u.ID}
		},
	},
}

// ToEdge converts User into UserEdge.
func (u *User) ToEdge(order *UserOrder) *UserEdge {
	if order == nil {
		order = DefaultUserOrder
	}
	return &UserEdge{
		Node:   u,
		Cursor: order.Field.toCursor(u),
	}
}
