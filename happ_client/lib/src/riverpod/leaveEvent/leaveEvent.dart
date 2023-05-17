import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEventState.dart';

class LeaveEvent extends StateNotifier<LeaveEventState> {

  LeaveEvent() : super(LeaveEventInitState());

  EventRepo get eventRepo => EventRepo();

  void leaveEvent(
    int eventId
  ) async {
    state = LeaveEventLoadingState();
    try {
      final res = await eventRepo.leaveEvent(eventId);
      state = LeaveEventDoneState(res: res.leaveEvent!, eventId: eventId);
    } catch(e) {
      debugPrint("error in leaveEvent: $e");
      state = LeaveEventErrorState();
    }
  }
}

final leaveEventProvider =
  StateNotifierProvider<LeaveEvent, LeaveEventState>(
    (ref) => LeaveEvent()
  );