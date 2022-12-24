import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
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
  final DateTime? date;
  final DateTime? time;
  final latLng.LatLng? location;

  const NewEventCompleteFieldsState({
    this.name,
    this.description,
    this.eventPics,
    this.date,
    this.time,
    this.location
  });

  @override
  List<Object?> get props => [name, description, eventPics, date, time, location];
}