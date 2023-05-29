import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriendsState.dart';

class MutualFriendsState extends StateNotifier<MutualFriends> {

  MutualFriendsState() : super(MutualFriendsInitState());

  UserRepo get userRepo => UserRepo();

  void mutualFriends(
    int id,
    int limit, 
    List<int> idsList
  ) async {
    state = MutualFriendsLoadingState();
    try {
      final res = await userRepo.getMutualFriends(id, limit, idsList);
      state = MutualFriendsLoadedState(val: res.mutualFriends);
    } catch (e) {
      debugPrint("error in mutual friends: $e"); 
    }
  }
}

final profileMutualFriendsProvider =
  StateNotifierProvider.family<MutualFriendsState, MutualFriends, String>(
    (ref, key) => MutualFriendsState()
  );