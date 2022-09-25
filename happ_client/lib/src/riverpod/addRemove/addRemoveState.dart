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
  final String operationId;

  const AddRemoveAddState({
    required this.res,
    required this.operationId,
  });

  @override
  List<Object?> get props => [res, operationId];
}

class AddRemoveRemoveState extends AddRemoveState {
  final AddOrRemoveUser$Mutation$AddResponse res;
  final String operationId;

  const AddRemoveRemoveState({
    required this.res,
    required this.operationId,
  });

  @override
  List<Object?> get props => [res];
}

class AddRemoveErrorState extends AddRemoveState {}