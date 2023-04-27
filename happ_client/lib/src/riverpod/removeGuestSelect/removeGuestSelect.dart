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

// User taps on pencil
// Dialog of Remove or ADD
// If Remove then allow host to select guests that user wants to delete
// pencil icon changes to trash icon
// when trash icon is pressed, then selected guests are removed
// trash icon changes to pencil again.

final removeGuestSelectProvider =
  StateNotifierProvider<RemoveGuestSelectController, RemoveGuestSelectState>(
    (ref) => RemoveGuestSelectController()
  );

// final inviteUserSelectProvider =
//   StateNotifierProvider.family<InviteUserSelectController, InviteUserSelectState, String>(
//     (ref, key) => InviteUserSelectController()
//   );