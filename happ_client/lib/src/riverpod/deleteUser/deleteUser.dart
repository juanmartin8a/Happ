import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/deleteUser/deleteUserState.dart';

class DeleteUserController extends StateNotifier<DeleteUserState> {

  DeleteUserController() : super(DeleteUserInitState());

  UserRepo get userRepo => UserRepo();

  void deleteUser() async {
    state = DeleteUserLoadingState();
    try {
      final res = await userRepo.deleteUser();
      state = DeleteUserDoneState(success: res.deleteUser);
    } catch (e) {
      print("error deleting user: $e");
      state = DeleteUserErrorState();
    }
  }
}

final deleteUserProvider =
  StateNotifierProvider<DeleteUserController, DeleteUserState>(
    (ref) => DeleteUserController()
  );