import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class AcceptInvitationState extends Equatable {
  const AcceptInvitationState();

  @override
  List<Object?> get props => [];
}

class AcceptInvitationInitState extends AcceptInvitationState {}

class AcceptInvitationLoadingState extends AcceptInvitationState {}

class AcceptInvitationDoneState extends AcceptInvitationState {
  final AcceptInvitation$Mutation$AcceptInvitationResponse acceptInviteRes;

  const AcceptInvitationDoneState({
    required this.acceptInviteRes,
  });

  @override
  List<Object?> get props => [acceptInviteRes];
}
