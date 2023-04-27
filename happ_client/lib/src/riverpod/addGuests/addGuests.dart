import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuestsState.dart';

class AddGuests extends StateNotifier<AddGuestsState> {

  AddGuests() : super(AddGuestsInitState());

  EventRepo get eventRepo => EventRepo();

  void addGuests(
    List<int> guests,
    int eventId
  ) async {
    state = AddGuestsLoadingState();
    try {
      final res = await eventRepo.addGuests(guests, eventId);
      state = AddGuestsDoneState(res: res.addGuests!);
    } catch(e) {
      print("errorrrrr");
      print(e);
      state = AddGuestsErrorState();
    }
  }
}

final addGuestsProvider =
  StateNotifierProvider<AddGuests, AddGuestsState>(
    (ref) => AddGuests()
  );