import 'package:equatable/equatable.dart';

abstract class SeePassState extends Equatable {
  const SeePassState();

  @override
  List<Object?> get props => [];
}

class SeePassInitState extends SeePassState {}

class SeePassLoadingState extends SeePassState {}

class SeePassDoneState extends SeePassState {
  final String? cypherText;

  const SeePassDoneState({
    required this.cypherText,
  });

  @override
  List<Object?> get props => [cypherText];
}
