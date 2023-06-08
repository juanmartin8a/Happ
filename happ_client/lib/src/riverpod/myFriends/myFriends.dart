import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/myFriends/myFriendsState.dart';

class MyFriends extends StateNotifier<MyFriendsState> {

  MyFriends() : super(MyFriendsInitState());

  UserRepo get userRepo => UserRepo();

  void myFriends(
    int limit, 
    List<int> idsList
  ) async {
    state = MyFriendsLoadingState();
    try {
      final res = await userRepo.myFriends(limit, idsList);
      state = MyFriendsLoadedState(val: res.myFriends);
    } catch (e) {
      debugPrint("error in myFriends: $e"); 
    }
  }
}

final profileMyFriendsProvider =
  StateNotifierProvider.family<MyFriends, MyFriendsState, String>(
    (ref, key) => MyFriends()
  );