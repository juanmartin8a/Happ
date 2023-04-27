import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdatePictureActions/pictureActions.dart';

class ImageActionsDialog extends ConsumerWidget {
  final int index;
  final String? uuid;
  const ImageActionsDialog({
    required this.index,
    this.uuid,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black26)
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.6,
                    // height: (MediaQuery.of(context).size.width * 0.8) * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            ref.read(picturesActionsProvider.notifier).pictureAction(index, PictureAction.replace, uuid);
                          },
                          child: Container(
                            height: 45,
                            // width: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                        
                                  Icon(
                                    FluentIcons.edit_16_regular,
                                    size: 26,
                                    color: Colors.white
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Replace',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            ref.read(picturesActionsProvider.notifier).pictureAction(index, PictureAction.delete, uuid);
                          },
                          child: Container(
                            height: 45,
                            // width: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                        
                                  Icon(
                                    FluentIcons.delete_16_regular,
                                    size: 26,
                                    color: Colors.red
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Remove',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1
                        )
                      ),
                    ),
                    
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}