// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

import (
	"fmt"
	"happ/ent"
	"io"
	"strconv"

	"github.com/99designs/gqlgen/graphql"
)

type AcceptInvitationResponse struct {
	CypherText *string `json:"cypherText,omitempty"`
	IsHost     bool    `json:"isHost"`
}

type AddResponse struct {
	Value     int  `json:"value"`
	Unchanged bool `json:"unchanged"`
}

type AppleData struct {
	Name              string `json:"name"`
	AuthorizationCode string `json:"authorizationCode"`
}

type Coordinates struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

type CoordinatesInput struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

type CreateEventResponse struct {
	Event  *ent.Event       `json:"event,omitempty"`
	Errors []*ErrorResponse `json:"errors,omitempty"`
}

type ErrorResponse struct {
	Field   string `json:"field"`
	Message string `json:"message"`
}

type EventInviteRes struct {
	Event           *ent.Event       `json:"event"`
	InvitedByUserID int              `json:"invitedByUserId"`
	InvitedBy       *ent.User        `json:"invitedBy"`
	InvitedUserInfo *InvitedUserInfo `json:"invitedUserInfo"`
	Friends         []*ent.User      `json:"friends"`
}

type InvitedUserInfo struct {
	IsConfirmed bool `json:"isConfirmed"`
	IsHost      bool `json:"isHost"`
	IsCreator   bool `json:"isCreator"`
}

type LocationAutoCompletePrediction struct {
	PlaceID     string `json:"placeId"`
	Description string `json:"description"`
}

type NewEventInput struct {
	Name           string            `json:"name"`
	Description    string            `json:"description"`
	EventDate      string            `json:"eventDate"`
	EventPics      []*graphql.Upload `json:"eventPics"`
	EventPicsLight []*graphql.Upload `json:"eventPicsLight"`
	EventPlace     string            `json:"eventPlace"`
	Latitude       float64           `json:"latitude"`
	Longitude      float64           `json:"longitude"`
}

type PaginatedEventResults struct {
	Events  []*EventInviteRes `json:"events"`
	HasMore bool              `json:"hasMore"`
}

type PaginatedEventUsersResults struct {
	Users   []*ent.User `json:"users"`
	HasMore bool        `json:"hasMore"`
}

type SignInInput struct {
	Token     string         `json:"token"`
	Provider  SignInProvider `json:"provider"`
	AppleData *AppleData     `json:"appleData,omitempty"`
}

type SignInResponse struct {
	User  *ent.User `json:"user,omitempty"`
	IsNew *bool     `json:"isNew,omitempty"`
}

type UpdateEventInput struct {
	Name           *string               `json:"name,omitempty"`
	Description    *string               `json:"description,omitempty"`
	EventDate      *string               `json:"eventDate,omitempty"`
	EventPics      []*UpdatePictureInput `json:"eventPics,omitempty"`
	EventPicsLight []*UpdatePictureInput `json:"eventPicsLight,omitempty"`
	EventPlace     *string               `json:"eventPlace,omitempty"`
	Latitude       *float64              `json:"latitude,omitempty"`
	Longitude      *float64              `json:"longitude,omitempty"`
}

type UpdatePictureInput struct {
	Index  int             `json:"index"`
	File   *graphql.Upload `json:"file,omitempty"`
	Action PictureAction   `json:"action"`
}

type PictureAction string

const (
	PictureActionAdd     PictureAction = "ADD"
	PictureActionReplace PictureAction = "REPLACE"
	PictureActionDelete  PictureAction = "DELETE"
)

var AllPictureAction = []PictureAction{
	PictureActionAdd,
	PictureActionReplace,
	PictureActionDelete,
}

func (e PictureAction) IsValid() bool {
	switch e {
	case PictureActionAdd, PictureActionReplace, PictureActionDelete:
		return true
	}
	return false
}

func (e PictureAction) String() string {
	return string(e)
}

func (e *PictureAction) UnmarshalGQL(v interface{}) error {
	str, ok := v.(string)
	if !ok {
		return fmt.Errorf("enums must be strings")
	}

	*e = PictureAction(str)
	if !e.IsValid() {
		return fmt.Errorf("%s is not a valid PictureAction", str)
	}
	return nil
}

func (e PictureAction) MarshalGQL(w io.Writer) {
	fmt.Fprint(w, strconv.Quote(e.String()))
}

type SignInProvider string

const (
	SignInProviderApple  SignInProvider = "APPLE"
	SignInProviderGoogle SignInProvider = "GOOGLE"
)

var AllSignInProvider = []SignInProvider{
	SignInProviderApple,
	SignInProviderGoogle,
}

func (e SignInProvider) IsValid() bool {
	switch e {
	case SignInProviderApple, SignInProviderGoogle:
		return true
	}
	return false
}

func (e SignInProvider) String() string {
	return string(e)
}

func (e *SignInProvider) UnmarshalGQL(v interface{}) error {
	str, ok := v.(string)
	if !ok {
		return fmt.Errorf("enums must be strings")
	}

	*e = SignInProvider(str)
	if !e.IsValid() {
		return fmt.Errorf("%s is not a valid SignInProvider", str)
	}
	return nil
}

func (e SignInProvider) MarshalGQL(w io.Writer) {
	fmt.Fprint(w, strconv.Quote(e.String()))
}
