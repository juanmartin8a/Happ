import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<SearchUsers$Query$User> searchUsersRes;

  const SearchLoadedState({
    required this.searchUsersRes,
  });

  @override
  List<Object?> get props => [searchUsersRes];
}

class SearchErrorState extends SearchState {}