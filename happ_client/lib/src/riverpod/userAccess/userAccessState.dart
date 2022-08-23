import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class UserAccessState extends Equatable {
  const UserAccessState();

  @override
  List<Object?> get props => [];
}

class UserAccessInitState extends UserAccessState {}

class UserAccessDeniedState extends UserAccessState {}

class UserAccessGrantedState extends UserAccessState {
  final UserAccess$Query$User user;

  const UserAccessGrantedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UserAccessLoadingState extends UserAccessState {}