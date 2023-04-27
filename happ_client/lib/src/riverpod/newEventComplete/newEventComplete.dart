import 'package:happ_client/src/riverpod/newEventComplete/newEventCompleteState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart' as latLng;

class NewEventCompleteController extends StateNotifier<NewEventCompleteState> {

  NewEventCompleteController() : super(NewEventCompleteInitState());

  void fieldChange({
    String? name,
    String? description,
    List<MultipartFile>? eventPics, 
    List<MultipartFile>? lightEventPics,
    DateTime? date,
    DateTime? time,
    latLng.LatLng? location,
    String? eventPlace,
    List<int>? guests,
    List<int>? organizers,
    int? eventId,
  }) {
    state = NewEventCompleteFieldsState(
      name: name,
      description: description,
      eventPics: eventPics,
      lightEventPics: lightEventPics,
      date: date,
      time: time,
      location: location,
      eventPlace: eventPlace,
      guests: guests,
      organizers: organizers,
      eventId: eventId
    );
  }
}

final newEventCompleteProvider =
  StateNotifierProvider<NewEventCompleteController, NewEventCompleteState>((ref) => NewEventCompleteController());