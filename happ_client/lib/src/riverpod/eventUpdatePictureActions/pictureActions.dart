import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdatePictureActions/pictureActionsState.dart';

// abstract class PictureActionsState extends Equatable {
//   final int index;
//   final PictureAction? pictureAction;
//   const PictureActionsState({
//     required this.index,
//     this.pictureAction,
//   });
  
//   @override
//   List<Object?> get props => [index, pictureAction];
// }

class PictureActions extends StateNotifier<PictureActionsState> {
  PictureActions() : super(PictureActionsInitState());

  void pictureAction(index, PictureAction action, String? uuid) {
    state = PictureActionsDoneState(index: index, uuid: uuid, pictureAction: action);
  }
}

final picturesActionsProvider =
  StateNotifierProvider<PictureActions, PictureActionsState>((ref) => PictureActions());