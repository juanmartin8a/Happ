import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:latlong2/latlong.dart' as latLng;

abstract class EventUpdateReadyState extends Equatable {
  const EventUpdateReadyState();

  @override
  List<Object?> get props => [];
}

class EventUpdateReadyInitState extends EventUpdateReadyState {}

class EventUpdateReadyFieldsState extends EventUpdateReadyState {
  final String? name;
  final String? description;
  final List<UpdatePictureInput>? eventPics;
  final List<UpdatePictureInput>? lightEventPics;
  final DateTime? date;
  final DateTime? time;
  final latLng.LatLng? location;
  final String? eventPlace;

  const EventUpdateReadyFieldsState({
    this.name,
    this.description,
    this.eventPics,
    this.lightEventPics,
    this.date,
    this.time,
    this.location,
    this.eventPlace,
  });

  @override
  List<Object?> get props => [
    name, description, eventPics, lightEventPics, date, time, location
  ];
}