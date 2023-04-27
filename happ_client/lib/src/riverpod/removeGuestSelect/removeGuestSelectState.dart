import 'package:equatable/equatable.dart';

abstract class RemoveGuestSelectState extends Equatable {
  const RemoveGuestSelectState();

  @override
  List<Object?> get props => [];
}

class RemoveGuestSelectInitState extends RemoveGuestSelectState {}


class RemoveGuestSelectedState extends RemoveGuestSelectState {
  final int userId;

  const RemoveGuestSelectedState({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class RemoveGuestRemoveState extends RemoveGuestSelectState {
  final int userId;

  const RemoveGuestRemoveState({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}