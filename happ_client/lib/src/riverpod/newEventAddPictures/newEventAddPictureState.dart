import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class AddPicturesState extends Equatable {

  @override
  List<Object?> get props => [];
}

class AddPicturesInitState extends AddPicturesState {}

class AddPicturesDoneState extends AddPicturesState {
  final List<AssetEntity> imageList;

  AddPicturesDoneState({
    required this.imageList,
  });

  @override
  List<Object?> get props => [imageList];
}