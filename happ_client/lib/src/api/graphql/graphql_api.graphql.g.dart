// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUser$Mutation$UpdateUserResponse$User
    _$UpdateUser$Mutation$UpdateUserResponse$UserFromJson(
            Map<String, dynamic> json) =>
        UpdateUser$Mutation$UpdateUserResponse$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic> _$UpdateUser$Mutation$UpdateUserResponse$UserToJson(
        UpdateUser$Mutation$UpdateUserResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'profilePic': instance.profilePic,
    };

UpdateUser$Mutation$UpdateUserResponse$ErrorResponse
    _$UpdateUser$Mutation$UpdateUserResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateUser$Mutation$UpdateUserResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$UpdateUser$Mutation$UpdateUserResponse$ErrorResponseToJson(
            UpdateUser$Mutation$UpdateUserResponse$ErrorResponse instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

UpdateUser$Mutation$UpdateUserResponse
    _$UpdateUser$Mutation$UpdateUserResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateUser$Mutation$UpdateUserResponse()
          ..user = json['user'] == null
              ? null
              : UpdateUser$Mutation$UpdateUserResponse$User.fromJson(
                  json['user'] as Map<String, dynamic>)
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  UpdateUser$Mutation$UpdateUserResponse$ErrorResponse.fromJson(
                      e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$UpdateUser$Mutation$UpdateUserResponseToJson(
        UpdateUser$Mutation$UpdateUserResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

UpdateUser$Mutation _$UpdateUser$MutationFromJson(Map<String, dynamic> json) =>
    UpdateUser$Mutation()
      ..updateUser = UpdateUser$Mutation$UpdateUserResponse.fromJson(
          json['updateUser'] as Map<String, dynamic>);

Map<String, dynamic> _$UpdateUser$MutationToJson(
        UpdateUser$Mutation instance) =>
    <String, dynamic>{
      'updateUser': instance.updateUser.toJson(),
    };

UpdateUserInput _$UpdateUserInputFromJson(Map<String, dynamic> json) =>
    UpdateUserInput(
      profilePic: fromGraphQLUploadNullableToDartMultipartFileNullable(
          json['profilePic'] as MultipartFile?),
      name: json['name'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UpdateUserInputToJson(UpdateUserInput instance) =>
    <String, dynamic>{
      'profilePic': fromDartMultipartFileNullableToGraphQLUploadNullable(
          instance.profilePic),
      'name': instance.name,
      'username': instance.username,
    };

SaveDevice$Mutation _$SaveDevice$MutationFromJson(Map<String, dynamic> json) =>
    SaveDevice$Mutation()..saveDevice = json['saveDevice'] as bool?;

Map<String, dynamic> _$SaveDevice$MutationToJson(
        SaveDevice$Mutation instance) =>
    <String, dynamic>{
      'saveDevice': instance.saveDevice,
    };

ScanPass$Mutation _$ScanPass$MutationFromJson(Map<String, dynamic> json) =>
    ScanPass$Mutation()..scanPass = json['scanPass'] as bool?;

Map<String, dynamic> _$ScanPass$MutationToJson(ScanPass$Mutation instance) =>
    <String, dynamic>{
      'scanPass': instance.scanPass,
    };

AddOrRemoveUser$Mutation$AddResponse
    _$AddOrRemoveUser$Mutation$AddResponseFromJson(Map<String, dynamic> json) =>
        AddOrRemoveUser$Mutation$AddResponse()
          ..value = json['value'] as int
          ..unchanged = json['unchanged'] as bool;

Map<String, dynamic> _$AddOrRemoveUser$Mutation$AddResponseToJson(
        AddOrRemoveUser$Mutation$AddResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unchanged': instance.unchanged,
    };

AddOrRemoveUser$Mutation _$AddOrRemoveUser$MutationFromJson(
        Map<String, dynamic> json) =>
    AddOrRemoveUser$Mutation()
      ..addOrRemoveUser = AddOrRemoveUser$Mutation$AddResponse.fromJson(
          json['addOrRemoveUser'] as Map<String, dynamic>);

Map<String, dynamic> _$AddOrRemoveUser$MutationToJson(
        AddOrRemoveUser$Mutation instance) =>
    <String, dynamic>{
      'addOrRemoveUser': instance.addOrRemoveUser.toJson(),
    };

NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates
    _$NewEvent$Mutation$CreateEventResponse$Event$EventCoordinatesFromJson(
            Map<String, dynamic> json) =>
        NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates()
          ..latitude = (json['latitude'] as num).toDouble()
          ..longitude = (json['longitude'] as num).toDouble();

Map<String, dynamic>
    _$NewEvent$Mutation$CreateEventResponse$Event$EventCoordinatesToJson(
            NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates
                instance) =>
        <String, dynamic>{
          'latitude': instance.latitude,
          'longitude': instance.longitude,
        };

NewEvent$Mutation$CreateEventResponse$Event
    _$NewEvent$Mutation$CreateEventResponse$EventFromJson(
            Map<String, dynamic> json) =>
        NewEvent$Mutation$CreateEventResponse$Event()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..description = json['description'] as String
          ..confirmedCount = json['confirmedCount'] as int
          ..eventPics = (json['eventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..eventDate = json['eventDate'] as String
          ..coords =
              NewEvent$Mutation$CreateEventResponse$Event$EventCoordinates
                  .fromJson(json['coords'] as Map<String, dynamic>)
          ..createdAt = json['createdAt'] as String
          ..updatedAt = json['updatedAt'] as String;

Map<String, dynamic> _$NewEvent$Mutation$CreateEventResponse$EventToJson(
        NewEvent$Mutation$CreateEventResponse$Event instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'confirmedCount': instance.confirmedCount,
      'eventPics': instance.eventPics,
      'eventDate': instance.eventDate,
      'coords': instance.coords.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

NewEvent$Mutation$CreateEventResponse$ErrorResponse
    _$NewEvent$Mutation$CreateEventResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        NewEvent$Mutation$CreateEventResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$NewEvent$Mutation$CreateEventResponse$ErrorResponseToJson(
            NewEvent$Mutation$CreateEventResponse$ErrorResponse instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

NewEvent$Mutation$CreateEventResponse
    _$NewEvent$Mutation$CreateEventResponseFromJson(
            Map<String, dynamic> json) =>
        NewEvent$Mutation$CreateEventResponse()
          ..event = json['event'] == null
              ? null
              : NewEvent$Mutation$CreateEventResponse$Event.fromJson(
                  json['event'] as Map<String, dynamic>)
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  NewEvent$Mutation$CreateEventResponse$ErrorResponse.fromJson(
                      e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$NewEvent$Mutation$CreateEventResponseToJson(
        NewEvent$Mutation$CreateEventResponse instance) =>
    <String, dynamic>{
      'event': instance.event?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

NewEvent$Mutation _$NewEvent$MutationFromJson(Map<String, dynamic> json) =>
    NewEvent$Mutation()
      ..newEvent = NewEvent$Mutation$CreateEventResponse.fromJson(
          json['newEvent'] as Map<String, dynamic>);

Map<String, dynamic> _$NewEvent$MutationToJson(NewEvent$Mutation instance) =>
    <String, dynamic>{
      'newEvent': instance.newEvent.toJson(),
    };

NewEventInput _$NewEventInputFromJson(Map<String, dynamic> json) =>
    NewEventInput(
      name: json['name'] as String,
      description: json['description'] as String,
      eventDate: json['eventDate'] as String,
      eventPics: fromGraphQLListUploadToDartListMultipartFile(
          json['eventPics'] as List<MultipartFile>),
      eventPicsLight: fromGraphQLListUploadToDartListMultipartFile(
          json['eventPicsLight'] as List<MultipartFile>),
      eventPlace: json['eventPlace'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$NewEventInputToJson(NewEventInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'eventDate': instance.eventDate,
      'eventPics':
          fromDartListMultipartFileToGraphQLListUpload(instance.eventPics),
      'eventPicsLight':
          fromDartListMultipartFileToGraphQLListUpload(instance.eventPicsLight),
      'eventPlace': instance.eventPlace,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

LeaveEvent$Mutation _$LeaveEvent$MutationFromJson(Map<String, dynamic> json) =>
    LeaveEvent$Mutation()..leaveEvent = json['leaveEvent'] as bool?;

Map<String, dynamic> _$LeaveEvent$MutationToJson(
        LeaveEvent$Mutation instance) =>
    <String, dynamic>{
      'leaveEvent': instance.leaveEvent,
    };

UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates
    _$UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinatesFromJson(
            Map<String, dynamic> json) =>
        UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates()
          ..latitude = (json['latitude'] as num).toDouble()
          ..longitude = (json['longitude'] as num).toDouble();

Map<String, dynamic>
    _$UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinatesToJson(
            UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates
                instance) =>
        <String, dynamic>{
          'latitude': instance.latitude,
          'longitude': instance.longitude,
        };

UpdateEvent$Mutation$CreateEventResponse$Event
    _$UpdateEvent$Mutation$CreateEventResponse$EventFromJson(
            Map<String, dynamic> json) =>
        UpdateEvent$Mutation$CreateEventResponse$Event()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..description = json['description'] as String
          ..eventPics = (json['eventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..lightEventPics = (json['lightEventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..confirmedCount = json['confirmedCount'] as int
          ..confirmedHosts = json['confirmedHosts'] as int
          ..eventPlace = json['eventPlace'] as String
          ..coords =
              UpdateEvent$Mutation$CreateEventResponse$Event$EventCoordinates
                  .fromJson(json['coords'] as Map<String, dynamic>)
          ..createdAt = json['createdAt'] as String
          ..updatedAt = json['updatedAt'] as String
          ..eventDate = json['eventDate'] as String;

Map<String, dynamic> _$UpdateEvent$Mutation$CreateEventResponse$EventToJson(
        UpdateEvent$Mutation$CreateEventResponse$Event instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'eventPics': instance.eventPics,
      'lightEventPics': instance.lightEventPics,
      'confirmedCount': instance.confirmedCount,
      'confirmedHosts': instance.confirmedHosts,
      'eventPlace': instance.eventPlace,
      'coords': instance.coords.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'eventDate': instance.eventDate,
    };

UpdateEvent$Mutation$CreateEventResponse$ErrorResponse
    _$UpdateEvent$Mutation$CreateEventResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateEvent$Mutation$CreateEventResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic>
    _$UpdateEvent$Mutation$CreateEventResponse$ErrorResponseToJson(
            UpdateEvent$Mutation$CreateEventResponse$ErrorResponse instance) =>
        <String, dynamic>{
          'field': instance.field,
          'message': instance.message,
        };

UpdateEvent$Mutation$CreateEventResponse
    _$UpdateEvent$Mutation$CreateEventResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateEvent$Mutation$CreateEventResponse()
          ..event = json['event'] == null
              ? null
              : UpdateEvent$Mutation$CreateEventResponse$Event.fromJson(
                  json['event'] as Map<String, dynamic>)
          ..errors = (json['errors'] as List<dynamic>?)
              ?.map((e) =>
                  UpdateEvent$Mutation$CreateEventResponse$ErrorResponse
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$UpdateEvent$Mutation$CreateEventResponseToJson(
        UpdateEvent$Mutation$CreateEventResponse instance) =>
    <String, dynamic>{
      'event': instance.event?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

UpdateEvent$Mutation _$UpdateEvent$MutationFromJson(
        Map<String, dynamic> json) =>
    UpdateEvent$Mutation()
      ..updateEvent = UpdateEvent$Mutation$CreateEventResponse.fromJson(
          json['updateEvent'] as Map<String, dynamic>);

Map<String, dynamic> _$UpdateEvent$MutationToJson(
        UpdateEvent$Mutation instance) =>
    <String, dynamic>{
      'updateEvent': instance.updateEvent.toJson(),
    };

UpdateEventInput _$UpdateEventInputFromJson(Map<String, dynamic> json) =>
    UpdateEventInput(
      name: json['name'] as String?,
      description: json['description'] as String?,
      eventDate: json['eventDate'] as String?,
      eventPics: (json['eventPics'] as List<dynamic>?)
          ?.map((e) => UpdatePictureInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventPicsLight: (json['eventPicsLight'] as List<dynamic>?)
          ?.map((e) => UpdatePictureInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventPlace: json['eventPlace'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UpdateEventInputToJson(UpdateEventInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'eventDate': instance.eventDate,
      'eventPics': instance.eventPics?.map((e) => e.toJson()).toList(),
      'eventPicsLight':
          instance.eventPicsLight?.map((e) => e.toJson()).toList(),
      'eventPlace': instance.eventPlace,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

UpdatePictureInput _$UpdatePictureInputFromJson(Map<String, dynamic> json) =>
    UpdatePictureInput(
      index: json['index'] as int,
      file: fromGraphQLUploadNullableToDartMultipartFileNullable(
          json['file'] as MultipartFile?),
      action: $enumDecode(_$PictureActionEnumMap, json['action'],
          unknownValue: PictureAction.artemisUnknown),
    );

Map<String, dynamic> _$UpdatePictureInputToJson(UpdatePictureInput instance) =>
    <String, dynamic>{
      'index': instance.index,
      'file':
          fromDartMultipartFileNullableToGraphQLUploadNullable(instance.file),
      'action': _$PictureActionEnumMap[instance.action]!,
    };

const _$PictureActionEnumMap = {
  PictureAction.add: 'ADD',
  PictureAction.replace: 'REPLACE',
  PictureAction.delete: 'DELETE',
  PictureAction.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

InviteGuestsAndOrganizers$Mutation _$InviteGuestsAndOrganizers$MutationFromJson(
        Map<String, dynamic> json) =>
    InviteGuestsAndOrganizers$Mutation()
      ..inviteGuestsAndOrganizers = json['inviteGuestsAndOrganizers'] as bool;

Map<String, dynamic> _$InviteGuestsAndOrganizers$MutationToJson(
        InviteGuestsAndOrganizers$Mutation instance) =>
    <String, dynamic>{
      'inviteGuestsAndOrganizers': instance.inviteGuestsAndOrganizers,
    };

SignIn$Mutation$SignInResponse$User
    _$SignIn$Mutation$SignInResponse$UserFromJson(Map<String, dynamic> json) =>
        SignIn$Mutation$SignInResponse$User()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..username = json['username'] as String
          ..followState = json['followState'] as bool
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic> _$SignIn$Mutation$SignInResponse$UserToJson(
        SignIn$Mutation$SignInResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'followState': instance.followState,
      'profilePic': instance.profilePic,
    };

SignIn$Mutation$SignInResponse _$SignIn$Mutation$SignInResponseFromJson(
        Map<String, dynamic> json) =>
    SignIn$Mutation$SignInResponse()
      ..user = json['user'] == null
          ? null
          : SignIn$Mutation$SignInResponse$User.fromJson(
              json['user'] as Map<String, dynamic>)
      ..isNew = json['isNew'] as bool?;

Map<String, dynamic> _$SignIn$Mutation$SignInResponseToJson(
        SignIn$Mutation$SignInResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'isNew': instance.isNew,
    };

SignIn$Mutation _$SignIn$MutationFromJson(Map<String, dynamic> json) =>
    SignIn$Mutation()
      ..signIn = SignIn$Mutation$SignInResponse.fromJson(
          json['signIn'] as Map<String, dynamic>);

Map<String, dynamic> _$SignIn$MutationToJson(SignIn$Mutation instance) =>
    <String, dynamic>{
      'signIn': instance.signIn.toJson(),
    };

SignInInput _$SignInInputFromJson(Map<String, dynamic> json) => SignInInput(
      token: json['token'] as String,
      provider: $enumDecode(_$SignInProviderEnumMap, json['provider'],
          unknownValue: SignInProvider.artemisUnknown),
      appleData: json['appleData'] == null
          ? null
          : AppleData.fromJson(json['appleData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInInputToJson(SignInInput instance) =>
    <String, dynamic>{
      'token': instance.token,
      'provider': _$SignInProviderEnumMap[instance.provider]!,
      'appleData': instance.appleData?.toJson(),
    };

const _$SignInProviderEnumMap = {
  SignInProvider.apple: 'APPLE',
  SignInProvider.google: 'GOOGLE',
  SignInProvider.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

AppleData _$AppleDataFromJson(Map<String, dynamic> json) => AppleData(
      name: json['name'] as String,
      authorizationCode: json['authorizationCode'] as String,
    );

Map<String, dynamic> _$AppleDataToJson(AppleData instance) => <String, dynamic>{
      'name': instance.name,
      'authorizationCode': instance.authorizationCode,
    };

DeleteUser$Mutation _$DeleteUser$MutationFromJson(Map<String, dynamic> json) =>
    DeleteUser$Mutation()..deleteUser = json['deleteUser'] as bool;

Map<String, dynamic> _$DeleteUser$MutationToJson(
        DeleteUser$Mutation instance) =>
    <String, dynamic>{
      'deleteUser': instance.deleteUser,
    };

AcceptInvitation$Mutation$AcceptInvitationResponse
    _$AcceptInvitation$Mutation$AcceptInvitationResponseFromJson(
            Map<String, dynamic> json) =>
        AcceptInvitation$Mutation$AcceptInvitationResponse()
          ..cypherText = json['cypherText'] as String?
          ..isHost = json['isHost'] as bool;

Map<String, dynamic> _$AcceptInvitation$Mutation$AcceptInvitationResponseToJson(
        AcceptInvitation$Mutation$AcceptInvitationResponse instance) =>
    <String, dynamic>{
      'cypherText': instance.cypherText,
      'isHost': instance.isHost,
    };

AcceptInvitation$Mutation _$AcceptInvitation$MutationFromJson(
        Map<String, dynamic> json) =>
    AcceptInvitation$Mutation()
      ..acceptInvitation =
          AcceptInvitation$Mutation$AcceptInvitationResponse.fromJson(
              json['acceptInvitation'] as Map<String, dynamic>);

Map<String, dynamic> _$AcceptInvitation$MutationToJson(
        AcceptInvitation$Mutation instance) =>
    <String, dynamic>{
      'acceptInvitation': instance.acceptInvitation.toJson(),
    };

DeleteEvent$Mutation _$DeleteEvent$MutationFromJson(
        Map<String, dynamic> json) =>
    DeleteEvent$Mutation()..deleteEvent = json['deleteEvent'] as bool?;

Map<String, dynamic> _$DeleteEvent$MutationToJson(
        DeleteEvent$Mutation instance) =>
    <String, dynamic>{
      'deleteEvent': instance.deleteEvent,
    };

AddGuests$Mutation _$AddGuests$MutationFromJson(Map<String, dynamic> json) =>
    AddGuests$Mutation()..addGuests = json['addGuests'] as bool?;

Map<String, dynamic> _$AddGuests$MutationToJson(AddGuests$Mutation instance) =>
    <String, dynamic>{
      'addGuests': instance.addGuests,
    };

RemoveGuests$Mutation _$RemoveGuests$MutationFromJson(
        Map<String, dynamic> json) =>
    RemoveGuests$Mutation()..removeGuests = json['removeGuests'] as bool?;

Map<String, dynamic> _$RemoveGuests$MutationToJson(
        RemoveGuests$Mutation instance) =>
    <String, dynamic>{
      'removeGuests': instance.removeGuests,
    };

UserFromId$Query$User _$UserFromId$Query$UserFromJson(
        Map<String, dynamic> json) =>
    UserFromId$Query$User()
      ..id = json['id'] as int
      ..name = json['name'] as String
      ..username = json['username'] as String
      ..followState = json['followState'] as bool
      ..profilePic = json['profilePic'] as String;

Map<String, dynamic> _$UserFromId$Query$UserToJson(
        UserFromId$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'followState': instance.followState,
      'profilePic': instance.profilePic,
    };

UserFromId$Query _$UserFromId$QueryFromJson(Map<String, dynamic> json) =>
    UserFromId$Query()
      ..userFromId = json['userFromId'] == null
          ? null
          : UserFromId$Query$User.fromJson(
              json['userFromId'] as Map<String, dynamic>);

Map<String, dynamic> _$UserFromId$QueryToJson(UserFromId$Query instance) =>
    <String, dynamic>{
      'userFromId': instance.userFromId?.toJson(),
    };

MutualFriends$Query$PaginatedEventUsersResults$User
    _$MutualFriends$Query$PaginatedEventUsersResults$UserFromJson(
            Map<String, dynamic> json) =>
        MutualFriends$Query$PaginatedEventUsersResults$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$MutualFriends$Query$PaginatedEventUsersResults$UserToJson(
            MutualFriends$Query$PaginatedEventUsersResults$User instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'name': instance.name,
          'profilePic': instance.profilePic,
        };

MutualFriends$Query$PaginatedEventUsersResults
    _$MutualFriends$Query$PaginatedEventUsersResultsFromJson(
            Map<String, dynamic> json) =>
        MutualFriends$Query$PaginatedEventUsersResults()
          ..users = (json['users'] as List<dynamic>)
              .map((e) =>
                  MutualFriends$Query$PaginatedEventUsersResults$User.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$MutualFriends$Query$PaginatedEventUsersResultsToJson(
        MutualFriends$Query$PaginatedEventUsersResults instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

MutualFriends$Query _$MutualFriends$QueryFromJson(Map<String, dynamic> json) =>
    MutualFriends$Query()
      ..mutualFriends = MutualFriends$Query$PaginatedEventUsersResults.fromJson(
          json['mutualFriends'] as Map<String, dynamic>);

Map<String, dynamic> _$MutualFriends$QueryToJson(
        MutualFriends$Query instance) =>
    <String, dynamic>{
      'mutualFriends': instance.mutualFriends.toJson(),
    };

LocationDetails$Query$EventCoordinates
    _$LocationDetails$Query$EventCoordinatesFromJson(
            Map<String, dynamic> json) =>
        LocationDetails$Query$EventCoordinates()
          ..latitude = (json['latitude'] as num).toDouble()
          ..longitude = (json['longitude'] as num).toDouble();

Map<String, dynamic> _$LocationDetails$Query$EventCoordinatesToJson(
        LocationDetails$Query$EventCoordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

LocationDetails$Query _$LocationDetails$QueryFromJson(
        Map<String, dynamic> json) =>
    LocationDetails$Query()
      ..locationDetails = LocationDetails$Query$EventCoordinates.fromJson(
          json['locationDetails'] as Map<String, dynamic>);

Map<String, dynamic> _$LocationDetails$QueryToJson(
        LocationDetails$Query instance) =>
    <String, dynamic>{
      'locationDetails': instance.locationDetails.toJson(),
    };

SeePass$Query _$SeePass$QueryFromJson(Map<String, dynamic> json) =>
    SeePass$Query()..seePass = json['seePass'] as String?;

Map<String, dynamic> _$SeePass$QueryToJson(SeePass$Query instance) =>
    <String, dynamic>{
      'seePass': instance.seePass,
    };

GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates()
          ..latitude = (json['latitude'] as num).toDouble()
          ..longitude = (json['longitude'] as num).toDouble();

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
                instance) =>
        <String, dynamic>{
          'latitude': instance.latitude,
          'longitude': instance.longitude,
        };

GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$EventFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..description = json['description'] as String
          ..eventPics = (json['eventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..lightEventPics = (json['lightEventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..confirmedCount = json['confirmedCount'] as int
          ..confirmedHosts = json['confirmedHosts'] as int
          ..eventPlace = json['eventPlace'] as String
          ..coords =
              GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
                  .fromJson(json['coords'] as Map<String, dynamic>)
          ..createdAt = json['createdAt'] as String
          ..updatedAt = json['updatedAt'] as String
          ..eventDate = json['eventDate'] as String;

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$EventToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
          'description': instance.description,
          'eventPics': instance.eventPics,
          'lightEventPics': instance.lightEventPics,
          'confirmedCount': instance.confirmedCount,
          'confirmedHosts': instance.confirmedHosts,
          'eventPlace': instance.eventPlace,
          'coords': instance.coords.toJson(),
          'createdAt': instance.createdAt,
          'updatedAt': instance.updatedAt,
          'eventDate': instance.eventDate,
        };

GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$UserFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$UserToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'name': instance.name,
          'profilePic': instance.profilePic,
        };

GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo()
          ..isConfirmed = json['isConfirmed'] as bool
          ..isHost = json['isHost'] as bool
          ..isCreator = json['isCreator'] as bool;

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
                instance) =>
        <String, dynamic>{
          'isConfirmed': instance.isConfirmed,
          'isHost': instance.isHost,
          'isCreator': instance.isCreator,
        };

GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$FriendsFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..username = json['username'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$FriendsToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
          'username': instance.username,
          'profilePic': instance.profilePic,
        };

GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteResFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes()
          ..event =
              GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event
                  .fromJson(json['event'] as Map<String, dynamic>)
          ..invitedByUserId = json['invitedByUserId'] as int
          ..invitedBy =
              GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User
                  .fromJson(json['invitedBy'] as Map<String, dynamic>)
          ..invitedUserInfo =
              GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
                  .fromJson(json['invitedUserInfo'] as Map<String, dynamic>)
          ..friends = (json['friends'] as List<dynamic>)
              .map((e) =>
                  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Friends
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteResToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes
                instance) =>
        <String, dynamic>{
          'event': instance.event.toJson(),
          'invitedByUserId': instance.invitedByUserId,
          'invitedBy': instance.invitedBy.toJson(),
          'invitedUserInfo': instance.invitedUserInfo.toJson(),
          'friends': instance.friends.map((e) => e.toJson()).toList(),
        };

GetUserEventsFromFriends$Query$PaginatedEventResults
    _$GetUserEventsFromFriends$Query$PaginatedEventResultsFromJson(
            Map<String, dynamic> json) =>
        GetUserEventsFromFriends$Query$PaginatedEventResults()
          ..events = (json['events'] as List<dynamic>)
              .map((e) =>
                  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic>
    _$GetUserEventsFromFriends$Query$PaginatedEventResultsToJson(
            GetUserEventsFromFriends$Query$PaginatedEventResults instance) =>
        <String, dynamic>{
          'events': instance.events.map((e) => e.toJson()).toList(),
          'hasMore': instance.hasMore,
        };

GetUserEventsFromFriends$Query _$GetUserEventsFromFriends$QueryFromJson(
        Map<String, dynamic> json) =>
    GetUserEventsFromFriends$Query()
      ..getUserEventsFromFriends =
          GetUserEventsFromFriends$Query$PaginatedEventResults.fromJson(
              json['getUserEventsFromFriends'] as Map<String, dynamic>);

Map<String, dynamic> _$GetUserEventsFromFriends$QueryToJson(
        GetUserEventsFromFriends$Query instance) =>
    <String, dynamic>{
      'getUserEventsFromFriends': instance.getUserEventsFromFriends.toJson(),
    };

MyFriends$Query$PaginatedEventUsersResults$User
    _$MyFriends$Query$PaginatedEventUsersResults$UserFromJson(
            Map<String, dynamic> json) =>
        MyFriends$Query$PaginatedEventUsersResults$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic> _$MyFriends$Query$PaginatedEventUsersResults$UserToJson(
        MyFriends$Query$PaginatedEventUsersResults$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'profilePic': instance.profilePic,
    };

MyFriends$Query$PaginatedEventUsersResults
    _$MyFriends$Query$PaginatedEventUsersResultsFromJson(
            Map<String, dynamic> json) =>
        MyFriends$Query$PaginatedEventUsersResults()
          ..users = (json['users'] as List<dynamic>)
              .map((e) =>
                  MyFriends$Query$PaginatedEventUsersResults$User.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$MyFriends$Query$PaginatedEventUsersResultsToJson(
        MyFriends$Query$PaginatedEventUsersResults instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

MyFriends$Query _$MyFriends$QueryFromJson(Map<String, dynamic> json) =>
    MyFriends$Query()
      ..myFriends = MyFriends$Query$PaginatedEventUsersResults.fromJson(
          json['myFriends'] as Map<String, dynamic>);

Map<String, dynamic> _$MyFriends$QueryToJson(MyFriends$Query instance) =>
    <String, dynamic>{
      'myFriends': instance.myFriends.toJson(),
    };

GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates()
          ..latitude = (json['latitude'] as num).toDouble()
          ..longitude = (json['longitude'] as num).toDouble();

Map<String, dynamic>
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesToJson(
            GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
                instance) =>
        <String, dynamic>{
          'latitude': instance.latitude,
          'longitude': instance.longitude,
        };

GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$EventFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..description = json['description'] as String
          ..eventPics = (json['eventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..lightEventPics = (json['lightEventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..confirmedCount = json['confirmedCount'] as int
          ..confirmedHosts = json['confirmedHosts'] as int
          ..eventPlace = json['eventPlace'] as String
          ..coords =
              GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
                  .fromJson(json['coords'] as Map<String, dynamic>)
          ..createdAt = json['createdAt'] as String
          ..updatedAt = json['updatedAt'] as String
          ..eventDate = json['eventDate'] as String;

Map<String, dynamic>
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$EventToJson(
            GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
          'description': instance.description,
          'eventPics': instance.eventPics,
          'lightEventPics': instance.lightEventPics,
          'confirmedCount': instance.confirmedCount,
          'confirmedHosts': instance.confirmedHosts,
          'eventPlace': instance.eventPlace,
          'coords': instance.coords.toJson(),
          'createdAt': instance.createdAt,
          'updatedAt': instance.updatedAt,
          'eventDate': instance.eventDate,
        };

GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$UserFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$UserToJson(
            GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'name': instance.name,
          'profilePic': instance.profilePic,
        };

GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo()
          ..isConfirmed = json['isConfirmed'] as bool
          ..isHost = json['isHost'] as bool
          ..isCreator = json['isCreator'] as bool;

Map<String, dynamic>
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoToJson(
            GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
                instance) =>
        <String, dynamic>{
          'isConfirmed': instance.isConfirmed,
          'isHost': instance.isHost,
          'isCreator': instance.isCreator,
        };

GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$FriendsFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..username = json['username'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteRes$FriendsToJson(
            GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
          'username': instance.username,
          'profilePic': instance.profilePic,
        };

GetUserEvents$Query$PaginatedEventResults$EventInviteRes
    _$GetUserEvents$Query$PaginatedEventResults$EventInviteResFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes()
          ..event =
              GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event
                  .fromJson(json['event'] as Map<String, dynamic>)
          ..invitedByUserId = json['invitedByUserId'] as int
          ..invitedBy =
              GetUserEvents$Query$PaginatedEventResults$EventInviteRes$User
                  .fromJson(json['invitedBy'] as Map<String, dynamic>)
          ..invitedUserInfo =
              GetUserEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
                  .fromJson(json['invitedUserInfo'] as Map<String, dynamic>)
          ..friends = (json['friends'] as List<dynamic>)
              .map((e) =>
                  GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Friends
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String,
    dynamic> _$GetUserEvents$Query$PaginatedEventResults$EventInviteResToJson(
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'invitedByUserId': instance.invitedByUserId,
      'invitedBy': instance.invitedBy.toJson(),
      'invitedUserInfo': instance.invitedUserInfo.toJson(),
      'friends': instance.friends.map((e) => e.toJson()).toList(),
    };

GetUserEvents$Query$PaginatedEventResults
    _$GetUserEvents$Query$PaginatedEventResultsFromJson(
            Map<String, dynamic> json) =>
        GetUserEvents$Query$PaginatedEventResults()
          ..events = (json['events'] as List<dynamic>)
              .map((e) =>
                  GetUserEvents$Query$PaginatedEventResults$EventInviteRes
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$GetUserEvents$Query$PaginatedEventResultsToJson(
        GetUserEvents$Query$PaginatedEventResults instance) =>
    <String, dynamic>{
      'events': instance.events.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

GetUserEvents$Query _$GetUserEvents$QueryFromJson(Map<String, dynamic> json) =>
    GetUserEvents$Query()
      ..getUserEvents = GetUserEvents$Query$PaginatedEventResults.fromJson(
          json['getUserEvents'] as Map<String, dynamic>);

Map<String, dynamic> _$GetUserEvents$QueryToJson(
        GetUserEvents$Query instance) =>
    <String, dynamic>{
      'getUserEvents': instance.getUserEvents.toJson(),
    };

GetEventHosts$Query$PaginatedEventUsersResults$User
    _$GetEventHosts$Query$PaginatedEventUsersResults$UserFromJson(
            Map<String, dynamic> json) =>
        GetEventHosts$Query$PaginatedEventUsersResults$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetEventHosts$Query$PaginatedEventUsersResults$UserToJson(
            GetEventHosts$Query$PaginatedEventUsersResults$User instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'name': instance.name,
          'profilePic': instance.profilePic,
        };

GetEventHosts$Query$PaginatedEventUsersResults
    _$GetEventHosts$Query$PaginatedEventUsersResultsFromJson(
            Map<String, dynamic> json) =>
        GetEventHosts$Query$PaginatedEventUsersResults()
          ..users = (json['users'] as List<dynamic>)
              .map((e) =>
                  GetEventHosts$Query$PaginatedEventUsersResults$User.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$GetEventHosts$Query$PaginatedEventUsersResultsToJson(
        GetEventHosts$Query$PaginatedEventUsersResults instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

GetEventHosts$Query _$GetEventHosts$QueryFromJson(Map<String, dynamic> json) =>
    GetEventHosts$Query()
      ..getEventHosts = GetEventHosts$Query$PaginatedEventUsersResults.fromJson(
          json['getEventHosts'] as Map<String, dynamic>);

Map<String, dynamic> _$GetEventHosts$QueryToJson(
        GetEventHosts$Query instance) =>
    <String, dynamic>{
      'getEventHosts': instance.getEventHosts.toJson(),
    };

SearchLocation$Query$LocationAutoCompletePrediction
    _$SearchLocation$Query$LocationAutoCompletePredictionFromJson(
            Map<String, dynamic> json) =>
        SearchLocation$Query$LocationAutoCompletePrediction()
          ..placeId = json['placeId'] as String
          ..description = json['description'] as String;

Map<String, dynamic>
    _$SearchLocation$Query$LocationAutoCompletePredictionToJson(
            SearchLocation$Query$LocationAutoCompletePrediction instance) =>
        <String, dynamic>{
          'placeId': instance.placeId,
          'description': instance.description,
        };

SearchLocation$Query _$SearchLocation$QueryFromJson(
        Map<String, dynamic> json) =>
    SearchLocation$Query()
      ..searchLocation = (json['searchLocation'] as List<dynamic>)
          .map((e) =>
              SearchLocation$Query$LocationAutoCompletePrediction.fromJson(
                  e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchLocation$QueryToJson(
        SearchLocation$Query instance) =>
    <String, dynamic>{
      'searchLocation': instance.searchLocation.map((e) => e.toJson()).toList(),
    };

AddedMe$Query$PaginatedEventUsersResults$User
    _$AddedMe$Query$PaginatedEventUsersResults$UserFromJson(
            Map<String, dynamic> json) =>
        AddedMe$Query$PaginatedEventUsersResults$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String
          ..followState = json['followState'] as bool;

Map<String, dynamic> _$AddedMe$Query$PaginatedEventUsersResults$UserToJson(
        AddedMe$Query$PaginatedEventUsersResults$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'profilePic': instance.profilePic,
      'followState': instance.followState,
    };

AddedMe$Query$PaginatedEventUsersResults
    _$AddedMe$Query$PaginatedEventUsersResultsFromJson(
            Map<String, dynamic> json) =>
        AddedMe$Query$PaginatedEventUsersResults()
          ..users = (json['users'] as List<dynamic>)
              .map((e) =>
                  AddedMe$Query$PaginatedEventUsersResults$User.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$AddedMe$Query$PaginatedEventUsersResultsToJson(
        AddedMe$Query$PaginatedEventUsersResults instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

AddedMe$Query _$AddedMe$QueryFromJson(Map<String, dynamic> json) =>
    AddedMe$Query()
      ..addedMe = AddedMe$Query$PaginatedEventUsersResults.fromJson(
          json['addedMe'] as Map<String, dynamic>);

Map<String, dynamic> _$AddedMe$QueryToJson(AddedMe$Query instance) =>
    <String, dynamic>{
      'addedMe': instance.addedMe.toJson(),
    };

GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates()
          ..latitude = (json['latitude'] as num).toDouble()
          ..longitude = (json['longitude'] as num).toDouble();

Map<String, dynamic>
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinatesToJson(
            GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
                instance) =>
        <String, dynamic>{
          'latitude': instance.latitude,
          'longitude': instance.longitude,
        };

GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$EventFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..description = json['description'] as String
          ..eventPics = (json['eventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..lightEventPics = (json['lightEventPics'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          ..confirmedCount = json['confirmedCount'] as int
          ..confirmedHosts = json['confirmedHosts'] as int
          ..eventPlace = json['eventPlace'] as String
          ..coords =
              GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event$EventCoordinates
                  .fromJson(json['coords'] as Map<String, dynamic>)
          ..createdAt = json['createdAt'] as String
          ..updatedAt = json['updatedAt'] as String
          ..eventDate = json['eventDate'] as String;

Map<String, dynamic>
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$EventToJson(
            GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
          'description': instance.description,
          'eventPics': instance.eventPics,
          'lightEventPics': instance.lightEventPics,
          'confirmedCount': instance.confirmedCount,
          'confirmedHosts': instance.confirmedHosts,
          'eventPlace': instance.eventPlace,
          'coords': instance.coords.toJson(),
          'createdAt': instance.createdAt,
          'updatedAt': instance.updatedAt,
          'eventDate': instance.eventDate,
        };

GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$UserFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$UserToJson(
            GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'name': instance.name,
          'profilePic': instance.profilePic,
        };

GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo()
          ..isConfirmed = json['isConfirmed'] as bool
          ..isHost = json['isHost'] as bool
          ..isCreator = json['isCreator'] as bool;

Map<String, dynamic>
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfoToJson(
            GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
                instance) =>
        <String, dynamic>{
          'isConfirmed': instance.isConfirmed,
          'isHost': instance.isHost,
          'isCreator': instance.isCreator,
        };

GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$FriendsFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends()
          ..id = json['id'] as int
          ..name = json['name'] as String
          ..username = json['username'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$FriendsToJson(
            GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
          'username': instance.username,
          'profilePic': instance.profilePic,
        };

GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteResFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes()
          ..event =
              GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event
                  .fromJson(json['event'] as Map<String, dynamic>)
          ..invitedByUserId = json['invitedByUserId'] as int
          ..invitedBy =
              GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$User
                  .fromJson(json['invitedBy'] as Map<String, dynamic>)
          ..invitedUserInfo =
              GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo
                  .fromJson(json['invitedUserInfo'] as Map<String, dynamic>)
          ..friends = (json['friends'] as List<dynamic>)
              .map((e) =>
                  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Friends
                      .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic>
    _$GetUserOtherEvents$Query$PaginatedEventResults$EventInviteResToJson(
            GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes
                instance) =>
        <String, dynamic>{
          'event': instance.event.toJson(),
          'invitedByUserId': instance.invitedByUserId,
          'invitedBy': instance.invitedBy.toJson(),
          'invitedUserInfo': instance.invitedUserInfo.toJson(),
          'friends': instance.friends.map((e) => e.toJson()).toList(),
        };

GetUserOtherEvents$Query$PaginatedEventResults
    _$GetUserOtherEvents$Query$PaginatedEventResultsFromJson(
            Map<String, dynamic> json) =>
        GetUserOtherEvents$Query$PaginatedEventResults()
          ..events = (json['events'] as List<dynamic>)
              .map((e) =>
                  GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes
                      .fromJson(e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$GetUserOtherEvents$Query$PaginatedEventResultsToJson(
        GetUserOtherEvents$Query$PaginatedEventResults instance) =>
    <String, dynamic>{
      'events': instance.events.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

GetUserOtherEvents$Query _$GetUserOtherEvents$QueryFromJson(
        Map<String, dynamic> json) =>
    GetUserOtherEvents$Query()
      ..getUserOtherEvents =
          GetUserOtherEvents$Query$PaginatedEventResults.fromJson(
              json['getUserOtherEvents'] as Map<String, dynamic>);

Map<String, dynamic> _$GetUserOtherEvents$QueryToJson(
        GetUserOtherEvents$Query instance) =>
    <String, dynamic>{
      'getUserOtherEvents': instance.getUserOtherEvents.toJson(),
    };

GetFollowState$Query _$GetFollowState$QueryFromJson(
        Map<String, dynamic> json) =>
    GetFollowState$Query()..getFollowState = json['getFollowState'] as bool;

Map<String, dynamic> _$GetFollowState$QueryToJson(
        GetFollowState$Query instance) =>
    <String, dynamic>{
      'getFollowState': instance.getFollowState,
    };

SearchUsers$Query$User _$SearchUsers$Query$UserFromJson(
        Map<String, dynamic> json) =>
    SearchUsers$Query$User()
      ..id = json['id'] as int
      ..username = json['username'] as String
      ..name = json['name'] as String
      ..followState = json['followState'] as bool
      ..profilePic = json['profilePic'] as String;

Map<String, dynamic> _$SearchUsers$Query$UserToJson(
        SearchUsers$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'followState': instance.followState,
      'profilePic': instance.profilePic,
    };

SearchUsers$Query _$SearchUsers$QueryFromJson(Map<String, dynamic> json) =>
    SearchUsers$Query()
      ..searchUsers = (json['searchUsers'] as List<dynamic>)
          .map(
              (e) => SearchUsers$Query$User.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchUsers$QueryToJson(SearchUsers$Query instance) =>
    <String, dynamic>{
      'searchUsers': instance.searchUsers.map((e) => e.toJson()).toList(),
    };

SearchForUsersToAddToEvent$Query$User
    _$SearchForUsersToAddToEvent$Query$UserFromJson(
            Map<String, dynamic> json) =>
        SearchForUsersToAddToEvent$Query$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic> _$SearchForUsersToAddToEvent$Query$UserToJson(
        SearchForUsersToAddToEvent$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'profilePic': instance.profilePic,
    };

SearchForUsersToAddToEvent$Query _$SearchForUsersToAddToEvent$QueryFromJson(
        Map<String, dynamic> json) =>
    SearchForUsersToAddToEvent$Query()
      ..searchForUsersToAddToEvent =
          (json['searchForUsersToAddToEvent'] as List<dynamic>)
              .map((e) => SearchForUsersToAddToEvent$Query$User.fromJson(
                  e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$SearchForUsersToAddToEvent$QueryToJson(
        SearchForUsersToAddToEvent$Query instance) =>
    <String, dynamic>{
      'searchForUsersToAddToEvent':
          instance.searchForUsersToAddToEvent.map((e) => e.toJson()).toList(),
    };

LocationDetailsFromCoords$Query _$LocationDetailsFromCoords$QueryFromJson(
        Map<String, dynamic> json) =>
    LocationDetailsFromCoords$Query()
      ..locationDetailsFromCoords = json['locationDetailsFromCoords'] as String;

Map<String, dynamic> _$LocationDetailsFromCoords$QueryToJson(
        LocationDetailsFromCoords$Query instance) =>
    <String, dynamic>{
      'locationDetailsFromCoords': instance.locationDetailsFromCoords,
    };

CoordinatesInput _$CoordinatesInputFromJson(Map<String, dynamic> json) =>
    CoordinatesInput(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinatesInputToJson(CoordinatesInput instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

GetEventGuests$Query$PaginatedEventUsersResults$User
    _$GetEventGuests$Query$PaginatedEventUsersResults$UserFromJson(
            Map<String, dynamic> json) =>
        GetEventGuests$Query$PaginatedEventUsersResults$User()
          ..id = json['id'] as int
          ..username = json['username'] as String
          ..name = json['name'] as String
          ..profilePic = json['profilePic'] as String;

Map<String, dynamic>
    _$GetEventGuests$Query$PaginatedEventUsersResults$UserToJson(
            GetEventGuests$Query$PaginatedEventUsersResults$User instance) =>
        <String, dynamic>{
          'id': instance.id,
          'username': instance.username,
          'name': instance.name,
          'profilePic': instance.profilePic,
        };

GetEventGuests$Query$PaginatedEventUsersResults
    _$GetEventGuests$Query$PaginatedEventUsersResultsFromJson(
            Map<String, dynamic> json) =>
        GetEventGuests$Query$PaginatedEventUsersResults()
          ..users = (json['users'] as List<dynamic>)
              .map((e) =>
                  GetEventGuests$Query$PaginatedEventUsersResults$User.fromJson(
                      e as Map<String, dynamic>))
              .toList()
          ..hasMore = json['hasMore'] as bool;

Map<String, dynamic> _$GetEventGuests$Query$PaginatedEventUsersResultsToJson(
        GetEventGuests$Query$PaginatedEventUsersResults instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
    };

GetEventGuests$Query _$GetEventGuests$QueryFromJson(
        Map<String, dynamic> json) =>
    GetEventGuests$Query()
      ..getEventGuests =
          GetEventGuests$Query$PaginatedEventUsersResults.fromJson(
              json['getEventGuests'] as Map<String, dynamic>);

Map<String, dynamic> _$GetEventGuests$QueryToJson(
        GetEventGuests$Query instance) =>
    <String, dynamic>{
      'getEventGuests': instance.getEventGuests.toJson(),
    };

UpdateUserArguments _$UpdateUserArgumentsFromJson(Map<String, dynamic> json) =>
    UpdateUserArguments(
      input: UpdateUserInput.fromJson(json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateUserArgumentsToJson(
        UpdateUserArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

SaveDeviceArguments _$SaveDeviceArgumentsFromJson(Map<String, dynamic> json) =>
    SaveDeviceArguments(
      token: json['token'] as String,
    );

Map<String, dynamic> _$SaveDeviceArgumentsToJson(
        SaveDeviceArguments instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

ScanPassArguments _$ScanPassArgumentsFromJson(Map<String, dynamic> json) =>
    ScanPassArguments(
      eventId: json['eventId'] as int,
      cypherText: json['cypherText'] as String,
    );

Map<String, dynamic> _$ScanPassArgumentsToJson(ScanPassArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'cypherText': instance.cypherText,
    };

AddOrRemoveUserArguments _$AddOrRemoveUserArgumentsFromJson(
        Map<String, dynamic> json) =>
    AddOrRemoveUserArguments(
      followUserId: json['followUserId'] as int,
      isFollow: json['isFollow'] as bool,
    );

Map<String, dynamic> _$AddOrRemoveUserArgumentsToJson(
        AddOrRemoveUserArguments instance) =>
    <String, dynamic>{
      'followUserId': instance.followUserId,
      'isFollow': instance.isFollow,
    };

NewEventArguments _$NewEventArgumentsFromJson(Map<String, dynamic> json) =>
    NewEventArguments(
      input: NewEventInput.fromJson(json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewEventArgumentsToJson(NewEventArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

LeaveEventArguments _$LeaveEventArgumentsFromJson(Map<String, dynamic> json) =>
    LeaveEventArguments(
      eventId: json['eventId'] as int,
    );

Map<String, dynamic> _$LeaveEventArgumentsToJson(
        LeaveEventArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
    };

UpdateEventArguments _$UpdateEventArgumentsFromJson(
        Map<String, dynamic> json) =>
    UpdateEventArguments(
      input: UpdateEventInput.fromJson(json['input'] as Map<String, dynamic>),
      eventId: json['eventId'] as int,
    );

Map<String, dynamic> _$UpdateEventArgumentsToJson(
        UpdateEventArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
      'eventId': instance.eventId,
    };

InviteGuestsAndOrganizersArguments _$InviteGuestsAndOrganizersArgumentsFromJson(
        Map<String, dynamic> json) =>
    InviteGuestsAndOrganizersArguments(
      guests: (json['guests'] as List<dynamic>).map((e) => e as int).toList(),
      organizers:
          (json['organizers'] as List<dynamic>).map((e) => e as int).toList(),
      eventId: json['eventId'] as int,
    );

Map<String, dynamic> _$InviteGuestsAndOrganizersArgumentsToJson(
        InviteGuestsAndOrganizersArguments instance) =>
    <String, dynamic>{
      'guests': instance.guests,
      'organizers': instance.organizers,
      'eventId': instance.eventId,
    };

SignInArguments _$SignInArgumentsFromJson(Map<String, dynamic> json) =>
    SignInArguments(
      input: SignInInput.fromJson(json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInArgumentsToJson(SignInArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

AcceptInvitationArguments _$AcceptInvitationArgumentsFromJson(
        Map<String, dynamic> json) =>
    AcceptInvitationArguments(
      eventId: json['eventId'] as int,
    );

Map<String, dynamic> _$AcceptInvitationArgumentsToJson(
        AcceptInvitationArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
    };

DeleteEventArguments _$DeleteEventArgumentsFromJson(
        Map<String, dynamic> json) =>
    DeleteEventArguments(
      eventId: json['eventId'] as int,
    );

Map<String, dynamic> _$DeleteEventArgumentsToJson(
        DeleteEventArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
    };

AddGuestsArguments _$AddGuestsArgumentsFromJson(Map<String, dynamic> json) =>
    AddGuestsArguments(
      eventId: json['eventId'] as int,
      userIds: (json['userIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$AddGuestsArgumentsToJson(AddGuestsArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'userIds': instance.userIds,
    };

RemoveGuestsArguments _$RemoveGuestsArgumentsFromJson(
        Map<String, dynamic> json) =>
    RemoveGuestsArguments(
      eventId: json['eventId'] as int,
      userIds: (json['userIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$RemoveGuestsArgumentsToJson(
        RemoveGuestsArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'userIds': instance.userIds,
    };

UserFromIdArguments _$UserFromIdArgumentsFromJson(Map<String, dynamic> json) =>
    UserFromIdArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$UserFromIdArgumentsToJson(
        UserFromIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

MutualFriendsArguments _$MutualFriendsArgumentsFromJson(
        Map<String, dynamic> json) =>
    MutualFriendsArguments(
      id: json['id'] as int,
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MutualFriendsArgumentsToJson(
        MutualFriendsArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

LocationDetailsArguments _$LocationDetailsArgumentsFromJson(
        Map<String, dynamic> json) =>
    LocationDetailsArguments(
      placeID: json['placeID'] as String,
    );

Map<String, dynamic> _$LocationDetailsArgumentsToJson(
        LocationDetailsArguments instance) =>
    <String, dynamic>{
      'placeID': instance.placeID,
    };

SeePassArguments _$SeePassArgumentsFromJson(Map<String, dynamic> json) =>
    SeePassArguments(
      eventId: json['eventId'] as int,
    );

Map<String, dynamic> _$SeePassArgumentsToJson(SeePassArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
    };

GetUserEventsFromFriendsArguments _$GetUserEventsFromFriendsArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetUserEventsFromFriendsArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$GetUserEventsFromFriendsArgumentsToJson(
        GetUserEventsFromFriendsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

MyFriendsArguments _$MyFriendsArgumentsFromJson(Map<String, dynamic> json) =>
    MyFriendsArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MyFriendsArgumentsToJson(MyFriendsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

GetUserEventsArguments _$GetUserEventsArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetUserEventsArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$GetUserEventsArgumentsToJson(
        GetUserEventsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

GetEventHostsArguments _$GetEventHostsArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetEventHostsArguments(
      eventId: json['eventId'] as int,
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$GetEventHostsArgumentsToJson(
        GetEventHostsArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

SearchLocationArguments _$SearchLocationArgumentsFromJson(
        Map<String, dynamic> json) =>
    SearchLocationArguments(
      search: json['search'] as String,
    );

Map<String, dynamic> _$SearchLocationArgumentsToJson(
        SearchLocationArguments instance) =>
    <String, dynamic>{
      'search': instance.search,
    };

AddedMeArguments _$AddedMeArgumentsFromJson(Map<String, dynamic> json) =>
    AddedMeArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$AddedMeArgumentsToJson(AddedMeArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

GetUserOtherEventsArguments _$GetUserOtherEventsArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetUserOtherEventsArguments(
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$GetUserOtherEventsArgumentsToJson(
        GetUserOtherEventsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'idsList': instance.idsList,
    };

GetFollowStateArguments _$GetFollowStateArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetFollowStateArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$GetFollowStateArgumentsToJson(
        GetFollowStateArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SearchUsersArguments _$SearchUsersArgumentsFromJson(
        Map<String, dynamic> json) =>
    SearchUsersArguments(
      search: json['search'] as String,
      userSearching: json['userSearching'] as int,
    );

Map<String, dynamic> _$SearchUsersArgumentsToJson(
        SearchUsersArguments instance) =>
    <String, dynamic>{
      'search': instance.search,
      'userSearching': instance.userSearching,
    };

SearchForUsersToAddToEventArguments
    _$SearchForUsersToAddToEventArgumentsFromJson(Map<String, dynamic> json) =>
        SearchForUsersToAddToEventArguments(
          search: json['search'] as String,
          eventId: json['eventId'] as int,
        );

Map<String, dynamic> _$SearchForUsersToAddToEventArgumentsToJson(
        SearchForUsersToAddToEventArguments instance) =>
    <String, dynamic>{
      'search': instance.search,
      'eventId': instance.eventId,
    };

LocationDetailsFromCoordsArguments _$LocationDetailsFromCoordsArgumentsFromJson(
        Map<String, dynamic> json) =>
    LocationDetailsFromCoordsArguments(
      coords: CoordinatesInput.fromJson(json['coords'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationDetailsFromCoordsArgumentsToJson(
        LocationDetailsFromCoordsArguments instance) =>
    <String, dynamic>{
      'coords': instance.coords.toJson(),
    };

GetEventGuestsArguments _$GetEventGuestsArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetEventGuestsArguments(
      eventId: json['eventId'] as int,
      limit: json['limit'] as int,
      idsList: (json['idsList'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$GetEventGuestsArgumentsToJson(
        GetEventGuestsArguments instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'limit': instance.limit,
      'idsList': instance.idsList,
    };
