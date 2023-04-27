import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/acceptInvitation/acceptInvitationState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcceptInvitationController extends StateNotifier<AcceptInvitationState> {

  AcceptInvitationController() : super(AcceptInvitationInitState());

  EventRepo get eventRepo => EventRepo();

  void acceptInvitation(int eventId) async {
    state = AcceptInvitationLoadingState();
    try {
      final res = await eventRepo.acceptInvitation(eventId);
      print(res);
      state = AcceptInvitationDoneState(acceptInviteRes: res);
      // return to see if unchaged is == true
    } catch (e) {
      print("errrorrrr :(");
      print(e);
      state = AcceptInvitationInitState();
    }
  }
}

final acceptInvitationProvider =
  StateNotifierProvider<AcceptInvitationController, AcceptInvitationState>(
    (ref) => AcceptInvitationController()
  );