import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class GuestListActionState extends Equatable {
  const GuestListActionState();

  @override
  List<Object?> get props => [];
}

class GuestListActionInitState extends GuestListActionState {}


class GuestListActionAddState extends GuestListActionState {
  final String uuid;
  const GuestListActionAddState._({
    required this.uuid
  });

  factory GuestListActionAddState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return GuestListActionAddState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}

class GuestListActionRemoveState extends GuestListActionState {
  final String uuid;
  const GuestListActionRemoveState._({
    required this.uuid
  });

  factory GuestListActionRemoveState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return GuestListActionRemoveState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}