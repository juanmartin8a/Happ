import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class InviteUserSelectState extends Equatable {
  const InviteUserSelectState();

  @override
  List<Object?> get props => [];
}

class InviteUserSelectInitState extends InviteUserSelectState {}


class InviteUserSelectedState extends InviteUserSelectState {
  final SearchUsers$Query$User user;

  const InviteUserSelectedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class InviteUserRemoveState extends InviteUserSelectState {
  final int userId;

  const InviteUserRemoveState({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class MakeOrganizerState extends InviteUserSelectState {
  final SearchUsers$Query$User user;

  const MakeOrganizerState({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}

class RemoveOrganizerState extends InviteUserSelectState {
  final SearchUsers$Query$User user;

  const RemoveOrganizerState({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}


// For updating guest list

abstract class UInviteUserSelectState extends Equatable {
  const UInviteUserSelectState();

  @override
  List<Object?> get props => [];
}

class UInviteUserSelectInitState extends UInviteUserSelectState {}


class UInviteUserSelectedState extends UInviteUserSelectState {
  final SearchForUsersToAddToEvent$Query$User user;

  const UInviteUserSelectedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UInviteUserRemoveState extends UInviteUserSelectState {
  final int userId;

  const UInviteUserRemoveState({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class UMakeOrganizerState extends UInviteUserSelectState {
  final SearchForUsersToAddToEvent$Query$User user;

  const UMakeOrganizerState({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}

class URemoveOrganizerState extends UInviteUserSelectState {
  final SearchForUsersToAddToEvent$Query$User user;

  const URemoveOrganizerState({
    required this.user
  });

  @override
  List<Object?> get props => [user];
}