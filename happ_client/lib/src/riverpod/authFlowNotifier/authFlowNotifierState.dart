import 'package:equatable/equatable.dart';

abstract class AuthFlowNotifierState extends Equatable {
  const AuthFlowNotifierState();

  @override
  List<Object?> get props => [];
}

class AuthFlowNotifierInitState extends AuthFlowNotifierState {}

class AuthFlowNotifierDoneState extends AuthFlowNotifierState {}

// class AuthFlowNotifierInitState extends AuthFlowNotifierState {}