import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateEventState extends Equatable {
  const UpdateEventState();

  @override
  List<Object?> get props => [];
}

class UpdateEventInitState extends UpdateEventState {}

class UpdateEventLoadingState extends UpdateEventState {}

class UpdateEventDoneState extends UpdateEventState {
  final UpdateEvent$Mutation$CreateEventResponse updateEventRes;

  const UpdateEventDoneState({
    required this.updateEventRes,
  });

  @override
  List<Object?> get props => [updateEventRes];
}

class UpdateEventErrorState extends UpdateEventState {}