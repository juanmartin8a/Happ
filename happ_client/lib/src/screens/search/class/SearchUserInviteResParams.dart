import 'package:happ_client/src/api/graphql/graphql_api.dart';

class NewEventInvitedFriendsListParams {
  final int eventId;
  final List<SearchUsers$Query$User> selectedUsers;
  final List<SearchUsers$Query$User> organizers;
  const NewEventInvitedFriendsListParams({
    required this.eventId,
    required this.selectedUsers,
    required this.organizers
  });
}