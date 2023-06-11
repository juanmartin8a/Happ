import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/screens/profile/profile.dart';

class ProfileParams {
  final ProfileUserData user;
  const ProfileParams({
    required this.user,
  });
}

class AddedMeParams {
  final List<AddedMe$Query$PaginatedEventUsersResults$User> addedMeUsers;
  final bool hasMore;
  final String uuid;
  const AddedMeParams({
    required this.addedMeUsers,
    required this.hasMore,
    required this.uuid
  });
}

class MyFriendsParams {
  final List<MyFriends$Query$PaginatedEventUsersResults$User> users;
  final bool hasMore;
  final String uuid;
  const MyFriendsParams({
    required this.users,
    required this.hasMore,
    required this.uuid
  });
}

class MutualFriendsParams {
  final int userId;
  final List<MutualFriends$Query$PaginatedEventUsersResults$User> users;
  final bool hasMore;
  final String uuid;
  const MutualFriendsParams({
    required this.userId,
    required this.users,
    required this.hasMore,
    required this.uuid
  });
}