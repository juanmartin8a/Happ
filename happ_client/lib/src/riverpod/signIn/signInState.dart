import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInDoneState extends SignInState {
  final SignIn$Mutation$UserAuthResponse signInRes;

  const SignInDoneState({
    required this.signInRes,
  });

  @override
  List<Object?> get props => [signInRes];
}

class SignInErrorState extends SignInState {}