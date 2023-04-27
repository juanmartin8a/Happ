import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object?> get props => [];
}

class UserDataInitState extends UserDataState {}

class UserDataLoadingState extends UserDataState {}

class UserDataLoadedState extends UserDataState {
  final UserFromId$Query$User user;

  const UserDataLoadedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UserDataErrorState extends UserDataState {}