import 'package:happ_client/src/riverpod/newEventComplete/newEventCompleteState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:latlong2/latlong.dart' as latLng;

class NewEventCompleteController extends StateNotifier<NewEventCompleteState> {

  NewEventCompleteController() : super(NewEventCompleteInitState());

  void fieldChange({
    String? name,
    String? description,
    List<MultipartFile>? eventPics, 
    DateTime? date,
    DateTime? time,
    latLng.LatLng? location
  }) {
    state = NewEventCompleteFieldsState(
      name: name,
      description: description,
      eventPics: eventPics,
      date: date,
      time: time,
      location: location,
    );
  }
}

final newEventCompleteProvider =
  StateNotifierProvider<NewEventCompleteController, NewEventCompleteState>((ref) => NewEventCompleteController());