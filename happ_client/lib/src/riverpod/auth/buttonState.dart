// import 'package:clivy_client/src/riverpod/auth/buttonStateState.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';

class ButtonStateController extends StateNotifier<ButtonState> {
   ButtonStateController() : super(const ButtonState(val: false));

  void setButtonValue(bool val) {
    state = ButtonState(val: val);
  }
}

class ButtonState extends Equatable {
  final bool val;
  const ButtonState({
    required this.val
  });

  @override
  List<Object?> get props => [val];
}
