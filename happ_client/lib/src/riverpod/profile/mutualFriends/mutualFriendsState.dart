import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class MutualFriends extends Equatable {
  const MutualFriends();

  @override
  List<Object?> get props => [];
}

class MutualFriendsInitState extends MutualFriends {}

class MutualFriendsLoadingState extends MutualFriends {}

class MutualFriendsLoadedState extends MutualFriends {
  final MutualFriends$Query$PaginatedEventUsersResults val;

  const MutualFriendsLoadedState({
    required this.val,
  });

  @override
  List<Object?> get props => [val];
}

class MutualFriendsChangeFollowState extends MutualFriends {
  final MutualFriends$Query$PaginatedEventUsersResults$User user;
  final bool followState;

  const MutualFriendsChangeFollowState({
    required this.user,
    required this.followState
  });

  @override
  List<Object?> get props => [user, followState];
}

class MutualFriendsErrorState extends MutualFriends {}