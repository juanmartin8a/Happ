import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/removeGuests/removeGuestsState.dart';

class RemoveGuests extends StateNotifier<RemoveGuestsState> {

  RemoveGuests() : super(RemoveGuestsInitState());

  EventRepo get eventRepo => EventRepo();

  void removeGuests(
    List<int> guests,
    int eventId
  ) async {
    state = RemoveGuestsLoadingState();
    try {
      final res = await eventRepo.removeGuests(guests, eventId);
      state = RemoveGuestsDoneState(res: res.removeGuests!, eventId: eventId, deletedEventUsers: guests.length);
    } catch(e) {
      debugPrint("error in removeGuests: $e");
      state = RemoveGuestsErrorState();
    }
  }
}

final removeGuestsProvider =
  StateNotifierProvider<RemoveGuests, RemoveGuestsState>(
    (ref) => RemoveGuests()
  );