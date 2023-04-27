import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/userData/userDataState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDataController extends StateNotifier<UserDataState> {

  UserDataController() : super(UserDataInitState());

  UserRepo get userRepo => UserRepo();

  void getUser(int userId) async {
    state = UserDataLoadingState();
    try {
      final res = await userRepo.getUser(userId);
      state = UserDataLoadedState(user: res);
    } catch (e) {
      print(e);
      state = UserDataErrorState();
    }
  }
}

final userDataProvider =
  StateNotifierProvider.family<UserDataController, UserDataState, String>(
    (ref, key) => UserDataController()
  );