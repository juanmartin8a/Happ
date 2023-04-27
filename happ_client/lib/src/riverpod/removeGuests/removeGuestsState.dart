import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class RemoveGuestsState extends Equatable {
  const RemoveGuestsState();

  @override
  List<Object?> get props => [];
}

class RemoveGuestsInitState extends RemoveGuestsState {}

class RemoveGuestsLoadingState extends RemoveGuestsState {}

class RemoveGuestsDoneState extends RemoveGuestsState {
  final bool res;
  final int eventId;
  final int deletedEventUsers;

  const RemoveGuestsDoneState({
    required this.res,
    required this.eventId,
    required this.deletedEventUsers
  });

  @override
  List<Object?> get props => [res, eventId, deletedEventUsers];
}

class RemoveGuestsErrorState extends RemoveGuestsState {
  final String uuid;
  const RemoveGuestsErrorState._({
    required this.uuid
  });

  factory RemoveGuestsErrorState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return RemoveGuestsErrorState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}
