import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/signIn/signInState.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController extends StateNotifier<SignInState> {

  SignInController() : super(SignInInitState());

  UserRepo get userRepo => UserRepo();

  UserAccessController get userAccess => UserAccessController();

  void signIn(String usernameOrEmail, String password) async {
    state = SignInLoadingState();
    try {
      final res = await userRepo.signIn(usernameOrEmail, password);
      state = SignInDoneState(signInRes: res);
    } catch (e) {
      print(e);
      state = SignInErrorState();
    }
  }
}

final signInProvider =
  StateNotifierProvider<SignInController, SignInState>((ref) => SignInController());