import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/addedMe/addedMeState.dart';

class AddedMe extends StateNotifier<AddedMeState> {

  AddedMe() : super(AddedMeInitState());

  UserRepo get userRepo => UserRepo();

  void addedMe(
    int limit, 
    List<int> idsList
  ) async {
    state = AddedMeLoadingState();
    try {
      final res = await userRepo.addedMe(limit, idsList);
      state = AddedMeLoadedState(val: res.addedMe);
    } catch (e) {
      debugPrint("error in addedMe: $e");
    }
  }
}

final profileAddedMeProvider =
  StateNotifierProvider.family<AddedMe, AddedMeState, String>(
    (ref, key) => AddedMe()
  );