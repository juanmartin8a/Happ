import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEventState.dart';

class DeleteEvent extends StateNotifier<DeleteEventState> {

  DeleteEvent() : super(DeleteEventInitState());

  EventRepo get eventRepo => EventRepo();

  void deleteEvent(
    int eventId
  ) async {
    state = DeleteEventLoadingState();
    try {
      final res = await eventRepo.deleteEvent(eventId);
      state = DeleteEventDoneState(res: res.deleteEvent!, eventId: eventId);
      // await Future.delayed(Duration(milliseconds: 5000));
      // state = DeleteEventDoneState(res: true, eventId: eventId);
    } catch(e) {
      print("errorrrrr");
      print(e);
      state = DeleteEventErrorState();
    }
  }
}

final deleteEventProvider =
  StateNotifierProvider<DeleteEvent, DeleteEventState>(
    (ref) => DeleteEvent()
  );