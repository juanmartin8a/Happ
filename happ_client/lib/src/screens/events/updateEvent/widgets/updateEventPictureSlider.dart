import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdatePictureActions/pictureActions.dart';
import 'package:happ_client/src/riverpod/eventUpdatePictureActions/pictureActionsState.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/updatePictures/updatePictures.dart';
import 'package:happ_client/src/riverpod/updatePictures/updatePicturesState.dart';
import 'package:happ_client/src/screens/events/newEvent/NPDScreen/photosDialog.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/imageActionsDialog.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class CustomImage {
  final String? imageUrl;
  final AssetEntity? assetEntityImage;
  final bool isAsset;
  final int? originalIndex;
  final String? uuid;
  CustomImage({
    this.imageUrl, 
    this.assetEntityImage, 
    this.isAsset = false, 
    this.originalIndex,
    this.uuid,
  });
}

class UpdatePictureInputWrapper {
  final UpdatePictureInput updatePictureInput;
  final String? uuid;
  UpdatePictureInputWrapper({
    required this.updatePictureInput,
    this.uuid
  });
}

class UpdateEventPictureSlider extends ConsumerStatefulWidget {
  final List<String> eventPics;
  const UpdateEventPictureSlider({
    required this.eventPics,
    required super.key
  });

  @override
  _UpdateEventPictureSliderState createState() => _UpdateEventPictureSliderState();
}

class _UpdateEventPictureSliderState extends ConsumerState<UpdateEventPictureSlider> with AutomaticKeepAliveClientMixin {

  List<UpdatePictureInputWrapper> updatedEventPics = [];
  List<UpdatePictureInputWrapper> updatedLightEventPics = [];

  late List<CustomImage> updateEventPics;

  int replace = -1;
  String replaceUuid = "";

  @override
  void initState() {
    super.initState();
    updateEventPics = widget.eventPics.asMap().entries.map((entry) => CustomImage(imageUrl: entry.value, originalIndex: entry.key)).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(picturesActionsProvider, (prev, next) {
      if (next is PictureActionsDoneState) {
        if (next.pictureAction == PictureAction.replace) {
          replace = next.index;
          if (next.index == -1) {
            replaceUuid = next.uuid!;
          }
          showGeneralDialog(
            context: context,
            barrierColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, anim1, anim2) {
              return const PhotoDialog(selectOne: true, isUpdate: true,);
            }
          );
        } else if (next.pictureAction == PictureAction.delete) {
          removeImage(next.index, next.uuid);
        } else if (next.pictureAction == PictureAction.add) {
          
        }
      }
    });

    ref.listen(updatePicturesProvider, (prev, next) {
      if (next is UpdatePictureDoneState) {
        replaceImage(replace, replaceUuid, next.image, next.multipartFile, next.lightMultipartFile);
      } else if (next is UpdatePicturesDoneState) {
        addImages(next.imageList, next.multipartFiles, next.lightMultipartFiles);
      }
    });

    return Stack(
      children: [
        PageView.builder(
          itemCount: updateEventPics.length,
          onPageChanged: (value) {
            // setState(() {
            //   // currentPage = value;
            // });
          },
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, anim1, anim2) {
                    return ImageActionsDialog(index: updateEventPics[i].originalIndex ?? -1, uuid: updateEventPics[i].uuid);
                  }
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                // height: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: 4/3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: updateEventPics[i].isAsset == true
                      ? AssetEntityImage(
                        updateEventPics[i].assetEntityImage!,
                        isOriginal: false, // Defaults to `true`.
                        thumbnailSize: const ThumbnailSize.square(1000), // Preferred value.
                        thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
                        fit: BoxFit.cover,
                      )
                      : Image.network(
                        updateEventPics[i].imageUrl!,
                        fit: BoxFit.cover
                      ),//Image.asset('assets/images/image2.jpeg', fit: BoxFit.cover)
                    ),
                  )
                )
              ),
            );
          }
        ),
        Positioned(
          right: 16,
          top: 4,
          child: GestureDetector(
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierColor: Colors.transparent,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, anim1, anim2) {
                  return const PhotoDialog(isUpdate: true);
                }
              );
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )
              ),
              child: const Icon(
                EvaIcons.plus,
                size: 26
              )
            ),
          )
        )
      ],
    );
  }

  void removeImage(int index, String? uuid) {

    if (index == -1) {
      updatedEventPics.removeWhere((pic) => pic.uuid == uuid!);
      updatedLightEventPics.removeWhere((pic) => pic.uuid == uuid!);
    } else {

      int updatedEventPicsIndex = updatedEventPics.indexWhere((entry) => entry.updatePictureInput.index == index);
      if (updatedEventPicsIndex != -1) {
        updatedEventPics.removeAt(updatedEventPicsIndex);
      }

      int updatedLightEventPicsIndex = updatedLightEventPics.indexWhere((entry) => entry.updatePictureInput.index == index);
      if (updatedLightEventPicsIndex != -1) {
        updatedLightEventPics.removeAt(updatedLightEventPicsIndex);
      }

      updatedEventPics.add(
        UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: index,
            action: PictureAction.delete,
          )
        )
      );
      updatedLightEventPics.add(
        UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: index,
            action: PictureAction.delete,
          )
        )
      );
    }

    ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
      eventPics: updatedEventPics.map((i) => i.updatePictureInput).toList(),
      lightEventPics: updatedLightEventPics.map((i) => i.updatePictureInput).toList(),
    );

    List<CustomImage> newUpdateEventPics = List.from(updateEventPics);

    if (index == -1) {
      int realIndex = newUpdateEventPics.indexWhere((pic) => pic.uuid == uuid!);
      newUpdateEventPics.removeAt(realIndex);
    } else {
      int realIndex = newUpdateEventPics.indexWhere((element) => element.originalIndex == index);
      newUpdateEventPics.removeAt(realIndex);
    }

    setState(() {
      updateEventPics = newUpdateEventPics;
    });
  }

  void replaceImage(
    int index, 
    String? uuid,
    AssetEntity image,
    MultipartFile file, 
    MultipartFile smallFile
  ) {

    if (index == -1) {
      final eventPicsIndex = updatedEventPics.indexWhere((pic) => pic.uuid == uuid!);
      updatedEventPics[eventPicsIndex] = UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: -1,
            file: file,
            action: PictureAction.add,
          ),
          uuid: updatedEventPics[eventPicsIndex].uuid
        );
      updatedLightEventPics[eventPicsIndex] = UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: -1,
            file: smallFile,
            action: PictureAction.add,
          ),
          uuid: updatedEventPics[eventPicsIndex].uuid
        );
    } else {
      int updatedEventPicsIndex = updatedEventPics.indexWhere((entry) => entry.updatePictureInput.index == index);
      if (updatedEventPicsIndex != -1) {
        updatedEventPics.removeAt(updatedEventPicsIndex);
      }

      int updatedLightEventPicsIndex = updatedLightEventPics.indexWhere((entry) => entry.updatePictureInput.index == index);
      if (updatedLightEventPicsIndex != -1) {
        updatedLightEventPics.removeAt(updatedLightEventPicsIndex);
      }
      updatedEventPics.add(
        UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: index,
            file: file,
            action: PictureAction.replace,
          ),
        )
      );
      updatedLightEventPics.add(
        UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: index,
            file: smallFile,
            action: PictureAction.replace,
          )
        )
      );
    }

    ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
      eventPics: updatedEventPics.map((i) => i.updatePictureInput).toList(),
      lightEventPics: updatedLightEventPics.map((i) => i.updatePictureInput).toList(),
    );

    List<CustomImage> newUpdateEventPics = List.from(updateEventPics);
    if (index == -1) {
      int realIndex = newUpdateEventPics.indexWhere((pic) => pic.uuid == uuid!);
      newUpdateEventPics[realIndex] = CustomImage(assetEntityImage: image, isAsset: true, uuid: uuid);
    } else {
      int realIndex = newUpdateEventPics.indexWhere((element) => element.originalIndex == index);
      newUpdateEventPics[realIndex] = CustomImage(assetEntityImage: image, isAsset: true, originalIndex: index);
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        updateEventPics = newUpdateEventPics;
        replace = -1;
        replaceUuid = "";
      });
    });
  }

  void addImages(
    List<AssetEntity> images,
    List<MultipartFile> file, 
    List<MultipartFile> smallFile
  ) {
    String uuid = const Uuid().v4();
    for (int i = 0; i < file.length; i++) {
      updatedEventPics.add(
        UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: -1,
            file: file[i],
            action: PictureAction.add
          ),
          uuid: uuid
        )
      );
      updatedLightEventPics.add(
        UpdatePictureInputWrapper(
          updatePictureInput: UpdatePictureInput(
            index: -1,
            file: smallFile[i],
            action: PictureAction.add
          ),
          uuid: uuid
        )
      );
    }

    ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
      eventPics: updatedEventPics.map((i) => i.updatePictureInput).toList(),
      lightEventPics: updatedLightEventPics.map((i) => i.updatePictureInput).toList(),
    );
    Future.delayed(const Duration(milliseconds: 200), () async {
      for (int i = 0; i < images.length; i++) {
        updateEventPics.add(
          CustomImage(
            assetEntityImage: images[i], 
            isAsset: true,
            uuid: uuid
          )
        );
      }
      setState(() {});
    });
  }
  
  @override
  bool get wantKeepAlive => true;
}