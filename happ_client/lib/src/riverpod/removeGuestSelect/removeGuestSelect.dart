import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelectState.dart';

class RemoveGuestSelectController extends StateNotifier<RemoveGuestSelectState> {

  RemoveGuestSelectController() : super(RemoveGuestSelectInitState());

  void select(int userId, bool isAdded, bool isHost) async {
    if (isAdded) {
      state = RemoveGuestSelectedState(userId: userId, isHost: isHost);
    } else {
      state = RemoveGuestRemoveState(userId: userId, isHost: isHost);
    }
  }
}

final removeGuestSelectProvider =
  StateNotifierProvider<RemoveGuestSelectController, RemoveGuestSelectState>(
    (ref) => RemoveGuestSelectController()
  );