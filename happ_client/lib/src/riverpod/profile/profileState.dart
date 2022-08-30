import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserFromId$Query$User user;

  const ProfileLoadedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class ProfileErrorState extends ProfileState {}