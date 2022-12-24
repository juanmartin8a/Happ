import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class NewEventState extends Equatable {
  const NewEventState();

  @override
  List<Object?> get props => [];
}

class NewEventInitState extends NewEventState {}

class NewEventLoadingState extends NewEventState {}

class NewEventDoneState extends NewEventState {
  final NewEvent$Mutation$CreateEventResponse newEventRes;

  const NewEventDoneState({
    required this.newEventRes,
  });

  @override
  List<Object?> get props => [newEventRes];
}