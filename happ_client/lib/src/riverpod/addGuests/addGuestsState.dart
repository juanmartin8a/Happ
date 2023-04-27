import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class AddGuestsState extends Equatable {
  const AddGuestsState();

  @override
  List<Object?> get props => [];
}

class AddGuestsInitState extends AddGuestsState {}

class AddGuestsLoadingState extends AddGuestsState {}

class AddGuestsDoneState extends AddGuestsState {
  final bool res;

  const AddGuestsDoneState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class AddGuestsErrorState extends AddGuestsState {
  final String uuid;
  const AddGuestsErrorState._({
    required this.uuid
  });

  factory AddGuestsErrorState({String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return AddGuestsErrorState._(uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [uuid];
}
