import 'package:flutter/foundation.dart';
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
      final res = await eventRepo.getEventHosts(eventId, limit, idsList);
      state = GetEventHostsDoneState(res: res);
    } catch (e) {
      debugPrint("error in getEventHosts: $e");
      state = EventHostsErrorState();
    }
  }

  void removeHosts(
    List<int> userIds,
  ) {
    state = GetEventHostsRemoveState(userIds: userIds);
  }
}

final eventHostsProvider =
  StateNotifierProvider<EventHostsController, EventHostsState>((ref) => EventHostsController());