import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart';

abstract class UpdatePicturesState extends Equatable {

  @override
  List<Object?> get props => [];
}

class UpdatePicturesInitState extends UpdatePicturesState {}

class UpdatePicturesDoneState extends UpdatePicturesState {
  final List<AssetEntity> imageList;
  final List<MultipartFile> multipartFiles;
  final List<MultipartFile> lightMultipartFiles;

  UpdatePicturesDoneState({
    required this.imageList,
    required this.multipartFiles,
    required this.lightMultipartFiles,
  });

  @override
  List<Object?> get props => [imageList, multipartFiles, lightMultipartFiles];
}

class UpdatePictureDoneState extends UpdatePicturesState {
  final AssetEntity image;
  final MultipartFile multipartFile;
  final MultipartFile lightMultipartFile;

  UpdatePictureDoneState({
    required this.image,
    required this.multipartFile,
    required this.lightMultipartFile
  });

  @override
  List<Object?> get props => [image, multipartFile, lightMultipartFile];
}