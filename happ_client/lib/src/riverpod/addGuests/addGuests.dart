import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuestsState.dart';

class AddGuests extends StateNotifier<AddGuestsState> {

  AddGuests() : super(AddGuestsInitState());

  EventRepo get eventRepo => EventRepo();

  void addGuests(
    List<int> guests,
    List<int> organizers,
    int eventId
  ) async {
    state = AddGuestsLoadingState();
    try {
      final res = await eventRepo.inviteGuestsAndOrganizers(guests, organizers, eventId);
      state = AddGuestsDoneState(res: res.inviteGuestsAndOrganizers);
    } catch(e) {
      debugPrint("error in addGuests: $e");
      state = AddGuestsErrorState();
    }
  }
}

final addGuestsProvider =
  StateNotifierProvider<AddGuests, AddGuestsState>(
    (ref) => AddGuests()
  );