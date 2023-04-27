import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class SearchForUsersToAddAsGuestsState extends Equatable {
  const SearchForUsersToAddAsGuestsState();

  @override
  List<Object?> get props => [];
}

class SearchForUsersToAddAsGuestsInitState extends SearchForUsersToAddAsGuestsState {
  final String uuid;
  const SearchForUsersToAddAsGuestsInitState._({
    required this.uuid
  });

  factory SearchForUsersToAddAsGuestsInitState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return SearchForUsersToAddAsGuestsInitState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}

class SearchForUsersToAddAsGuestsLoadingState extends SearchForUsersToAddAsGuestsState {}

class SearchForUsersToAddAsGuestsLoadedState extends SearchForUsersToAddAsGuestsState {
  final List<SearchForUsersToAddAsGuests$Query$User> searchUsersRes;

  const SearchForUsersToAddAsGuestsLoadedState({
    required this.searchUsersRes,
  });

  @override
  List<Object?> get props => [searchUsersRes];
}

class SearchForUsersToAddAsGuestsErrorState extends SearchForUsersToAddAsGuestsState {}