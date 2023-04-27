import 'package:happ_client/src/api/graphql/graphql_api.dart';

class EventTypesConverter {

  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes convertOtherInviteResToFriendsInviteRes(inviteRes) {
    var inviteResToJson = inviteRes.toJson();
    var newInviteRes = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResToJson);

    return newInviteRes;
  }

  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event convertEventToFriendsEvent(event) {
    var eventToJson = event.toJson();
    var newEvent = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(eventToJson);

    return newEvent;
  }

  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User convertOtherInvitedByToFriendsinvitedBy(user) {
    var userToJson = user.toJson();
    var newUser = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$User.fromJson(userToJson);

    return newUser;
  }

  GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo convertOtherUserInfoToFriendsUserInfo(userInfo) {
    var userInfoToJson = userInfo.toJson();
    var newUserInfo = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo.fromJson(userInfoToJson);

    return newUserInfo;
  }

}