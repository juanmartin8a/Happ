import 'package:flutter/foundation.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/userEvents/userEventsState.dart';

class UserEvents extends StateNotifier<UserEventState> {

  UserEvents() : super(UserEventsInitStateState());

  EventRepo get eventRepo => EventRepo();

  Future<bool> getUserEvents(int limit, List<int> idsList, {bool isRefresh = false}) async {
    state = UserEventsLoadingState();
    try {
      final res = await eventRepo.getEvents(limit, idsList);
      state = UserEventsLoadedState(res: res, isRefresh: isRefresh);
      return true;
    } catch (e) {
      debugPrint("error in getUserEvents: $e");
      return false;
    }
  }

  Future<GetUserEventsFromFriends$Query$PaginatedEventResults?> getUserEventsFromFriends(int limit, List<int> idsList, {bool isRefresh = false}) async {
    if (!isRefresh) {
      state = UserEventsLoadingState();
    }
    try {
      final res = await eventRepo.getEventsFromFriends(limit, idsList);
      // final newRes = EventTypesConverter().convertToGetUserEvents(res);
      if (!isRefresh) {
        state = UserEventsFromFriendsLoadedState(res: res, isRefresh: isRefresh);
      }
      return res;
    } catch (e) {
      debugPrint("error in getUserEventsFromFriends: $e");
      return null;
    }
  }

  void refreshEventsFromFriends(GetUserEventsFromFriends$Query$PaginatedEventResults invitations) async {
    state = UserEventsFromFriendsRefreshedState(res: invitations);
  }

  Future<GetUserOtherEvents$Query$PaginatedEventResults?> getUserOtherEvents(int limit, List<int> idsList, {bool isRefresh = false}) async {
    if (!isRefresh) {
      state = UserEventsLoadingState();
    }
    try {
      final res = await eventRepo.getOtherEvents(limit, idsList);
      // final newRes = EventTypesConverter().convertToGetUserEvents(res);
      if (!isRefresh) {
        state = UserOtherEventsLoadedState(res: res, isRefresh: isRefresh);
      }
      return res;
    } catch (e) {
      debugPrint("error in getOtherUserEvents: $e");
      return null;
    }
  }

  void refreshOtherEvents(GetUserOtherEvents$Query$PaginatedEventResults invitations) async {
    state = UserOtherEventsRefreshedState(res: invitations);
  }

  void updateUserInfo(
    bool isFriends, 
    GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes inviteRes, 
    GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo newUserInfo
  ) async {
    Map<String, dynamic> inviteResJson = inviteRes.toJson();
    inviteResJson["invitedUserInfo"] = newUserInfo.toJson();

    if (isFriends) {
      GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes newInviteRes = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResJson);
      state = UpdateFriendsEvents(inviteRes: newInviteRes, actionPerformed: "updateUserInfo");
    } else {
      GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes newInviteRes = GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResJson);
      state = UpdateOtherEvents(inviteRes: newInviteRes, actionPerformed: "updateUserInfo");
    }
  }

  void insertIntoList(
    GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes inviteRes,
    String fromWho,
  ) {
    Map<String, dynamic> inviteResJson = inviteRes.toJson();

    switch (fromWho) {
      case "User":
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes newInviteRes = GetUserEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResJson);
        state = UpdateUserEvents(inviteRes: newInviteRes, actionPerformed: "insertIntoList");
        break;

      case "Friends":
        state = UpdateFriendsEvents(inviteRes: inviteRes, actionPerformed: "insertIntoList");
        break;

      case "Other":
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes newInviteRes = GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResJson);
        state = UpdateOtherEvents(inviteRes: newInviteRes, actionPerformed: "insertIntoList");
        break;
    }
  }

  void updateEvent(
    GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event,
    String fromWho,
  ) {

    Map<String, dynamic> eventJson = event.toJson();
    
    switch (fromWho) {
      case "User":
        GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event newEvent = GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(eventJson);
        state = UpdateUserEvents(event: newEvent, actionPerformed: "updateSingleEvent");
        break;

      case "Friends":
        state = UpdateFriendsEvents(event: event, actionPerformed: "updateSingleEvent");
        break;

      case "Other":
        Map<String, dynamic> eventJson = event.toJson();
        GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes newEvent = GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(eventJson);
        state = UpdateOtherEvents(inviteRes: newEvent, actionPerformed: "updateSingleEvent");
        break;
    }
  }
}