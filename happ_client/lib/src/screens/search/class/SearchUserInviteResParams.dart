import 'package:happ_client/src/api/graphql/graphql_api.dart';

class NewEventInvitedFriendsListParams {
  final int eventId;
  final List<SearchUsers$Query$User> selectedUsers;
  final List<SearchUsers$Query$User> organizers;
  const NewEventInvitedFriendsListParams({
    required this.eventId,
    required this.selectedUsers,
    required this.organizers,
  });
}

class NewGuestsListParams {
  final int eventId;
  final List<SearchForUsersToAddToEvent$Query$User> users;
  final List<SearchForUsersToAddToEvent$Query$User> organizers;
  final bool isCreator;
  const NewGuestsListParams({
    required this.eventId,
    required this.users,
    required this.organizers,
    this.isCreator = true,
  });
}