import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

import 'newEventAddPictureState.dart';

class AddPictureController extends StateNotifier<AddPicturesState> {

  AddPictureController() : super(AddPicturesInitState());

  void addPicture(
    List<AssetEntity> imageList
  ) async {
    state = AddPicturesDoneState(imageList: imageList);
  }
}

final addPicturesProvider =
  StateNotifierProvider<AddPictureController, AddPicturesState>((ref) => AddPictureController());