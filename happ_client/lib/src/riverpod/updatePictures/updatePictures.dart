import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/updatePictures/updatePicturesState.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart';

class UpdatePicturesController extends StateNotifier<UpdatePicturesState> {

  UpdatePicturesController() : super(UpdatePicturesInitState());

  void updatePictures(
    List<AssetEntity> imageList,
    List<MultipartFile> multipartFiles,
    List<MultipartFile> lightMultipartFiles,
  ) async {
    state = UpdatePicturesDoneState(imageList: imageList, multipartFiles: multipartFiles, lightMultipartFiles: lightMultipartFiles);
  }

  void updatePicture(
    AssetEntity image,
    MultipartFile multipartFile,
    MultipartFile lightMultipartFile,
  ) async {
    state = UpdatePictureDoneState(image: image, multipartFile: multipartFile, lightMultipartFile: lightMultipartFile);
  }
}

final updatePicturesProvider =
  StateNotifierProvider<UpdatePicturesController, UpdatePicturesState>((ref) => UpdatePicturesController());