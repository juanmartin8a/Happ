import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/eventHosts/eventHostsState.dart';

class EventHostsController extends StateNotifier<EventHostsState> {

  EventHostsController() : super(EventHostsInitState());

  EventRepo get eventRepo => EventRepo();

  void getEventHosts(
    int eventId,
    int limit, 
    List<int> idsList
  ) async {
    state = EventHostsLoadingState();
    try {
      // print("helloooooo");
      final res = await eventRepo.getEventHosts(eventId, limit, idsList);
      // final newRes = EventTypesConverter().convertToGetUserEvents(res);
      state = GetEventHostsDoneState(res: res);
    } catch (e) {
      print("erroraaaaa");
      state = EventHostsErrorState();
    }
    // state = AddPicturesDoneState(imageList: imageList);
  }
}

final eventHostsProvider =
  StateNotifierProvider<EventHostsController, EventHostsState>((ref) => EventHostsController());