import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class EventHostsState extends Equatable {

  @override
  List<Object?> get props => [];
}

class EventHostsInitState extends EventHostsState {}

class EventHostsLoadingState extends EventHostsState {}

class GetEventHostsDoneState extends EventHostsState {
  final GetEventHosts$Query$PaginatedEventUsersResults res;

  GetEventHostsDoneState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class GetEventHostsRemoveState extends EventHostsState {
  final List<int> userIds;

  GetEventHostsRemoveState({
    required this.userIds,
  });

  @override
  List<Object?> get props => [userIds];
}

class EventHostsErrorState extends EventHostsState {}