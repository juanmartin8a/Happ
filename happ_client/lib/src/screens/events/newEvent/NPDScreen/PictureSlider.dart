import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventAddPictures/newEventAddPictureState.dart';
import 'package:happ_client/src/riverpod/newEventAddPictures/newEventAddPictures.dart';
import 'package:happ_client/src/screens/events/newEvent/NPDScreen/photosDialog.dart';
import 'package:photo_manager/photo_manager.dart';

class PictureSlider extends ConsumerStatefulWidget {
  const PictureSlider({
    Key? key
  }) : super(key: key);

  @override
  _PictureSliderState createState() => _PictureSliderState();
}

class _PictureSliderState extends ConsumerState<PictureSlider> with AutomaticKeepAliveClientMixin {

  List<AssetEntity> imageList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(addPicturesProvider);
    if (state is AddPicturesDoneState) {
      imageList = state.imageList;
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: ((MediaQuery.of(context).size.width - 24) * 0.75),
      child:  imageList.isEmpty
      ? Container(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
        ),
        child: AspectRatio(
          aspectRatio: 4/3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context, 
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, anim1, anim2) {
                    return const PhotoDialog();
                  }
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    // child: Image.asset('assets/images/image2.jpeg', fit: BoxFit.cover)
                  ),
                  Center(
                    child: Icon(
                      FluentIcons.add_square_multiple_16_regular,
                      size: 30,
                      color: Colors.grey[800]
                    )
                  )
                ],
              )
            )
          )
        ),
      )
      : PageView.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(
              right: 8,
              left: 8,
            ),
            child: AspectRatio(
              aspectRatio: 4/3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                      context: context, 
                      barrierColor: Colors.transparent,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, anim1, anim2) {
                        return const PhotoDialog();
                      }
                    );
                  },
                  child: AssetEntityImage(
                    imageList[index],
                    isOriginal: false, // Defaults to `true`.
                    thumbnailSize: const ThumbnailSize.square(1000), // Preferred value.
                    thumbnailFormat: ThumbnailFormat.jpeg, // Defaults to `jpeg`.
                    fit: BoxFit.cover,
                  )
                )
              )
            ),
          );
        },
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}