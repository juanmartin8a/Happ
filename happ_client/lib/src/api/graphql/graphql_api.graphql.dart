// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:http/http.dart';
import 'package:happ_client/src/api/graphql/upload_serializer.dart';
part 'graphql_api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class AddOrRemoveUser$Mutation$AddResponse extends JsonSerializable
    with EquatableMixin {
  AddOrRemoveUser$Mutation$AddResponse();

  factory AddOrRemoveUser$Mutation$AddResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AddOrRemoveUser$Mutation$AddResponseFromJson(json);

  late int value;

  late bool unchanged;

  @override
  List<Object?> get props => [value, unchanged];
  @override
  Map<String, dynamic> toJson() =>
      _$AddOrRemoveUser$Mutation$AddResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddOrRemoveUser$Mutation extends JsonSerializable with EquatableMixin {
  AddOrRemoveUser$Mutation();

  factory AddOrRemoveUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$AddOrRemoveUser$MutationFromJson(json);

  late AddOrRemoveUser$Mutation$AddResponse addOrRemoveUser;

  @override
  List<Object?> get props => [addOrRemoveUser];
  @override
  Map<String, dynamic> toJson() => _$AddOrRemoveUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates
    extends JsonSerializable with EquatableMixin {
  NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates();

  factory NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates.fromJson(
          Map<String, dynamic> json) =>
      _$NewEvent$Mutation$CreateEventResponse$Event$EventCoordinatesFromJson(
          json);

  late double latitude;

  late double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
  @override
  Map<String, dynamic> toJson() =>
      _$NewEvent$Mutation$CreateEventResponse$Event$EventCoordinatesToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class NewEvent$Mutation$CreateEventResponse$Event extends JsonSerializable
    with EquatableMixin {
  NewEvent$Mutation$CreateEventResponse$Event();

  factory NewEvent$Mutation$CreateEventResponse$Event.fromJson(
          Map<String, dynamic> json) =>
      _$NewEvent$Mutation$CreateEventResponse$EventFromJson(json);

  late int id;

  late String name;

  late String description;

  late int confirmedCount;

  late List<String> eventPics;

  late String eventDate;

  late NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates coords;

  late String createdAt;

  late String updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        confirmedCount,
        eventPics,
        eventDate,
        coords,
        createdAt,
        updatedAt
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$NewEvent$Mutation$CreateEventResponse$EventToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewEvent$Mutation$CreateEventResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  NewEvent$Mutation$CreateEventResponse$ErrorResponse();

  factory NewEvent$Mutation$CreateEventResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$NewEvent$Mutation$CreateEventResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$NewEvent$Mutation$CreateEventResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewEvent$Mutation$CreateEventResponse extends JsonSerializable
    with EquatableMixin {
  NewEvent$Mutation$CreateEventResponse();

  factory NewEvent$Mutation$CreateEventResponse.fromJson(
          Map<String, dynamic> json) =>
      _$NewEvent$Mutation$CreateEventResponseFromJson(json);

  NewEvent$Mutation$CreateEventResponse$Event? event;

  List<NewEvent$Mutation$CreateEventResponse$ErrorResponse>? errors;

  @override
  List<Object?> get props => [event, errors];
  @override
  Map<String, dynamic> toJson() =>
      _$NewEvent$Mutation$CreateEventResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewEvent$Mutation extends JsonSerializable with EquatableMixin {
  NewEvent$Mutation();

  factory NewEvent$Mutation.fromJson(Map<String, dynamic> json) =>
      _$NewEvent$MutationFromJson(json);

  late NewEvent$Mutation$CreateEventResponse newEvent;

  @override
  List<Object?> get props => [newEvent];
  @override
  Map<String, dynamic> toJson() => _$NewEvent$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NewEventInput extends JsonSerializable with EquatableMixin {
  NewEventInput(
      {required this.name,
      required this.description,
      required this.eventDate,
      required this.eventPics,
      required this.eventPicsLight,
      required this.eventPlace,
      required this.latitude,
      required this.longitude});

  factory NewEventInput.fromJson(Map<String, dynamic> json) =>
      _$NewEventInputFromJson(json);

  late String name;

  late String description;

  late String eventDate;

  @JsonKey(
      fromJson: fromGraphQLListUploadToDartListMultipartFile,
      toJson: fromDartListMultipartFileToGraphQLListUpload)
  late List<MultipartFile> eventPics;

  @JsonKey(
      fromJson: fromGraphQLListUploadToDartListMultipartFile,
      toJson: fromDartListMultipartFileToGraphQLListUpload)
  late List<MultipartFile> eventPicsLight;

  late String eventPlace;

  late double latitude;

  late double longitude;

  @override
  List<Object?> get props => [
        name,
        description,
        eventDate,
        eventPics,
        eventPicsLight,
        eventPlace,
        latitude,
        longitude
      ];
  @override
  Map<String, dynamic> toJson() => _$NewEventInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LeaveEvent$Mutation extends JsonSerializable with EquatableMixin {
  LeaveEvent$Mutation();

  factory LeaveEvent$Mutation.fromJson(Map<String, dynamic> json) =>
      _$LeaveEvent$MutationFromJson(json);

  bool? leaveEvent;

  @override
  List<Object?> get props => [leaveEvent];
  @override
  Map<String, dynamic> toJson() => _$LeaveEvent$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates
    extends JsonSerializable with EquatableMixin {
  UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates();

  factory UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinatesFromJson(
          json);

  late double latitude;

  late double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinatesToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class UpdateEvent$Mutation$CreateEventResponse$Event extends JsonSerializable
    with EquatableMixin {
  UpdateEvent$Mutation$CreateEventResponse$Event();

  factory UpdateEvent$Mutation$CreateEventResponse$Event.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateEvent$Mutation$CreateEventResponse$EventFromJson(json);

  late int id;

  late String name;

  late String description;

  late List<String> eventPics;

  late List<String> lightEventPics;

  late int confirmedCount;

  late int confirmedHosts;

  late String eventPlace;

  late UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates coords;

  late String createdAt;

  late String updatedAt;

  late String eventDate;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        eventPics,
        lightEventPics,
        confirmedCount,
        confirmedHosts,
        eventPlace,
        coords,
        createdAt,
        updatedAt,
        eventDate
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateEvent$Mutation$CreateEventResponse$EventToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateEvent$Mutation$CreateEventResponse$ErrorResponse
    extends JsonSerializable with EquatableMixin {
  UpdateEvent$Mutation$CreateEventResponse$ErrorResponse();

  factory UpdateEvent$Mutation$CreateEventResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateEvent$Mutation$CreateEventResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateEvent$Mutation$CreateEventResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateEvent$Mutation$CreateEventResponse extends JsonSerializable
    with EquatableMixin {
  UpdateEvent$Mutation$CreateEventResponse();

  factory UpdateEvent$Mutation$CreateEventResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateEvent$Mutation$CreateEventResponseFromJson(json);

  UpdateEvent$Mutation$CreateEventResponse$Event? event;

  List<UpdateEvent$Mutation$CreateEventResponse$ErrorResponse>? errors;

  @override
  List<Object?> get props => [event, errors];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateEvent$Mutation$CreateEventResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateEvent$Mutation extends JsonSerializable with EquatableMixin {
  UpdateEvent$Mutation();

  factory UpdateEvent$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateEvent$MutationFromJson(json);

  late UpdateEvent$Mutation$CreateEventResponse updateEvent;

  @override
  List<Object?> get props => [updateEvent];
  @override
  Map<String, dynamic> toJson() => _$UpdateEvent$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateEventInput extends JsonSerializable with EquatableMixin {
  UpdateEventInput(
      {this.name,
      this.description,
      this.eventDate,
      this.eventPics,
      this.eventPicsLight,
      this.eventPlace,
      this.latitude,
      this.longitude});

  factory UpdateEventInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventInputFromJson(json);

  String? name;

  String? description;

  String? eventDate;

  List<UpdatePictureInput>? eventPics;

  List<UpdatePictureInput>? eventPicsLight;

  String? eventPlace;

  double? latitude;

  double? longitude;

  @override
  List<Object?> get props => [
        name,
        description,
        eventDate,
        eventPics,
        eventPicsLight,
        eventPlace,
        latitude,
        longitude
      ];
  @override
  Map<String, dynamic> toJson() => _$UpdateEventInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdatePictureInput extends JsonSerializable with EquatableMixin {
  UpdatePictureInput({required this.index, this.file, required this.action});

  factory UpdatePictureInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePictureInputFromJson(json);

  late int index;

  @JsonKey(
      fromJson: fromGraphQLUploadNullableToDartMultipartFileNullable,
      toJson: fromDartMultipartFileNullableToGraphQLUploadNullable)
  MultipartFile? file;

  @JsonKey(unknownEnumValue: PictureAction.artemisUnknown)
  late PictureAction action;

  @override
  List<Object?> get props => [index, file, action];
  @override
  Map<String, dynamic> toJson() => _$UpdatePictureInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InviteGuestsAndOrganizers$Mutation extends JsonSerializable
    with EquatableMixin {
  InviteGuestsAndOrganizers$Mutation();

  factory InviteGuestsAndOrganizers$Mutation.fromJson(
          Map<String, dynamic> json) =>
      _$InviteGuestsAndOrganizers$MutationFromJson(json);

  late bool inviteGuestsAndOrganizers;

  @override
  List<Object?> get props => [inviteGuestsAndOrganizers];
  @override
  Map<String, dynamic> toJson() =>
      _$InviteGuestsAndOrganizers$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$SignInResponse$User extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$SignInResponse$User();

  factory SignIn$Mutation$SignInResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$SignInResponse$UserFromJson(json);

  late int id;

  late String name;

  late String username;

  late bool followState;

  late String profilePic;

  @override
  List<Object?> get props => [id, name, username, followState, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$SignInResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$SignInResponse extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$SignInResponse();

  factory SignIn$Mutation$SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignIn$Mutation$SignInResponseFromJson(json);

  SignIn$Mutation$SignInResponse$User? user;

  bool? isNew;

  @override
  List<Object?> get props => [user, isNew];
  @override
  Map<String, dynamic> toJson() => _$SignIn$Mutation$SignInResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation extends JsonSerializable with EquatableMixin {
  SignIn$Mutation();

  factory SignIn$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SignIn$MutationFromJson(json);

  late SignIn$Mutation$SignInResponse signIn;

  @override
  List<Object?> get props => [signIn];
  @override
  Map<String, dynamic> toJson() => _$SignIn$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignInInput extends JsonSerializable with EquatableMixin {
  SignInInput({required this.token, required this.provider, this.appleData});

  factory SignInInput.fromJson(Map<String, dynamic> json) =>
      _$SignInInputFromJson(json);

  late String token;

  @JsonKey(unknownEnumValue: SignInProvider.artemisUnknown)
  late SignInProvider provider;

  AppleData? appleData;

  @override
  List<Object?> get props => [token, provider, appleData];
  @override
  Map<String, dynamic> toJson() => _$SignInInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AppleData extends JsonSerializable with EquatableMixin {
  AppleData({required this.name, required this.authorizationCode});

  factory AppleData.fromJson(Map<String, dynamic> json) =>
      _$AppleDataFromJson(json);

  late String name;

  late String authorizationCode;

  @override
  List<Object?> get props => [name, authorizationCode];
  @override
  Map<String, dynamic> toJson() => _$AppleDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AcceptInvitation$Mutation$AcceptInvitationResponse
    extends JsonSerializable with EquatableMixin {
  AcceptInvitation$Mutation$AcceptInvitationResponse();

  factory AcceptInvitation$Mutation$AcceptInvitationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AcceptInvitation$Mutation$AcceptInvitationResponseFromJson(json);

  String? cypherText;

  late bool isHost;

  @override
  List<Object?> get props => [cypherText, isHost];
  @override
  Map<String, dynamic> toJson() =>
      _$AcceptInvitation$Mutation$AcceptInvitationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AcceptInvitation$Mutation extends JsonSerializable with EquatableMixin {
  AcceptInvitation$Mutation();

  factory AcceptInvitation$Mutation.fromJson(Map<String, dynamic> json) =>
      _$AcceptInvitation$MutationFromJson(json);

  late AcceptInvitation$Mutation$AcceptInvitationResponse acceptInvitation;

  @override
  List<Object?> get props => [acceptInvitation];
  @override
  Map<String, dynamic> toJson() => _$AcceptInvitation$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteEvent$Mutation extends JsonSerializable with EquatableMixin {
  DeleteEvent$Mutation();

  factory DeleteEvent$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteEvent$MutationFromJson(json);

  bool? deleteEvent;

  @override
  List<Object?> get props => [deleteEvent];
  @override
  Map<String, dynamic> toJson() => _$DeleteEvent$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddGuests$Mutation extends JsonSerializable with EquatableMixin {
  AddGuests$Mutation();

  factory AddGuests$Mutation.fromJson(Map<String, dynamic> json) =>
      _$AddGuests$MutationFromJson(json);

  bool? addGuests;

  @override
  List<Object?> get props => [addGuests];
  @override
  Map<String, dynamic> toJson() => _$AddGuests$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RemoveGuests$Mutation extends JsonSerializable with EquatableMixin {
  RemoveGuests$Mutation();

  factory RemoveGuests$Mutation.fromJson(Map<String, dynamic> json) =>
      _$RemoveGuests$MutationFromJson(json);

  bool? removeGuests;

  @override
  List<Object?> get props => [removeGuests];
  @override
  Map<String, dynamic> toJson() => _$RemoveGuests$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFromId$Query$User extends JsonSerializable with EquatableMixin {
  UserFromId$Query$User();

  factory UserFromId$Query$User.fromJson(Map<String, dynamic> json) =>
      _$UserFromId$Query$UserFromJson(json);

  late int id;

  late String name;

  late String username;

  late bool followState;

  late String profilePic;

  @override
  List<Object?> get props => [id, name, username, followState, profilePic];
  @override
  Map<String, dynamic> toJson() => _$UserFromId$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserFromId$Query extends JsonSerializable with EquatableMixin {
  UserFromId$Query();

  factory UserFromId$Query.fromJson(Map<String, dynamic> json) =>
      _$UserFromId$QueryFromJson(json);

  UserFromId$Query$User? userFromId;

  @override
  List<Object?> get props => [userFromId];
  @override
  Map<String, dynamic> toJson() => _$UserFromId$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserAccess$Query$User extends JsonSerializable with EquatableMixin {
  UserAccess$Query$User();

  factory UserAccess$Query$User.fromJson(Map<String, dynamic> json) =>
      _$UserAccess$Query$UserFromJson(json);

  late int id;

  late String name;

  late String username;

  late bool followState;

  late String profilePic;

  @override
  List<Object?> get props => [id, name, username, followState, profilePic];
  @override
  Map<String, dynamic> toJson() => _$UserAccess$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserAccess$Query extends JsonSerializable with EquatableMixin {
  UserAccess$Query();

  factory UserAccess$Query.fromJson(Map<String, dynamic> json) =>
      _$UserAccess$QueryFromJson(json);

  UserAccess$Query$User? userAccess;

  @override
  List<Object?> get props => [userAccess];
  @override
  Map<String, dynamic> toJson() => _$UserAccess$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeePass$Query extends JsonSerializable with EquatableMixin {
  SeePass$Query();

  factory SeePass$Query.fromJson(Map<String, dynamic> json) =>
      _$SeePass$QueryFromJson(json);

  String? seePass;

  @override
  List<Object?> get props => [seePass];
  @override
  Map<String, dynamic> toJson() => _$SeePass$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesFromJson(
          json);

  late double latitude;

  late double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$EventFromJson(
          json);

  late int id;

  late String name;

  late String description;

  late List<String> eventPics;

  late List<String> lightEventPics;

  late int confirmedCount;

  late int confirmedHosts;

  late String eventPlace;

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
      coords;

  late String createdAt;

  late String updatedAt;

  late String eventDate;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        eventPics,
        lightEventPics,
        confirmedCount,
        confirmedHosts,
        eventPlace,
        coords,
        createdAt,
        updatedAt,
        eventDate
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$EventToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$UserFromJson(
          json);

  late int id;

  late String username;

  late String name;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoFromJson(
          json);

  late bool isConfirmed;

  late bool isHost;

  late bool isCreator;

  @override
  List<Object?> get props => [isConfirmed, isHost, isCreator];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$FriendsFromJson(
          json);

  late int id;

  late String name;

  late String username;

  late String profilePic;

  @override
  List<Object?> get props => [id, name, username, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$FriendsToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteResFromJson(
          json);

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event
      event;

  late int invitedByUserId;

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User
      invitedBy;

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
      invitedUserInfo;

  late List<
          GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends>
      friends;

  @override
  List<Object?> get props =>
      [event, invitedByUserId, invitedBy, invitedUserInfo, friends];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteResToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query$PaginatedEventResults
    extends JsonSerializable with EquatableMixin {
  GetUserEventsFromFriends$Query$PaginatedEventResults();

  factory GetUserEventsFromFriends$Query$PaginatedEventResults.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResultsFromJson(json);

  late List<GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes>
      events;

  late bool hasMore;

  @override
  List<Object?> get props => [events, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriends$Query$PaginatedEventResultsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriends$Query extends JsonSerializable
    with EquatableMixin {
  GetUserEventsFromFriends$Query();

  factory GetUserEventsFromFriends$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUserEventsFromFriends$QueryFromJson(json);

  late GetUserEventsFromFriends$Query$PaginatedEventResults
      getUserEventsFromFriends;

  @override
  List<Object?> get props => [getUserEventsFromFriends];
  @override
  Map<String, dynamic> toJson() => _$GetUserEventsFromFriends$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
    extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates();

  factory GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesFromJson(
          json);

  late double latitude;

  late double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event
    extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event();

  factory GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$EventFromJson(
          json);

  late int id;

  late String name;

  late String description;

  late List<String> eventPics;

  late List<String> lightEventPics;

  late int confirmedCount;

  late int confirmedHosts;

  late String eventPlace;

  late GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
      coords;

  late String createdAt;

  late String updatedAt;

  late String eventDate;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        eventPics,
        lightEventPics,
        confirmedCount,
        confirmedHosts,
        eventPlace,
        coords,
        createdAt,
        updatedAt,
        eventDate
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$EventToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User
    extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User();

  factory GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$UserFromJson(
          json);

  late int id;

  late String username;

  late String name;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
    extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo();

  factory GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoFromJson(
          json);

  late bool isConfirmed;

  late bool isHost;

  late bool isCreator;

  @override
  List<Object?> get props => [isConfirmed, isHost, isCreator];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends
    extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends();

  factory GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$FriendsFromJson(
          json);

  late int id;

  late String name;

  late String username;

  late String profilePic;

  @override
  List<Object?> get props => [id, name, username, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$FriendsToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults$EventInviteRes
    extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults$EventInviteRes();

  factory GetUserEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteResFromJson(json);

  late GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event event;

  late int invitedByUserId;

  late GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User invitedBy;

  late GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
      invitedUserInfo;

  late List<GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends>
      friends;

  @override
  List<Object?> get props =>
      [event, invitedByUserId, invitedBy, invitedUserInfo, friends];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResults$EventInviteResToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query$PaginatedEventResults extends JsonSerializable
    with EquatableMixin {
  GetUserEvents$Query$PaginatedEventResults();

  factory GetUserEvents$Query$PaginatedEventResults.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEvents$Query$PaginatedEventResultsFromJson(json);

  late List<GetUserEvents$Query$PaginatedEventResults$EventInviteRes> events;

  late bool hasMore;

  @override
  List<Object?> get props => [events, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEvents$Query$PaginatedEventResultsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserEvents$Query extends JsonSerializable with EquatableMixin {
  GetUserEvents$Query();

  factory GetUserEvents$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUserEvents$QueryFromJson(json);

  late GetUserEvents$Query$PaginatedEventResults getUserEvents;

  @override
  List<Object?> get props => [getUserEvents];
  @override
  Map<String, dynamic> toJson() => _$GetUserEvents$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetEventHosts$Query$PaginatedEventUsersResults$User
    extends JsonSerializable with EquatableMixin {
  GetEventHosts$Query$PaginatedEventUsersResults$User();

  factory GetEventHosts$Query$PaginatedEventUsersResults$User.fromJson(
          Map<String, dynamic> json) =>
      _$GetEventHosts$Query$PaginatedEventUsersResults$UserFromJson(json);

  late int id;

  late String username;

  late String name;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetEventHosts$Query$PaginatedEventUsersResults$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetEventHosts$Query$PaginatedEventUsersResults extends JsonSerializable
    with EquatableMixin {
  GetEventHosts$Query$PaginatedEventUsersResults();

  factory GetEventHosts$Query$PaginatedEventUsersResults.fromJson(
          Map<String, dynamic> json) =>
      _$GetEventHosts$Query$PaginatedEventUsersResultsFromJson(json);

  late List<GetEventHosts$Query$PaginatedEventUsersResults$User> users;

  late bool hasMore;

  @override
  List<Object?> get props => [users, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$GetEventHosts$Query$PaginatedEventUsersResultsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetEventHosts$Query extends JsonSerializable with EquatableMixin {
  GetEventHosts$Query();

  factory GetEventHosts$Query.fromJson(Map<String, dynamic> json) =>
      _$GetEventHosts$QueryFromJson(json);

  late GetEventHosts$Query$PaginatedEventUsersResults getEventHosts;

  @override
  List<Object?> get props => [getEventHosts];
  @override
  Map<String, dynamic> toJson() => _$GetEventHosts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchForUsersToAddAsGuests$Query$User extends JsonSerializable
    with EquatableMixin {
  SearchForUsersToAddAsGuests$Query$User();

  factory SearchForUsersToAddAsGuests$Query$User.fromJson(
          Map<String, dynamic> json) =>
      _$SearchForUsersToAddAsGuests$Query$UserFromJson(json);

  late int id;

  late String username;

  late String name;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchForUsersToAddAsGuests$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchForUsersToAddAsGuests$Query extends JsonSerializable
    with EquatableMixin {
  SearchForUsersToAddAsGuests$Query();

  factory SearchForUsersToAddAsGuests$Query.fromJson(
          Map<String, dynamic> json) =>
      _$SearchForUsersToAddAsGuests$QueryFromJson(json);

  late List<SearchForUsersToAddAsGuests$Query$User> searchForUsersToAddAsGuests;

  @override
  List<Object?> get props => [searchForUsersToAddAsGuests];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchForUsersToAddAsGuests$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
    extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates();

  factory GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesFromJson(
          json);

  late double latitude;

  late double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event
    extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event();

  factory GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$EventFromJson(
          json);

  late int id;

  late String name;

  late String description;

  late List<String> eventPics;

  late List<String> lightEventPics;

  late int confirmedCount;

  late int confirmedHosts;

  late String eventPlace;

  late GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
      coords;

  late String createdAt;

  late String updatedAt;

  late String eventDate;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        eventPics,
        lightEventPics,
        confirmedCount,
        confirmedHosts,
        eventPlace,
        coords,
        createdAt,
        updatedAt,
        eventDate
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$EventToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User
    extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User();

  factory GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$UserFromJson(
          json);

  late int id;

  late String username;

  late String name;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$UserToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
    extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo();

  factory GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoFromJson(
          json);

  late bool isConfirmed;

  late bool isHost;

  late bool isCreator;

  @override
  List<Object?> get props => [isConfirmed, isHost, isCreator];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends
    extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends();

  factory GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$FriendsFromJson(
          json);

  late int id;

  late String name;

  late String username;

  late String profilePic;

  @override
  List<Object?> get props => [id, name, username, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$FriendsToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes
    extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes();

  factory GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteResFromJson(
          json);

  late GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event
      event;

  late int invitedByUserId;

  late GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User
      invitedBy;

  late GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
      invitedUserInfo;

  late List<
          GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends>
      friends;

  @override
  List<Object?> get props =>
      [event, invitedByUserId, invitedBy, invitedUserInfo, friends];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteResToJson(
          this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query$PaginatedEventResults extends JsonSerializable
    with EquatableMixin {
  GetUserOtherEvents$Query$PaginatedEventResults();

  factory GetUserOtherEvents$Query$PaginatedEventResults.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserOtherEvents$Query$PaginatedEventResultsFromJson(json);

  late List<GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes>
      events;

  late bool hasMore;

  @override
  List<Object?> get props => [events, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserOtherEvents$Query$PaginatedEventResultsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEvents$Query extends JsonSerializable with EquatableMixin {
  GetUserOtherEvents$Query();

  factory GetUserOtherEvents$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUserOtherEvents$QueryFromJson(json);

  late GetUserOtherEvents$Query$PaginatedEventResults getUserOtherEvents;

  @override
  List<Object?> get props => [getUserOtherEvents];
  @override
  Map<String, dynamic> toJson() => _$GetUserOtherEvents$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchUsers$Query$User extends JsonSerializable with EquatableMixin {
  SearchUsers$Query$User();

  factory SearchUsers$Query$User.fromJson(Map<String, dynamic> json) =>
      _$SearchUsers$Query$UserFromJson(json);

  late int id;

  late String username;

  late String name;

  late bool followState;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, followState, profilePic];
  @override
  Map<String, dynamic> toJson() => _$SearchUsers$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchUsers$Query extends JsonSerializable with EquatableMixin {
  SearchUsers$Query();

  factory SearchUsers$Query.fromJson(Map<String, dynamic> json) =>
      _$SearchUsers$QueryFromJson(json);

  late List<SearchUsers$Query$User> searchUsers;

  @override
  List<Object?> get props => [searchUsers];
  @override
  Map<String, dynamic> toJson() => _$SearchUsers$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetEventGuests$Query$PaginatedEventUsersResults$User
    extends JsonSerializable with EquatableMixin {
  GetEventGuests$Query$PaginatedEventUsersResults$User();

  factory GetEventGuests$Query$PaginatedEventUsersResults$User.fromJson(
          Map<String, dynamic> json) =>
      _$GetEventGuests$Query$PaginatedEventUsersResults$UserFromJson(json);

  late int id;

  late String username;

  late String name;

  late String profilePic;

  @override
  List<Object?> get props => [id, username, name, profilePic];
  @override
  Map<String, dynamic> toJson() =>
      _$GetEventGuests$Query$PaginatedEventUsersResults$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetEventGuests$Query$PaginatedEventUsersResults extends JsonSerializable
    with EquatableMixin {
  GetEventGuests$Query$PaginatedEventUsersResults();

  factory GetEventGuests$Query$PaginatedEventUsersResults.fromJson(
          Map<String, dynamic> json) =>
      _$GetEventGuests$Query$PaginatedEventUsersResultsFromJson(json);

  late List<GetEventGuests$Query$PaginatedEventUsersResults$User> users;

  late bool hasMore;

  @override
  List<Object?> get props => [users, hasMore];
  @override
  Map<String, dynamic> toJson() =>
      _$GetEventGuests$Query$PaginatedEventUsersResultsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetEventGuests$Query extends JsonSerializable with EquatableMixin {
  GetEventGuests$Query();

  factory GetEventGuests$Query.fromJson(Map<String, dynamic> json) =>
      _$GetEventGuests$QueryFromJson(json);

  late GetEventGuests$Query$PaginatedEventUsersResults getEventGuests;

  @override
  List<Object?> get props => [getEventGuests];
  @override
  Map<String, dynamic> toJson() => _$GetEventGuests$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SaveDevice$Mutation extends JsonSerializable with EquatableMixin {
  SaveDevice$Mutation();

  factory SaveDevice$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SaveDevice$MutationFromJson(json);

  bool? saveDevice;

  @override
  List<Object?> get props => [saveDevice];
  @override
  Map<String, dynamic> toJson() => _$SaveDevice$MutationToJson(this);
}

enum PictureAction {
  @JsonValue('ADD')
  add,
  @JsonValue('REPLACE')
  replace,
  @JsonValue('DELETE')
  delete,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

enum SignInProvider {
  @JsonValue('APPLE')
  apple,
  @JsonValue('GOOGLE')
  google,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

@JsonSerializable(explicitToJson: true)
class AddOrRemoveUserArguments extends JsonSerializable with EquatableMixin {
  AddOrRemoveUserArguments(
      {required this.followUserId, required this.isFollow});

  @override
  factory AddOrRemoveUserArguments.fromJson(Map<String, dynamic> json) =>
      _$AddOrRemoveUserArgumentsFromJson(json);

  late int followUserId;

  late bool isFollow;

  @override
  List<Object?> get props => [followUserId, isFollow];
  @override
  Map<String, dynamic> toJson() => _$AddOrRemoveUserArgumentsToJson(this);
}

final ADD_OR_REMOVE_USER_MUTATION_DOCUMENT_OPERATION_NAME = 'AddOrRemoveUser';
final ADD_OR_REMOVE_USER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddOrRemoveUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'followUserId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'isFollow')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'addOrRemoveUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'followUserId'),
                  value: VariableNode(name: NameNode(value: 'followUserId'))),
              ArgumentNode(
                  name: NameNode(value: 'isFollow'),
                  value: VariableNode(name: NameNode(value: 'isFollow')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'value'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'unchanged'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class AddOrRemoveUserMutation
    extends GraphQLQuery<AddOrRemoveUser$Mutation, AddOrRemoveUserArguments> {
  AddOrRemoveUserMutation({required this.variables});

  @override
  final DocumentNode document = ADD_OR_REMOVE_USER_MUTATION_DOCUMENT;

  @override
  final String operationName =
      ADD_OR_REMOVE_USER_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final AddOrRemoveUserArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  AddOrRemoveUser$Mutation parse(Map<String, dynamic> json) =>
      AddOrRemoveUser$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class NewEventArguments extends JsonSerializable with EquatableMixin {
  NewEventArguments({required this.input});

  @override
  factory NewEventArguments.fromJson(Map<String, dynamic> json) =>
      _$NewEventArgumentsFromJson(json);

  late NewEventInput input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$NewEventArgumentsToJson(this);
}

final NEW_EVENT_MUTATION_DOCUMENT_OPERATION_NAME = 'NewEvent';
final NEW_EVENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'NewEvent'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'NewEventInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'newEvent'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'event'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'confirmedCount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'eventPics'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'eventDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'coords'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'latitude'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'longitude'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'updatedAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class NewEventMutation
    extends GraphQLQuery<NewEvent$Mutation, NewEventArguments> {
  NewEventMutation({required this.variables});

  @override
  final DocumentNode document = NEW_EVENT_MUTATION_DOCUMENT;

  @override
  final String operationName = NEW_EVENT_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final NewEventArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  NewEvent$Mutation parse(Map<String, dynamic> json) =>
      NewEvent$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LeaveEventArguments extends JsonSerializable with EquatableMixin {
  LeaveEventArguments({required this.eventId});

  @override
  factory LeaveEventArguments.fromJson(Map<String, dynamic> json) =>
      _$LeaveEventArgumentsFromJson(json);

  late int eventId;

  @override
  List<Object?> get props => [eventId];
  @override
  Map<String, dynamic> toJson() => _$LeaveEventArgumentsToJson(this);
}

final LEAVE_EVENT_MUTATION_DOCUMENT_OPERATION_NAME = 'LeaveEvent';
final LEAVE_EVENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'LeaveEvent'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'leaveEvent'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class LeaveEventMutation
    extends GraphQLQuery<LeaveEvent$Mutation, LeaveEventArguments> {
  LeaveEventMutation({required this.variables});

  @override
  final DocumentNode document = LEAVE_EVENT_MUTATION_DOCUMENT;

  @override
  final String operationName = LEAVE_EVENT_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final LeaveEventArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  LeaveEvent$Mutation parse(Map<String, dynamic> json) =>
      LeaveEvent$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateEventArguments extends JsonSerializable with EquatableMixin {
  UpdateEventArguments({required this.input, required this.eventId});

  @override
  factory UpdateEventArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventArgumentsFromJson(json);

  late UpdateEventInput input;

  late int eventId;

  @override
  List<Object?> get props => [input, eventId];
  @override
  Map<String, dynamic> toJson() => _$UpdateEventArgumentsToJson(this);
}

final UPDATE_EVENT_MUTATION_DOCUMENT_OPERATION_NAME = 'UpdateEvent';
final UPDATE_EVENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateEvent'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'UpdateEventInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateEvent'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input'))),
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'event'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'eventPics'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'lightEventPics'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'confirmedCount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'confirmedHosts'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'eventPlace'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'coords'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'latitude'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'longitude'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'createdAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'updatedAt'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'eventDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class UpdateEventMutation
    extends GraphQLQuery<UpdateEvent$Mutation, UpdateEventArguments> {
  UpdateEventMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_EVENT_MUTATION_DOCUMENT;

  @override
  final String operationName = UPDATE_EVENT_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final UpdateEventArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateEvent$Mutation parse(Map<String, dynamic> json) =>
      UpdateEvent$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class InviteGuestsAndOrganizersArguments extends JsonSerializable
    with EquatableMixin {
  InviteGuestsAndOrganizersArguments(
      {required this.guests, required this.organizers, required this.eventId});

  @override
  factory InviteGuestsAndOrganizersArguments.fromJson(
          Map<String, dynamic> json) =>
      _$InviteGuestsAndOrganizersArgumentsFromJson(json);

  late List<int> guests;

  late List<int> organizers;

  late int eventId;

  @override
  List<Object?> get props => [guests, organizers, eventId];
  @override
  Map<String, dynamic> toJson() =>
      _$InviteGuestsAndOrganizersArgumentsToJson(this);
}

final INVITE_GUESTS_AND_ORGANIZERS_MUTATION_DOCUMENT_OPERATION_NAME =
    'InviteGuestsAndOrganizers';
final INVITE_GUESTS_AND_ORGANIZERS_MUTATION_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InviteGuestsAndOrganizers'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'guests')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'organizers')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'inviteGuestsAndOrganizers'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'guests'),
                  value: VariableNode(name: NameNode(value: 'guests'))),
              ArgumentNode(
                  name: NameNode(value: 'organizers'),
                  value: VariableNode(name: NameNode(value: 'organizers'))),
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class InviteGuestsAndOrganizersMutation extends GraphQLQuery<
    InviteGuestsAndOrganizers$Mutation, InviteGuestsAndOrganizersArguments> {
  InviteGuestsAndOrganizersMutation({required this.variables});

  @override
  final DocumentNode document = INVITE_GUESTS_AND_ORGANIZERS_MUTATION_DOCUMENT;

  @override
  final String operationName =
      INVITE_GUESTS_AND_ORGANIZERS_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final InviteGuestsAndOrganizersArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  InviteGuestsAndOrganizers$Mutation parse(Map<String, dynamic> json) =>
      InviteGuestsAndOrganizers$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SignInArguments extends JsonSerializable with EquatableMixin {
  SignInArguments({required this.input});

  @override
  factory SignInArguments.fromJson(Map<String, dynamic> json) =>
      _$SignInArgumentsFromJson(json);

  late SignInInput input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$SignInArgumentsToJson(this);
}

final SIGN_IN_MUTATION_DOCUMENT_OPERATION_NAME = 'SignIn';
final SIGN_IN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SignIn'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'SignInInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'signIn'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'followState'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'profilePic'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'isNew'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class SignInMutation extends GraphQLQuery<SignIn$Mutation, SignInArguments> {
  SignInMutation({required this.variables});

  @override
  final DocumentNode document = SIGN_IN_MUTATION_DOCUMENT;

  @override
  final String operationName = SIGN_IN_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final SignInArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SignIn$Mutation parse(Map<String, dynamic> json) =>
      SignIn$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class AcceptInvitationArguments extends JsonSerializable with EquatableMixin {
  AcceptInvitationArguments({required this.eventId});

  @override
  factory AcceptInvitationArguments.fromJson(Map<String, dynamic> json) =>
      _$AcceptInvitationArgumentsFromJson(json);

  late int eventId;

  @override
  List<Object?> get props => [eventId];
  @override
  Map<String, dynamic> toJson() => _$AcceptInvitationArgumentsToJson(this);
}

final ACCEPT_INVITATION_MUTATION_DOCUMENT_OPERATION_NAME = 'AcceptInvitation';
final ACCEPT_INVITATION_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AcceptInvitation'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'acceptInvitation'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'cypherText'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'isHost'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class AcceptInvitationMutation
    extends GraphQLQuery<AcceptInvitation$Mutation, AcceptInvitationArguments> {
  AcceptInvitationMutation({required this.variables});

  @override
  final DocumentNode document = ACCEPT_INVITATION_MUTATION_DOCUMENT;

  @override
  final String operationName =
      ACCEPT_INVITATION_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final AcceptInvitationArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  AcceptInvitation$Mutation parse(Map<String, dynamic> json) =>
      AcceptInvitation$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteEventArguments extends JsonSerializable with EquatableMixin {
  DeleteEventArguments({required this.eventId});

  @override
  factory DeleteEventArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteEventArgumentsFromJson(json);

  late int eventId;

  @override
  List<Object?> get props => [eventId];
  @override
  Map<String, dynamic> toJson() => _$DeleteEventArgumentsToJson(this);
}

final DELETE_EVENT_MUTATION_DOCUMENT_OPERATION_NAME = 'DeleteEvent';
final DELETE_EVENT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteEvent'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteEvent'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class DeleteEventMutation
    extends GraphQLQuery<DeleteEvent$Mutation, DeleteEventArguments> {
  DeleteEventMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_EVENT_MUTATION_DOCUMENT;

  @override
  final String operationName = DELETE_EVENT_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final DeleteEventArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteEvent$Mutation parse(Map<String, dynamic> json) =>
      DeleteEvent$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class AddGuestsArguments extends JsonSerializable with EquatableMixin {
  AddGuestsArguments({required this.eventId, required this.userIds});

  @override
  factory AddGuestsArguments.fromJson(Map<String, dynamic> json) =>
      _$AddGuestsArgumentsFromJson(json);

  late int eventId;

  late List<int> userIds;

  @override
  List<Object?> get props => [eventId, userIds];
  @override
  Map<String, dynamic> toJson() => _$AddGuestsArgumentsToJson(this);
}

final ADD_GUESTS_MUTATION_DOCUMENT_OPERATION_NAME = 'AddGuests';
final ADD_GUESTS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddGuests'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userIds')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'addGuests'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId'))),
              ArgumentNode(
                  name: NameNode(value: 'userIds'),
                  value: VariableNode(name: NameNode(value: 'userIds')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class AddGuestsMutation
    extends GraphQLQuery<AddGuests$Mutation, AddGuestsArguments> {
  AddGuestsMutation({required this.variables});

  @override
  final DocumentNode document = ADD_GUESTS_MUTATION_DOCUMENT;

  @override
  final String operationName = ADD_GUESTS_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final AddGuestsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  AddGuests$Mutation parse(Map<String, dynamic> json) =>
      AddGuests$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RemoveGuestsArguments extends JsonSerializable with EquatableMixin {
  RemoveGuestsArguments({required this.eventId, required this.userIds});

  @override
  factory RemoveGuestsArguments.fromJson(Map<String, dynamic> json) =>
      _$RemoveGuestsArgumentsFromJson(json);

  late int eventId;

  late List<int> userIds;

  @override
  List<Object?> get props => [eventId, userIds];
  @override
  Map<String, dynamic> toJson() => _$RemoveGuestsArgumentsToJson(this);
}

final REMOVE_GUESTS_MUTATION_DOCUMENT_OPERATION_NAME = 'RemoveGuests';
final REMOVE_GUESTS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RemoveGuests'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userIds')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'removeGuests'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId'))),
              ArgumentNode(
                  name: NameNode(value: 'userIds'),
                  value: VariableNode(name: NameNode(value: 'userIds')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class RemoveGuestsMutation
    extends GraphQLQuery<RemoveGuests$Mutation, RemoveGuestsArguments> {
  RemoveGuestsMutation({required this.variables});

  @override
  final DocumentNode document = REMOVE_GUESTS_MUTATION_DOCUMENT;

  @override
  final String operationName = REMOVE_GUESTS_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final RemoveGuestsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  RemoveGuests$Mutation parse(Map<String, dynamic> json) =>
      RemoveGuests$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserFromIdArguments extends JsonSerializable with EquatableMixin {
  UserFromIdArguments({required this.id});

  @override
  factory UserFromIdArguments.fromJson(Map<String, dynamic> json) =>
      _$UserFromIdArgumentsFromJson(json);

  late int id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$UserFromIdArgumentsToJson(this);
}

final USER_FROM_ID_QUERY_DOCUMENT_OPERATION_NAME = 'UserFromId';
final USER_FROM_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'UserFromId'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userFromId'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followState'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'profilePic'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class UserFromIdQuery
    extends GraphQLQuery<UserFromId$Query, UserFromIdArguments> {
  UserFromIdQuery({required this.variables});

  @override
  final DocumentNode document = USER_FROM_ID_QUERY_DOCUMENT;

  @override
  final String operationName = USER_FROM_ID_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final UserFromIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UserFromId$Query parse(Map<String, dynamic> json) =>
      UserFromId$Query.fromJson(json);
}

final USER_ACCESS_QUERY_DOCUMENT_OPERATION_NAME = 'UserAccess';
final USER_ACCESS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'UserAccess'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userAccess'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followState'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'profilePic'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class UserAccessQuery extends GraphQLQuery<UserAccess$Query, JsonSerializable> {
  UserAccessQuery();

  @override
  final DocumentNode document = USER_ACCESS_QUERY_DOCUMENT;

  @override
  final String operationName = USER_ACCESS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserAccess$Query parse(Map<String, dynamic> json) =>
      UserAccess$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SeePassArguments extends JsonSerializable with EquatableMixin {
  SeePassArguments({required this.eventId});

  @override
  factory SeePassArguments.fromJson(Map<String, dynamic> json) =>
      _$SeePassArgumentsFromJson(json);

  late int eventId;

  @override
  List<Object?> get props => [eventId];
  @override
  Map<String, dynamic> toJson() => _$SeePassArgumentsToJson(this);
}

final SEE_PASS_QUERY_DOCUMENT_OPERATION_NAME = 'SeePass';
final SEE_PASS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SeePass'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'seePass'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class SeePassQuery extends GraphQLQuery<SeePass$Query, SeePassArguments> {
  SeePassQuery({required this.variables});

  @override
  final DocumentNode document = SEE_PASS_QUERY_DOCUMENT;

  @override
  final String operationName = SEE_PASS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final SeePassArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SeePass$Query parse(Map<String, dynamic> json) =>
      SeePass$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsFromFriendsArguments extends JsonSerializable
    with EquatableMixin {
  GetUserEventsFromFriendsArguments(
      {required this.limit, required this.idsList});

  @override
  factory GetUserEventsFromFriendsArguments.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserEventsFromFriendsArgumentsFromJson(json);

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [limit, idsList];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserEventsFromFriendsArgumentsToJson(this);
}

final GET_USER_EVENTS_FROM_FRIENDS_QUERY_DOCUMENT_OPERATION_NAME =
    'GetUserEventsFromFriends';
final GET_USER_EVENTS_FROM_FRIENDS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetUserEventsFromFriends'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getUserEventsFromFriends'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'events'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'event'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'description'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventPics'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'lightEventPics'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'confirmedCount'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'confirmedHosts'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventPlace'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'coords'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'latitude'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'longitude'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null)
                              ])),
                          FieldNode(
                              name: NameNode(value: 'createdAt'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'updatedAt'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventDate'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'invitedByUserId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'invitedBy'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'username'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'profilePic'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'invitedUserInfo'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'isConfirmed'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'isHost'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'isCreator'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'friends'),
                        alias: NameNode(value: 'friends'),
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'username'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'profilePic'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class GetUserEventsFromFriendsQuery extends GraphQLQuery<
    GetUserEventsFromFriends$Query, GetUserEventsFromFriendsArguments> {
  GetUserEventsFromFriendsQuery({required this.variables});

  @override
  final DocumentNode document = GET_USER_EVENTS_FROM_FRIENDS_QUERY_DOCUMENT;

  @override
  final String operationName =
      GET_USER_EVENTS_FROM_FRIENDS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetUserEventsFromFriendsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetUserEventsFromFriends$Query parse(Map<String, dynamic> json) =>
      GetUserEventsFromFriends$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetUserEventsArguments extends JsonSerializable with EquatableMixin {
  GetUserEventsArguments({required this.limit, required this.idsList});

  @override
  factory GetUserEventsArguments.fromJson(Map<String, dynamic> json) =>
      _$GetUserEventsArgumentsFromJson(json);

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$GetUserEventsArgumentsToJson(this);
}

final GET_USER_EVENTS_QUERY_DOCUMENT_OPERATION_NAME = 'GetUserEvents';
final GET_USER_EVENTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetUserEvents'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getUserEvents'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'events'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'event'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'description'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventPics'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'lightEventPics'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'confirmedCount'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'confirmedHosts'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventPlace'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'coords'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'latitude'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'longitude'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null)
                              ])),
                          FieldNode(
                              name: NameNode(value: 'createdAt'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'updatedAt'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventDate'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'invitedByUserId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'invitedBy'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'username'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'profilePic'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'invitedUserInfo'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'isConfirmed'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'isHost'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'isCreator'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'friends'),
                        alias: NameNode(value: 'friends'),
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'username'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'profilePic'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class GetUserEventsQuery
    extends GraphQLQuery<GetUserEvents$Query, GetUserEventsArguments> {
  GetUserEventsQuery({required this.variables});

  @override
  final DocumentNode document = GET_USER_EVENTS_QUERY_DOCUMENT;

  @override
  final String operationName = GET_USER_EVENTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetUserEventsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetUserEvents$Query parse(Map<String, dynamic> json) =>
      GetUserEvents$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetEventHostsArguments extends JsonSerializable with EquatableMixin {
  GetEventHostsArguments(
      {required this.eventId, required this.limit, required this.idsList});

  @override
  factory GetEventHostsArguments.fromJson(Map<String, dynamic> json) =>
      _$GetEventHostsArgumentsFromJson(json);

  late int eventId;

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [eventId, limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$GetEventHostsArgumentsToJson(this);
}

final GET_EVENT_HOSTS_QUERY_DOCUMENT_OPERATION_NAME = 'GetEventHosts';
final GET_EVENT_HOSTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetEventHosts'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getEventHosts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'users'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'profilePic'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class GetEventHostsQuery
    extends GraphQLQuery<GetEventHosts$Query, GetEventHostsArguments> {
  GetEventHostsQuery({required this.variables});

  @override
  final DocumentNode document = GET_EVENT_HOSTS_QUERY_DOCUMENT;

  @override
  final String operationName = GET_EVENT_HOSTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetEventHostsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetEventHosts$Query parse(Map<String, dynamic> json) =>
      GetEventHosts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SearchForUsersToAddAsGuestsArguments extends JsonSerializable
    with EquatableMixin {
  SearchForUsersToAddAsGuestsArguments(
      {required this.search, required this.eventId});

  @override
  factory SearchForUsersToAddAsGuestsArguments.fromJson(
          Map<String, dynamic> json) =>
      _$SearchForUsersToAddAsGuestsArgumentsFromJson(json);

  late String search;

  late int eventId;

  @override
  List<Object?> get props => [search, eventId];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchForUsersToAddAsGuestsArgumentsToJson(this);
}

final SEARCH_FOR_USERS_TO_ADD_AS_GUESTS_QUERY_DOCUMENT_OPERATION_NAME =
    'SearchForUsersToAddAsGuests';
final SEARCH_FOR_USERS_TO_ADD_AS_GUESTS_QUERY_DOCUMENT =
    DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SearchForUsersToAddAsGuests'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'search')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'searchForUsersToAddAsGuests'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'search'),
                  value: VariableNode(name: NameNode(value: 'search'))),
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'profilePic'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class SearchForUsersToAddAsGuestsQuery extends GraphQLQuery<
    SearchForUsersToAddAsGuests$Query, SearchForUsersToAddAsGuestsArguments> {
  SearchForUsersToAddAsGuestsQuery({required this.variables});

  @override
  final DocumentNode document =
      SEARCH_FOR_USERS_TO_ADD_AS_GUESTS_QUERY_DOCUMENT;

  @override
  final String operationName =
      SEARCH_FOR_USERS_TO_ADD_AS_GUESTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final SearchForUsersToAddAsGuestsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SearchForUsersToAddAsGuests$Query parse(Map<String, dynamic> json) =>
      SearchForUsersToAddAsGuests$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetUserOtherEventsArguments extends JsonSerializable with EquatableMixin {
  GetUserOtherEventsArguments({required this.limit, required this.idsList});

  @override
  factory GetUserOtherEventsArguments.fromJson(Map<String, dynamic> json) =>
      _$GetUserOtherEventsArgumentsFromJson(json);

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$GetUserOtherEventsArgumentsToJson(this);
}

final GET_USER_OTHER_EVENTS_QUERY_DOCUMENT_OPERATION_NAME =
    'GetUserOtherEvents';
final GET_USER_OTHER_EVENTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetUserOtherEvents'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getUserOtherEvents'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'events'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'event'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'description'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventPics'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'lightEventPics'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'confirmedCount'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'confirmedHosts'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventPlace'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'coords'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: SelectionSetNode(selections: [
                                FieldNode(
                                    name: NameNode(value: 'latitude'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null),
                                FieldNode(
                                    name: NameNode(value: 'longitude'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null)
                              ])),
                          FieldNode(
                              name: NameNode(value: 'createdAt'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'updatedAt'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'eventDate'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'invitedByUserId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'invitedBy'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'username'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'profilePic'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'invitedUserInfo'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'isConfirmed'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'isHost'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'isCreator'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ])),
                    FieldNode(
                        name: NameNode(value: 'friends'),
                        alias: NameNode(value: 'friends'),
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'id'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'username'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null),
                          FieldNode(
                              name: NameNode(value: 'profilePic'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class GetUserOtherEventsQuery extends GraphQLQuery<GetUserOtherEvents$Query,
    GetUserOtherEventsArguments> {
  GetUserOtherEventsQuery({required this.variables});

  @override
  final DocumentNode document = GET_USER_OTHER_EVENTS_QUERY_DOCUMENT;

  @override
  final String operationName =
      GET_USER_OTHER_EVENTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetUserOtherEventsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetUserOtherEvents$Query parse(Map<String, dynamic> json) =>
      GetUserOtherEvents$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SearchUsersArguments extends JsonSerializable with EquatableMixin {
  SearchUsersArguments({required this.search, required this.userSearching});

  @override
  factory SearchUsersArguments.fromJson(Map<String, dynamic> json) =>
      _$SearchUsersArgumentsFromJson(json);

  late String search;

  late int userSearching;

  @override
  List<Object?> get props => [search, userSearching];
  @override
  Map<String, dynamic> toJson() => _$SearchUsersArgumentsToJson(this);
}

final SEARCH_USERS_QUERY_DOCUMENT_OPERATION_NAME = 'SearchUsers';
final SEARCH_USERS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SearchUsers'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'search')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userSearching')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'searchUsers'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'search'),
                  value: VariableNode(name: NameNode(value: 'search'))),
              ArgumentNode(
                  name: NameNode(value: 'userSearching'),
                  value: VariableNode(name: NameNode(value: 'userSearching')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'followState'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'profilePic'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class SearchUsersQuery
    extends GraphQLQuery<SearchUsers$Query, SearchUsersArguments> {
  SearchUsersQuery({required this.variables});

  @override
  final DocumentNode document = SEARCH_USERS_QUERY_DOCUMENT;

  @override
  final String operationName = SEARCH_USERS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final SearchUsersArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SearchUsers$Query parse(Map<String, dynamic> json) =>
      SearchUsers$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetEventGuestsArguments extends JsonSerializable with EquatableMixin {
  GetEventGuestsArguments(
      {required this.eventId, required this.limit, required this.idsList});

  @override
  factory GetEventGuestsArguments.fromJson(Map<String, dynamic> json) =>
      _$GetEventGuestsArgumentsFromJson(json);

  late int eventId;

  late int limit;

  late List<int> idsList;

  @override
  List<Object?> get props => [eventId, limit, idsList];
  @override
  Map<String, dynamic> toJson() => _$GetEventGuestsArgumentsToJson(this);
}

final GET_EVENT_GUESTS_QUERY_DOCUMENT_OPERATION_NAME = 'GetEventGuests';
final GET_EVENT_GUESTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetEventGuests'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'eventId')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'idsList')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getEventGuests'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'eventId'),
                  value: VariableNode(name: NameNode(value: 'eventId'))),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit'))),
              ArgumentNode(
                  name: NameNode(value: 'idsList'),
                  value: VariableNode(name: NameNode(value: 'idsList')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'users'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'profilePic'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'hasMore'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class GetEventGuestsQuery
    extends GraphQLQuery<GetEventGuests$Query, GetEventGuestsArguments> {
  GetEventGuestsQuery({required this.variables});

  @override
  final DocumentNode document = GET_EVENT_GUESTS_QUERY_DOCUMENT;

  @override
  final String operationName = GET_EVENT_GUESTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetEventGuestsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetEventGuests$Query parse(Map<String, dynamic> json) =>
      GetEventGuests$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SaveDeviceArguments extends JsonSerializable with EquatableMixin {
  SaveDeviceArguments({required this.token});

  @override
  factory SaveDeviceArguments.fromJson(Map<String, dynamic> json) =>
      _$SaveDeviceArgumentsFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$SaveDeviceArgumentsToJson(this);
}

final SAVE_DEVICE_MUTATION_DOCUMENT_OPERATION_NAME = 'SaveDevice';
final SAVE_DEVICE_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SaveDevice'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'token')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'saveDevice'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'token'),
                  value: VariableNode(name: NameNode(value: 'token')))
            ],
            directives: [],
            selectionSet: null)
      ]))
]);

class SaveDeviceMutation
    extends GraphQLQuery<SaveDevice$Mutation, SaveDeviceArguments> {
  SaveDeviceMutation({required this.variables});

  @override
  final DocumentNode document = SAVE_DEVICE_MUTATION_DOCUMENT;

  @override
  final String operationName = SAVE_DEVICE_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final SaveDeviceArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SaveDevice$Mutation parse(Map<String, dynamic> json) =>
      SaveDevice$Mutation.fromJson(json);
}
