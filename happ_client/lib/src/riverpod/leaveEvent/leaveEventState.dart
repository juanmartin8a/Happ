import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class LeaveEventState extends Equatable {
  const LeaveEventState();

  @override
  List<Object?> get props => [];
}

class LeaveEventInitState extends LeaveEventState {}

class LeaveEventLoadingState extends LeaveEventState {}

class LeaveEventDoneState extends LeaveEventState {
  final bool res;
  final int eventId;

  const LeaveEventDoneState({
    required this.res,
    required this.eventId,
  });

  @override
  List<Object?> get props => [res];
}

class LeaveEventErrorState extends LeaveEventState {
  final String uuid;
  const LeaveEventErrorState._({
    required this.uuid
  });

  factory LeaveEventErrorState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return LeaveEventErrorState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}
