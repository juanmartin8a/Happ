import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class EventGuestsState extends Equatable {

  @override
  List<Object?> get props => [];
}

class EventGuestsInitState extends EventGuestsState {}

class EventGuestsLoadingState extends EventGuestsState {}

class GetEventGuestsDoneState extends EventGuestsState {
  final GetEventGuests$Query$PaginatedEventUsersResults res;

  GetEventGuestsDoneState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class GetEventGuestsRemoveState extends EventGuestsState {
  final List<int> userIds;

  GetEventGuestsRemoveState({
    required this.userIds,
  });

  @override
  List<Object?> get props => [userIds];
}

class EventGuestsErrorState extends EventGuestsState {}