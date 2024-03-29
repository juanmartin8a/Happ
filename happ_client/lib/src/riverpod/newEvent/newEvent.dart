import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/newEvent/newEventState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class NewEventController extends StateNotifier<NewEventState> {

  NewEventController() : super(NewEventInitState());

  EventRepo get eventRepo => EventRepo();

  void newEvent(
    String name,
    String description,
    String eventDate, 
    List<http.MultipartFile> eventPics,
    List<http.MultipartFile> eventPicsLight,
    double latitude,
    double longitude,
    String eventPlace,
  ) async {
    state = NewEventLoadingState();
    try {
      final res = await eventRepo.newEvent(name, description, eventDate, eventPics, eventPicsLight, latitude, longitude, eventPlace);
      state = NewEventDoneState(newEventRes: res);
    } catch (e) {
      debugPrint("error in newEvent: $e");
      state = NewEventErrorState();
    }
  }
}

final newEventProvider =
  StateNotifierProvider<NewEventController, NewEventState>((ref) => NewEventController());