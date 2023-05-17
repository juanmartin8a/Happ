import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/scanPass/scanPassState.dart';

class ScanPassController extends StateNotifier<ScanPassState> {

  ScanPassController() : super(ScanPassInitState());

  EventRepo get eventRepo => EventRepo();

  void scanPass(int eventId, String cypherText) async {
    state = ScanPassLoadingState();
    try {
      final res = await eventRepo.scanPass(eventId, cypherText);
      if (res.scanPass == true) {
        state = ScanPassDoneState(true);
      } else {
        state = ScanPassDoneState(false);
      }
    } catch (e) {
      debugPrint("error in scanPass: $e");
      state = ScanPassErrorState();
    }
  }
}

final scanPassProvider =
  StateNotifierProvider<ScanPassController, ScanPassState>(
    (key) => ScanPassController()
  );