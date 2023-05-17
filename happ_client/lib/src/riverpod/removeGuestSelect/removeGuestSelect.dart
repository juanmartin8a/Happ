import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelectState.dart';

class RemoveGuestSelectController extends StateNotifier<RemoveGuestSelectState> {

  RemoveGuestSelectController() : super(RemoveGuestSelectInitState());

  void select(int userId, bool isAdded) async {
    if (isAdded) {
      state = RemoveGuestSelectedState(userId: userId);
    } else {
      state = RemoveGuestRemoveState(userId: userId);
    }
  }
}

final removeGuestSelectProvider =
  StateNotifierProvider<RemoveGuestSelectController, RemoveGuestSelectState>(
    (ref) => RemoveGuestSelectController()
  );