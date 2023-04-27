import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTimeState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Date
class PickDateController extends StateNotifier<PickDateState> {

  PickDateController() : super(PickDateInitState());

  void pickDate(
    DateTime date,
  ) async {
    state = PickDatePickedState(date: date);
  }
}

// Time
class PickTimeController extends StateNotifier<PickTimeState> {

  PickTimeController() : super(PickTimeInitState());

  void pickTime(
    DateTime time,
  ) async {
    state = PickTimePickedState(time: time);
  }
}

final pickDateControllerProvider =
  StateNotifierProvider<PickDateController, PickDateState>((ref) => PickDateController());

final pickTimeControllerProvider =
  StateNotifierProvider<PickTimeController, PickTimeState>((ref) => PickTimeController());

final updatePickDateControllerProvider =
  StateNotifierProvider<PickDateController, PickDateState>((ref) => PickDateController());

final updatePickTimeControllerProvider =
  StateNotifierProvider<PickTimeController, PickTimeState>((ref) => PickTimeController());