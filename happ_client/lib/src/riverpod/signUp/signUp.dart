import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/signUp/signUpState.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpController extends StateNotifier<SignUpState> {

  SignUpController() : super(SignUpInitState());

  UserRepo get userRepo => UserRepo();

  UserAccessController get userAccess => UserAccessController();

  void signUp(
    String name,
    String username,
    String email, 
    String password,
    String birthday
  ) async {
    state = SignUpLoadingState();
    // try {
      final res = await userRepo.signUp(name, username, email, password, birthday);
      state = SignUpDoneState(signUpRes: res);
    // } catch (e) {
    //   print(e);
    //   state = SignUpErrorState();
    // }
  }

  void setBirthday(String birthdayVal) {
    state = SignUpSetBirthdayState(birthday: birthdayVal);
  }

  void setData(String username, String email, String password) {
    state = SignUpSetDataState(
      username: username,
      email: email,
      password: password,
    );
  }
}

final signUpProvider =
  StateNotifierProvider<SignUpController, SignUpState>((ref) => SignUpController());