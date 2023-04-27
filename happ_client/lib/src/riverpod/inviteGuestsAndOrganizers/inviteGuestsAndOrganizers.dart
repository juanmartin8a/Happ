import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/inviteGuestsAndOrganizers/inviteGuestsAndOrganizersState.dart';

class InviteGuestsAndOrganizersController extends StateNotifier<InviteGuestsAndOrganizersState> {

  InviteGuestsAndOrganizersController() : super(InviteGuestsAndOrganizersInitState());

  EventRepo get eventRepo => EventRepo();

  void inviteGuestsAndOrganizers(
    List<int> guests,
    List<int> organizers,
    int eventId
  ) async {
    state = InviteGuestsAndOrganizersLoadingState();
    try {
      final res = await eventRepo.inviteGuestsAndOrganizers(guests, organizers, eventId);
      state = InviteGuestsAndOrganizersDoneState(res: res.inviteGuestsAndOrganizers);
    } catch(e) {
      print("errorrrrr");
      print(e);
      state = InviteGuestsAndOrganizersErrorState();
    }
  }
}

final inviteGuestsAndOrganizersProvider =
  StateNotifierProvider<InviteGuestsAndOrganizersController, InviteGuestsAndOrganizersState>(
    (ref) => InviteGuestsAndOrganizersController()
  );