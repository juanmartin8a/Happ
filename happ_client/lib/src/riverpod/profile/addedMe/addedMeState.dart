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
  final bool isUpdate;

  const AddedMeLoadedState({
    required this.val,
    this.isUpdate = false
  });

  @override
  List<Object?> get props => [val, isUpdate];
}

class AddedMeErrorState extends AddedMeState {}