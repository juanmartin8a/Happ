import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/updateUser/updateUserState.dart';
import 'package:http/http.dart' as http;

class UpdateUserContoller extends StateNotifier<UpdateUserState> {

  UpdateUserContoller() : super(UpdateUserInitState());

  UserRepo get userRepo => UserRepo();

  void updateUser(
    http.MultipartFile? profilePic,
    String? username,
    String? name
  ) async {
    state = UpdateUserLoadingState();
    try {
      final res = await userRepo.updateUser(profilePic, username, name);
      state = UpdateUserDoneState(updateUserRes: res);
    } catch (e) {
      debugPrint("error in updateUser: $e");
      state = UpdateUserErrorState();
    }
  }
}

final updateUserProvider =
  StateNotifierProvider<UpdateUserContoller, UpdateUserState>((ref) => UpdateUserContoller());