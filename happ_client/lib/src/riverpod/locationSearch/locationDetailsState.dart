import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class LocationDetailsState extends Equatable {
  const LocationDetailsState();

  @override
  List<Object?> get props => [];
}

class LocationDetailsInitState extends LocationDetailsState {}

class LocationDetailsLoadedState extends LocationDetailsState {
  final bool error;
  final LocationDetails$Query$EventCoordinates? details;
  final String? name;

  const LocationDetailsLoadedState({
    required this.error,
    required this.details,
    this.name
  });

  @override
  List<Object?> get props => [error, details, name];
}

class MarkLocationLoadedState extends LocationDetailsState {
  final Map<String, dynamic> details;

  const MarkLocationLoadedState({
    required this.details,
  });

  @override
  List<Object?> get props => [details];
}