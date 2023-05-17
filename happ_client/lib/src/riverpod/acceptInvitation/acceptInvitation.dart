import 'package:flutter/foundation.dart';
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
      state = AcceptInvitationDoneState(acceptInviteRes: res);
    } catch (e) {
      debugPrint("error in acceptInvitation: $e");
      state = AcceptInvitationInitState();
    }
  }
}

final acceptInvitationProvider =
  StateNotifierProvider<AcceptInvitationController, AcceptInvitationState>(
    (ref) => AcceptInvitationController()
  );