import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class AddedMeState extends Equatable {
  const AddedMeState();

  @override
  List<Object?> get props => [];
}

class AddedMeInitState extends AddedMeState {}

class AddedMeLoadingState extends AddedMeState {}

class AddedMeLoadedState extends AddedMeState {
  final AddedMe$Query$PaginatedEventUsersResults val;

  const AddedMeLoadedState({
    required this.val,
  });

  @override
  List<Object?> get props => [val];
}

class AddedMeErrorState extends AddedMeState {}