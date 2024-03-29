import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuestsState.dart';

class EventGuestsController extends StateNotifier<EventGuestsState> {

  EventGuestsController() : super(EventGuestsInitState());

  EventRepo get eventRepo => EventRepo();

  void getEventGuests(
    int eventId,
    int limit, 
    List<int> idsList
  ) async {
    state = EventGuestsLoadingState();
    try {
      final res = await eventRepo.getEventGuests(eventId, limit, idsList);
      state = GetEventGuestsDoneState(res: res);
    } catch (e) {
      debugPrint("error in getEventGuests: $e");
      state = EventGuestsErrorState();
    }
  }

  void removeGuests(
    List<int> userIds,
  ) {

    state = GetEventGuestsRemoveState(userIds: userIds);

  }
}

final eventGuestsProvider =
  StateNotifierProvider<EventGuestsController, EventGuestsState>((ref) => EventGuestsController());