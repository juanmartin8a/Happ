import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class MyFriendsState extends Equatable {
  const MyFriendsState();

  @override
  List<Object?> get props => [];
}

class MyFriendsInitState extends MyFriendsState {}

class MyFriendsLoadingState extends MyFriendsState {}

class MyFriendsLoadedState extends MyFriendsState {
  final MyFriends$Query$PaginatedEventUsersResults val;

  const MyFriendsLoadedState({
    required this.val,
  });

  @override
  List<Object?> get props => [val];
}

class MyFriendsErrorState extends MyFriendsState {}