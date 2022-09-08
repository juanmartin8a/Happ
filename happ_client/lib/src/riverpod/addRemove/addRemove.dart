import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddRemoveUserController extends StateNotifier<AddRemoveState> {

  AddRemoveUserController() : super(AddRemoveInitState());

  UserRepo get userRepo => UserRepo();

  void addOrRemoveUser(int followUserId) async {
    // state = ProfileLoadingState();
    try {
      final res = await userRepo.addOrRemoveUser(followUserId);
      if (res.value == 1) {
        state = AddRemoveAddState(res: res);
      } else if (res.value == -1) {
        state = AddRemoveRemoveState(res: res);
      }
    } catch (e) {
      print(e);
      // state = ProfileErrorState();
    }
  }
}

final addOrRemoveUserProvider =
  StateNotifierProvider.family<AddRemoveUserController, AddRemoveState, String>(
    (ref, key) => AddRemoveUserController()
  );