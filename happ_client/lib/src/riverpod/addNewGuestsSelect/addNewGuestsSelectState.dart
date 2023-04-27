import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:equatable/equatable.dart';

abstract class AddNewGuestsSelect extends Equatable {
  const AddNewGuestsSelect();

  @override
  List<Object?> get props => [];
}

class AddNewGuestsInitState extends AddNewGuestsSelect {}


class AddNewGuestsSelectedState extends AddNewGuestsSelect {
  final SearchForUsersToAddAsGuests$Query$User user;

  const AddNewGuestsSelectedState({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class AddNewGuestsRemoveState extends AddNewGuestsSelect {
  final int userId;

  const AddNewGuestsRemoveState({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
