import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

class UpdateUserInitState extends UpdateUserState {}

class UpdateUserLoadingState extends UpdateUserState {}

class UpdateUserDoneState extends UpdateUserState {
  final UpdateUser$Mutation$UpdateUserResponse updateUserRes;

  const UpdateUserDoneState({
    required this.updateUserRes,
  });

  @override
  List<Object?> get props => [updateUserRes];
}

class UpdateUserErrorState extends UpdateUserState {}