import 'package:equatable/equatable.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object?> get props => [];
}

class DeleteUserInitState extends DeleteUserState {}

class DeleteUserLoadingState extends DeleteUserState {}

class DeleteUserDoneState extends DeleteUserState {
  final bool success;

  const DeleteUserDoneState({
    required this.success,
  });

  @override
  List<Object?> get props => [success];
}

class DeleteUserErrorState extends DeleteUserState {}