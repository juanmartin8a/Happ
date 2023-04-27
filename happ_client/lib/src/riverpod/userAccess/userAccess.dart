import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccessState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/utils/user/currentUser.dart';

class UserAccessController extends StateNotifier<UserAccessState> {

  UserAccessController() : super(UserAccessInitState());

  UserRepo get userRepo => UserRepo();

  void userAccess() async {
    state = UserAccessLoadingState();
    try {
    final res = await userRepo.userAccess();
      // CurrentUser.user = res;
      state = UserAccessGrantedState(user: res);
    } catch (e) {
      print(e);
      state = UserAccessDeniedState();
    }
  }

  void signUserIn(user) {
    print("aaa");
    state = UserAccessGrantedState(user: user);
    print(state);
  }
}

final userAccessProvider =
  StateNotifierProvider<UserAccessController, UserAccessState>((ref) => UserAccessController());