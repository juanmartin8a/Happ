import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart' as latLng;

abstract class NewEventCompleteState extends Equatable {
  const NewEventCompleteState();

  @override
  List<Object?> get props => [];
}

class NewEventCompleteInitState extends NewEventCompleteState {}

class NewEventCompleteFieldsState extends NewEventCompleteState {
  final String? name;
  final String? description;
  final List<MultipartFile>? eventPics;
  final List<MultipartFile>? lightEventPics;
  final DateTime? date;
  final DateTime? time;
  final latLng.LatLng? location;
  final String? eventPlace;
  final List<int>? guests;
  final List<int>? organizers;
  final int? eventId;

  const NewEventCompleteFieldsState({
    this.name,
    this.description,
    this.eventPics,
    this.lightEventPics,
    this.date,
    this.time,
    this.location,
    this.eventPlace,
    this.guests,
    this.organizers,
    this.eventId,
  });

  @override
  List<Object?> get props => [
    name, description, eventPics, lightEventPics, date, time, location, eventPlace, guests, organizers, eventId
  ];
}