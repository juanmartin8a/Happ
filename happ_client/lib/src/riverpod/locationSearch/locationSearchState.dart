import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class LocationSearchState extends Equatable {
  const LocationSearchState();

  @override
  List<Object?> get props => [];
}

class LocationSearchInitState extends LocationSearchState {}

class LocationSearchLoadedState extends LocationSearchState {
  final bool error;
  final List<SearchLocation$Query$LocationAutoCompletePrediction> predictions;
  final String search;

  const LocationSearchLoadedState({
    required this.error,
    required this.predictions,
    required this.search,
  });

  @override
  List<Object?> get props => [error, predictions, search];
}