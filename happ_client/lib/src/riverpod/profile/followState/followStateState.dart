import 'package:equatable/equatable.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object?> get props => [];
}

class FollowStateInitState extends FollowState {}

class FollowStateLoadingState extends FollowState {}

class FollowStateLoadedState extends FollowState {
  final bool val;

  const FollowStateLoadedState({
    required this.val,
  });

  @override
  List<Object?> get props => [val];
}

class FollowStateErrorState extends FollowState {}