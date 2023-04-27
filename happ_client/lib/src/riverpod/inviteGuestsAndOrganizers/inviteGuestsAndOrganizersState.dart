import 'package:equatable/equatable.dart';

abstract class InviteGuestsAndOrganizersState extends Equatable {
  const InviteGuestsAndOrganizersState();

  @override
  List<Object?> get props => [];
}

class InviteGuestsAndOrganizersInitState extends InviteGuestsAndOrganizersState {}

class InviteGuestsAndOrganizersLoadingState extends InviteGuestsAndOrganizersState {}

class InviteGuestsAndOrganizersDoneState extends InviteGuestsAndOrganizersState {
  final bool res;

  const InviteGuestsAndOrganizersDoneState({
    required this.res,
  });

  @override
  List<Object?> get props => [res];
}

class InviteGuestsAndOrganizersErrorState extends InviteGuestsAndOrganizersState {}