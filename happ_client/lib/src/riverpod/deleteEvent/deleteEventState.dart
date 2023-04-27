import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class DeleteEventState extends Equatable {
  const DeleteEventState();

  @override
  List<Object?> get props => [];
}

class DeleteEventInitState extends DeleteEventState {}

class DeleteEventLoadingState extends DeleteEventState {}

class DeleteEventDoneState extends DeleteEventState {
  final bool res;
  final int eventId;

  const DeleteEventDoneState({
    required this.res,
    required this.eventId,
  });

  @override
  List<Object?> get props => [res];
}

class DeleteEventErrorState extends DeleteEventState {
  final String uuid;
  const DeleteEventErrorState._({
    required this.uuid
  });

  factory DeleteEventErrorState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return DeleteEventErrorState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}
