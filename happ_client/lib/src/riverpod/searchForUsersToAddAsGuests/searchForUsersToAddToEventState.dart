import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class SearchForUsersToAddToEventState extends Equatable {
  const SearchForUsersToAddToEventState();

  @override
  List<Object?> get props => [];
}

class SearchForUsersToAddToEventInitState extends SearchForUsersToAddToEventState {
  final String uuid;
  const SearchForUsersToAddToEventInitState._({
    required this.uuid
  });

  factory SearchForUsersToAddToEventInitState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return SearchForUsersToAddToEventInitState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}

class SearchForUsersToAddToEventLoadingState extends SearchForUsersToAddToEventState {}

class SearchForUsersToAddToEventLoadedState extends SearchForUsersToAddToEventState {
  final List<SearchForUsersToAddToEvent$Query$User> searchUsersRes;

  const SearchForUsersToAddToEventLoadedState({
    required this.searchUsersRes,
  });

  @override
  List<Object?> get props => [searchUsersRes];
}

class SearchForUsersToAddToEventErrorState extends SearchForUsersToAddToEventState {}