import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class UserEventState extends Equatable {
  const UserEventState();

  @override
  List<Object?> get props => [];
}

class UserEventsInitStateState extends UserEventState {}

class UserEventsLoadingState extends UserEventState {}

class UserEventsLoadedState extends UserEventState {
  final GetUserEvents$Query$PaginatedEventResults res;
  final bool isRefresh;

  const UserEventsLoadedState({
    required this.res,
    this.isRefresh = false
  });

  @override
  List<Object?> get props => [res, isRefresh];
}

class UserEventsFromFriendsLoadedState extends UserEventState {
  final GetUserEventsFromFriends$Query$PaginatedEventResults res;
  final bool isRefresh;

  const UserEventsFromFriendsLoadedState({
    required this.res,
    this.isRefresh = false
  });

  @override
  List<Object?> get props => [res, isRefresh];
}

class UserEventsFromFriendsRefreshedState extends UserEventState {
  final GetUserEventsFromFriends$Query$PaginatedEventResults res;

  const UserEventsFromFriendsRefreshedState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class UserOtherEventsLoadedState extends UserEventState {
  final GetUserOtherEvents$Query$PaginatedEventResults res;
  final bool isRefresh;

  const UserOtherEventsLoadedState({
    required this.res,
    this.isRefresh = false
  });

  @override
  List<Object?> get props => [res, isRefresh];
}

class UserOtherEventsRefreshedState extends UserEventState {
  final GetUserOtherEvents$Query$PaginatedEventResults res;

  const UserOtherEventsRefreshedState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class UpdateOtherEvents extends UserEventState {
  final GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes? inviteRes;
  final GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes$Event? event;
  final String actionPerformed;

  const UpdateOtherEvents({
    this.inviteRes,
    this.event,
    required this.actionPerformed
  });

  @override
  List<Object?> get props => [inviteRes, event, actionPerformed];
}

class UpdateFriendsEvents extends UserEventState {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes? inviteRes;
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event? event;
  final String actionPerformed;

  const UpdateFriendsEvents({
    this.inviteRes,
    this.event,
    required this.actionPerformed
  });

  @override
  List<Object?> get props => [inviteRes, event, actionPerformed];
}

class UpdateUserEvents extends UserEventState {
  final GetUserEvents$Query$PaginatedEventResults$EventInviteRes? inviteRes;
  final GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event? event;
  final String actionPerformed;

  const UpdateUserEvents({
    this.inviteRes,
    this.event,
    required this.actionPerformed,
  });

  @override
  List<Object?> get props => [inviteRes, actionPerformed, event];
}