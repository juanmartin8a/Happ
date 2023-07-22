import 'package:equatable/equatable.dart';

abstract class RemoveGuestSelectState extends Equatable {
  const RemoveGuestSelectState();

  @override
  List<Object?> get props => [];
}

class RemoveGuestSelectInitState extends RemoveGuestSelectState {}


class RemoveGuestSelectedState extends RemoveGuestSelectState {
  final int userId;
  final bool isHost;

  const RemoveGuestSelectedState({
    required this.userId,
    required this.isHost
  });

  @override
  List<Object?> get props => [userId, isHost];
}

class RemoveGuestRemoveState extends RemoveGuestSelectState {
  final int userId;
  final bool isHost;

  const RemoveGuestRemoveState({
    required this.userId,
    required this.isHost
  });

  @override
  List<Object?> get props => [userId, isHost];
}