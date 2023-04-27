import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/signIn/signInState.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController extends StateNotifier<SignInState> {

  SignInController() : super(SignInInitState());

  UserRepo get userRepo => UserRepo();

  UserAccessController get userAccess => UserAccessController();

  void signIn(
    String token,
    SignInProvider provider,
    String? name,
    String? authorizationCode
  ) async {
    state = SignInLoadingState();
    try {
      final res = await userRepo.signIn(token, provider, name, authorizationCode);
      state = SignInDoneState(signInRes: res);
    } catch (e) {
      print(e);
      state = SignInErrorState();
    }
  }
}

final signInProvider =
  StateNotifierProvider<SignInController, SignInState>((ref) => SignInController());