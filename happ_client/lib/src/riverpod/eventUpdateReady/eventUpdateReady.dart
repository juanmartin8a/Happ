import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReadyState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' as latLng;

class EventUpdateReadyController extends StateNotifier<EventUpdateReadyState> {

  EventUpdateReadyController() : super(EventUpdateReadyInitState());

  void fieldChange({
    String? name,
    String? description,
    List<UpdatePictureInput>? eventPics, 
    List<UpdatePictureInput>? lightEventPics,
    DateTime? date,
    DateTime? time,
    latLng.LatLng? location,
    String? eventPlace,
  }) {
    state = EventUpdateReadyFieldsState(
      name: name,
      description: description,
      eventPics: eventPics,
      lightEventPics: lightEventPics,
      date: date,
      time: time,
      location: location,
      eventPlace: eventPlace,
    );
  }
}

final eventUpdateReadyControllerProvider =
  StateNotifierProvider<EventUpdateReadyController, EventUpdateReadyState>((ref) => EventUpdateReadyController());