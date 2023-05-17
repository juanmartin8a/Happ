import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/seePass/seePassState.dart';

class SeePassController extends StateNotifier<SeePassState> {

  SeePassController() : super(SeePassInitState());

  EventRepo get eventRepo => EventRepo();

  void seePass(int eventId) async {
    state = SeePassLoadingState();
    try {
      final res = await eventRepo.seePass(eventId);
      state = SeePassDoneState(cypherText: res.seePass);
    } catch (e) {
      debugPrint("error in seePass: $e");
    }
  }
}

final seePassProvider =
  StateNotifierProvider<SeePassController, SeePassState>(
    (ref) => SeePassController()
  );