import 'package:equatable/equatable.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

abstract class PictureActionsState extends Equatable {
  const PictureActionsState();
  
  @override
  List<Object?> get props => [];
}

class PictureActionsInitState extends PictureActionsState {}

class PictureActionsDoneState extends PictureActionsState {
  final int index;
  final String? uuid;
  final PictureAction? pictureAction;
  const PictureActionsDoneState({
    required this.index,
    this.uuid,
    this.pictureAction,
  });
  
  @override
  List<Object?> get props => [index, uuid, pictureAction];
}