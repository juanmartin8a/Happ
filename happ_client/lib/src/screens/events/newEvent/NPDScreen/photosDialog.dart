import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventAddPictures/newEventAddPictures.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/updatePictures/updatePictures.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart';

class PhotoDialog extends ConsumerStatefulWidget {
  final bool selectOne;
  final bool isUpdate;
  const PhotoDialog({
    this.selectOne = false,
    this.isUpdate = false,
    Key? key
  }) : super(key: key);

  @override
  _PhotoDialogState createState() => _PhotoDialogState();
}

class _PhotoDialogState extends ConsumerState<PhotoDialog> {

  late bool accessGranted;
  List<Widget> imagesWidget = [];
  List<AssetEntity> images = [];
  List<int> selectedImages = [];
  bool hasMore = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    requestPermission();
    // selectedImages = widget.
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black26)
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                // color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.8,
                height: (MediaQuery.of(context).size.width * 0.8) * 1.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 35,
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  "Recents",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    // height: 1,
                                  )
                                ),
                              ),
                              Positioned(
                                right: 5,
                                child: SizedBox(
                                  height: 35,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                    child: Icon(
                                        EvaIcons.close,
                                        color: Colors.grey[800],
                                        size: 28
                                      ),
                                    ),
                                  ),
                                )
                              )
                            ],
                          )
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: imagesWidget.length + 1,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5
                            ),
                            itemBuilder: (context, index) {
                              if (index == imagesWidget.length) {
                                return const SizedBox(
                                  height: (45 * 0.9) + 20 + 20
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  selectImage(index);
                                },
                                child: imagesWidget[index]
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          if (widget.selectOne == true) { 
                            AssetEntity newImage;
                            MultipartFile multipartFile;
                            MultipartFile lightMultipartFile;

                            setState(() {
                              loading = true;
                            });

                            newImage = images[selectedImages[0]];
                            final file = await images[selectedImages[0]].file;

                            Directory directory = await getTemporaryDirectory();
                            String destinationPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

                            await compressFile(file!.absolute.path, destinationPath);

                            Directory lightDirectory = await getTemporaryDirectory();
                            String lightDestinationPath = '${lightDirectory.path}/light_${DateTime.now().millisecondsSinceEpoch}.jpg';

                            await highlyCompressFile(file.absolute.path, lightDestinationPath);

                            multipartFile = await MultipartFile.fromPath('eventPicture', destinationPath);
                            lightMultipartFile = await MultipartFile.fromPath('lightEventPicture', lightDestinationPath);

                            setState(() {
                              loading = false;
                            });

                            if (widget.isUpdate) {
                              ref.read(updatePicturesProvider.notifier).updatePicture(
                                newImage, multipartFile, lightMultipartFile
                              );
                            }
                          } else {
                            List<AssetEntity> newImages = [];
                            List<MultipartFile> multipartFiles = [];
                            List<MultipartFile> lightMultipartFiles = [];

                            setState(() {
                              loading = true;
                            });

                            for (int i = 0; i < selectedImages.length; i++) {
                              newImages.add(images[selectedImages[i]]);
                              final file = await images[selectedImages[i]].file;

                              Directory directory = await getTemporaryDirectory();
                              String destinationPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

                              await compressFile(file!.absolute.path, destinationPath);

                              Directory lightDirectory = await getTemporaryDirectory();
                              String lightDestinationPath = '${lightDirectory.path}/light_${DateTime.now().millisecondsSinceEpoch}.jpg';

                              await highlyCompressFile(file.absolute.path, lightDestinationPath);

                              multipartFiles.add(await MultipartFile.fromPath('eventPicture', destinationPath));
                              lightMultipartFiles.add(await MultipartFile.fromPath('lightEventPicture', lightDestinationPath));
                            }

                            setState(() {
                              loading = false;
                            });

                            if (widget.isUpdate) {
                              ref.read(updatePicturesProvider.notifier).updatePictures(
                                newImages, multipartFiles, lightMultipartFiles
                              );
                            } else {
                              ref.read(addPicturesProvider.notifier).addPicture(newImages);
                              if (selectedImages.isNotEmpty) {
                                ref.read(newEventCompleteProvider.notifier).fieldChange(
                                  eventPics: multipartFiles,
                                  lightEventPics: lightMultipartFiles,
                                );
                              }
                            }
                          }
                          if (mounted) Navigator.pop(context);
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width) * 0.45,
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 45 * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Center(
                            child: loading 
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              )
                            )
                            : const Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                // height: 1
                              )
                            ),
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void requestPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    accessGranted = ps.isAuth;
    if (accessGranted == true) {
      getPhotos(0);
    }
  }

  void getPhotos(page) async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      filterOption: FilterOptionGroup()
      ..addOrderOption(
        const OrderOption(
          type: OrderOptionType.createDate,
          asc: false,
        ),
      )
    );

    List<AssetEntity> media = await albums[0].getAssetListPaged(page: page, size: 80);
    List<Widget> preImagesWidget = [];

    if (media.isEmpty || media.length < 80) {
      for (int i = 0; i < media.length; i++) {
        preImagesWidget.add(getImageWidget(media[i]));
      }
      hasMore = false;
    } else {
      for (int i = 0; i < media.length; i++) {
        preImagesWidget.add(getImageWidget(media[i]));
      }
       hasMore = true;
    }
    imagesWidget = [...imagesWidget, ...preImagesWidget];
    images = [...images, ...media];

    setState(() {});
  }

  Widget getImageWidget(AssetEntity assetEntity) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: AssetEntityImage(
        assetEntity,
        isOriginal: false, // Defaults to `true`.
        thumbnailSize: const ThumbnailSize.square(240), // Preferred value.
        thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
        fit: BoxFit.cover,
      )
    );
  }

  void selectImage(int index) {
    AssetEntity assetEntity = images[index];

    if (selectedImages.contains(index)) {
      imagesWidget[index] = ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: AssetEntityImage(
          assetEntity,
          isOriginal: false, // Defaults to `true`.
          thumbnailSize: const ThumbnailSize.square(240), // Preferred value.
          thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
          fit: BoxFit.cover,
        )
      );
      if (widget.selectOne == true) {
        setState(() {
          selectedImages = [];
        });
      } else {
        setState(() {
          selectedImages.removeWhere((i) => i == index);
        });
      }
    } else {
      if (widget.selectOne == true) {
        for (int i = 0; i < selectedImages.length; i++) {
          if (selectedImages[i] != index) {
            AssetEntity assetEntity = images[selectedImages[i]];
            imagesWidget[selectedImages[i]] = ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: AssetEntityImage(
                assetEntity,
                isOriginal: false, // Defaults to `true`.
                thumbnailSize: const ThumbnailSize.square(240), // Preferred value.
                thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
                fit: BoxFit.cover,
              )
            );
            setState(() {});
          }
        }
      }
      imagesWidget[index] = Stack(
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: AssetEntityImage(
                  assetEntity,
                  isOriginal: false, // Defaults to `true`.
                  thumbnailSize: const ThumbnailSize.square(240), // Preferred value.
                  thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
                  fit: BoxFit.cover,
                )
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Colors.black12,
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5)
                  ),
                  padding: const EdgeInsets.all(1),
                  child: const Icon(
                    FluentIcons.checkmark_12_regular,
                    color: Colors.white,
                    size: 18
                  ),
                ),
              )
            ],
          )
        ],
      );
      if (widget.selectOne == true) {
        setState(() {
          selectedImages = [index];
        });
      } else {
        setState(() {
          selectedImages.add(index);
        });
      }
    }

  }

  Future<File> compressFile(String filePath, String destinationPath) async {
    await FlutterImageCompress.compressAndGetFile(
      filePath,
      destinationPath,
      minWidth: 720,
      minHeight: 720,
      quality: 70,
    );

    return File(destinationPath);
  }

  Future<File> highlyCompressFile(String filePath, String destinationPath) async {
    await FlutterImageCompress.compressAndGetFile(
      filePath,
      destinationPath,
      minWidth: 320,
      minHeight: 320,
      quality: 70,
    );

    return File(destinationPath);
  }

}