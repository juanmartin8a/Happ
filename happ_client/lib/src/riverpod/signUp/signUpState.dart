import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpDoneState extends SignUpState {
  final SignUp$Mutation$UserAuthResponse signUpRes;

  const SignUpDoneState({
    required this.signUpRes,
  });

  @override
  List<Object?> get props => [signUpRes];
}

class SignUpSetBirthdayState extends SignUpState {
  final String birthday;

  const SignUpSetBirthdayState({
    required this.birthday,
  });

  @override
  List<Object?> get props => [birthday];
}

class SignUpSetDataState extends SignUpState {
  final String username;
  final String email;
  final String password;

  const SignUpSetDataState({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class SignUpErrorState extends SignUpState {}