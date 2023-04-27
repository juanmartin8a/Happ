import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifierState.dart';

class AuthFlowNotifierController extends StateNotifier<AuthFlowNotifierState> {

  AuthFlowNotifierController() : super(AuthFlowNotifierInitState());

  void setDone() {
    state = AuthFlowNotifierDoneState();
  }
}

final authFlowNotifierProvider =
  StateNotifierProvider<AuthFlowNotifierController, AuthFlowNotifierState>(
    (ref) => AuthFlowNotifierController()
  );