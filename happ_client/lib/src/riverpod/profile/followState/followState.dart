import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/profile/followState/followStateState.dart';

class FollowStateController extends StateNotifier<FollowState> {

  FollowStateController() : super(FollowStateInitState());

  UserRepo get userRepo => UserRepo();

  void getFollowState(int id) async {
    state = FollowStateLoadingState();
    try {
      final res = await userRepo.getFollowState(id);
      state = FollowStateLoadedState(val: res.getFollowState);
    } catch (e) {
      debugPrint("error in searchUsers: $e");
      state = FollowStateErrorState();
    }
  }
}

final profileFollowStateProvider =
  StateNotifierProvider.family<FollowStateController, FollowState, String>(
    (ref, key) => FollowStateController()
  );