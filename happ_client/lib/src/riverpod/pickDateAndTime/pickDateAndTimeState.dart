import 'package:equatable/equatable.dart';

abstract class PickDateState extends Equatable {
  const PickDateState();

  @override
  List<Object?> get props => [];
}

class PickDateInitState extends PickDateState {}

class PickDatePickedState extends PickDateState {
  final DateTime date;

  const PickDatePickedState({
    required this.date
  });

  @override
  List<Object?> get props => [date];
}

abstract class PickTimeState extends Equatable {
  const PickTimeState();

  @override
  List<Object?> get props => [];
}

class PickTimeInitState extends PickTimeState {}

class PickTimePickedState extends PickTimeState {
  final DateTime time;

  PickTimePickedState({
    required this.time
  });

  @override
  List<Object?> get props => [time];
}