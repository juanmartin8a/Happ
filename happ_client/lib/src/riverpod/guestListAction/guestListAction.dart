import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListActionState.dart';

class GuestListActionController extends StateNotifier<GuestListActionState> {

  GuestListActionController() : super(GuestListActionInitState());

  void isAdd(bool? isAdd) async {
    if (isAdd != null) {
      if (isAdd) {
        state = GuestListActionAddState();
      } else {
        state = GuestListActionRemoveState();
      }
    } else {
      state = GuestListActionInitState();
    }
  }
}

final guestListActionProvider =
  StateNotifierProvider<GuestListActionController, GuestListActionState>(
    (ref) => GuestListActionController()
  );