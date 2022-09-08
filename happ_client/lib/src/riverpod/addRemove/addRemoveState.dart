import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class AddRemoveState extends Equatable {
  const AddRemoveState();

  @override
  List<Object?> get props => [];
}

class AddRemoveInitState extends AddRemoveState {}

// class AddRemoveLoadingState extends AddRemoveState {}

class AddRemoveAddState extends AddRemoveState {
  final AddOrRemoveUser$Mutation$AddResponse res;

  const AddRemoveAddState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class AddRemoveRemoveState extends AddRemoveState {
  final AddOrRemoveUser$Mutation$AddResponse res;

  const AddRemoveRemoveState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class AddRemoveErrorState extends AddRemoveState {}