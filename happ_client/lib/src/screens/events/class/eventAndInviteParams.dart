import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventParams {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes inviteRes;
  const EventParams({
    required this.inviteRes,
  });
}

class InviteParams {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event;
  final String? cypherText;
  const InviteParams({
    required this.event,
    required this.cypherText,
  });
}

class EventGuestListParams {
  final int eventId;
  final bool isHost;
  final bool isCreator;
  final GetEventHosts$Query$PaginatedEventUsersResults paginatedHostsRes;
  final GetEventGuests$Query$PaginatedEventUsersResults paginatedGuestsRes;
  const EventGuestListParams({
    required this.eventId,
    required this.isHost,
    required this.isCreator,
    required this.paginatedHostsRes,
    required this.paginatedGuestsRes,
  });
}

class InviteGuestsScreenParams {
  final int eventId;
  const InviteGuestsScreenParams({
    required this.eventId,
  });
}

// class EventAndInviteParams {
//   final GetUserOtherEvents$Query$EventInviteRes$Event event;
//   final GetUserOtherEvents$Query$EventInviteRes$User invitedBy;
//   const EventAndInviteParams({
//     required this.event,
//     required this.invitedBy,
//   });
// }