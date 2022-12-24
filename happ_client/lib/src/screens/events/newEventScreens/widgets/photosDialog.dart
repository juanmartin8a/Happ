import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventAddPictures/newEventAddPictures.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart';

class PhotoDialog extends ConsumerStatefulWidget {
  const PhotoDialog({
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
                                    fontWeight: FontWeight.w700
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
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        child: const Icon(
                                          CupertinoIcons.clear,
                                          size: 20
                                        ),
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
                            itemCount: imagesWidget.length,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5
                            ),
                            itemBuilder: (context, index) {
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
                          List<AssetEntity> newImages = [];
                          List<MultipartFile> multipartFiles = [];

                          for (int i = 0; i < selectedImages.length; i++) {
                            newImages.add(images[selectedImages[i]]);
                            final file = await images[selectedImages[i]].file;
                            multipartFiles.add(await MultipartFile.fromPath('eventPicture', file!.path));
                            print(multipartFiles);
                          }

                          ref.read(addPicturesProvider.notifier).addPicture(newImages);
                          if (selectedImages.isNotEmpty) {
                            ref.read(newEventCompleteProvider.notifier).fieldChange(
                              eventPics: multipartFiles
                            );
                          }
                          if (mounted) Navigator.pop(context);
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width) * 0.45,
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 45 * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.grey[900]!,
                              // buttonStateVal
                              //   ? const Color(0xff00ff03)
                              //   : Colors.grey[900]!, 
                                width: 2.0
                            ),
                          ),
                          child: Center(
                            child:Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.grey[800]!,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                height: 1
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
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    accessGranted = _ps.isAuth;
    if (accessGranted == true) {
      getPhotos(0);
    }
  }
  // user clicks add picture
  // get permissions
  // if it has permission then request photos
  // put photos in widget list
  // if add more

  void getPhotos(page) async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      // onlyAll: true,
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
      setState(() {
        selectedImages.removeWhere((i) => i == index);
      });
    } else {
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
      setState(() {
        selectedImages.add(index);
      });
    }

  }
}