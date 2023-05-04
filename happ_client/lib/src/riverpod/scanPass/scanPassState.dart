import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class ScanPassState extends Equatable {
  const ScanPassState();

  @override
  List<Object?> get props => [];
}

class ScanPassInitState extends ScanPassState {}

class ScanPassLoadingState extends ScanPassState {}

class ScanPassDoneState extends ScanPassState {
  final bool invited;
  final String uuid;

  const ScanPassDoneState._({
    required this.invited,
    required this.uuid,
  });

  factory ScanPassDoneState(bool invited, {String? uuid}) {
    final uuidForParam = uuid ?? const Uuid().v4();
    return ScanPassDoneState._(invited: invited, uuid: uuidForParam);
  }

  @override
  List<Object?> get props => [invited, uuid];
}

class ScanPassErrorState extends ScanPassState {}