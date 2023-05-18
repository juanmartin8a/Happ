import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/screens/events/newEvent/NPDScreen/PictureSlider.dart';
import 'package:photo_manager/photo_manager.dart';

class NPDScreen extends ConsumerStatefulWidget {
  final double height;
  const NPDScreen({
    required this.height,
    Key? key
  }) : super(key: key);

  @override
  _NPDScreenState createState() => _NPDScreenState();
}

class _NPDScreenState extends ConsumerState<NPDScreen> with AutomaticKeepAliveClientMixin {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  final nameGlobalKey = GlobalKey();
  final descriptionGlobalKey = GlobalKey();

  late double nameDYPos;
  late double descriptionDYPos;

  late double initNameHeight;
  late double initDescriptionHeight;
  late double nameHeight;
  late double descriptionHeight;

  List<AssetEntity> imagesList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nameRes = getDYPos(nameGlobalKey);
      nameDYPos = nameRes[0];
      initNameHeight = nameRes[1];
      nameHeight = initNameHeight;

      final descriptionRes = getDYPos(descriptionGlobalKey);
      descriptionDYPos = descriptionRes[0];
      initDescriptionHeight = descriptionRes[1];
      descriptionHeight = initDescriptionHeight;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    nameFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      // height: 782,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              // physics: const ClampingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: widget.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                          ),
                          key: nameGlobalKey,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: nameController,
                            textInputAction: TextInputAction.done,
                            focusNode: nameFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardAppearance: Brightness.dark,
                            autofocus: false,
                            maxLength: 40,
                            style: TextStyle(
                              color: Colors.grey[800]!,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              height: 1.25
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              alignLabelWithHint: true,
                              counterText: "",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Event Name',
                              hintStyle: TextStyle(
                                color: Colors.grey[600]!,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                height: 1.25
                              ),
                            ),
                            onChanged: (text) {
                              ref.read(newEventCompleteProvider.notifier).fieldChange(
                                name: text
                              );
                              setState(() {
                                nameHeight = getWidgetHeight(descriptionGlobalKey, null);
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const PictureSlider(),
                      const SizedBox(height: 6),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                          ),
                          key: descriptionGlobalKey,
                          child: TextFormField(
                            maxLines: null,
                            controller: descriptionController,
                            textInputAction: TextInputAction.done,
                            focusNode: descriptionFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardAppearance: Brightness.dark,
                            autofocus: false,
                            maxLength: 200,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                              height: 1.25
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              alignLabelWithHint: true,
                              counterText: "",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.25
                              ),
                            ),
                            onChanged: (text) {
                              ref.read(newEventCompleteProvider.notifier).fieldChange(
                                description: text
                              );
                              setState(() {
                                descriptionHeight = getWidgetHeight(descriptionGlobalKey, null);
                              });
                            },
                          ),
                        ),
                      ),
                      // Container(height: 8.875 * 2, color: Colors.blue),
                      Builder(
                        builder: (context) {
                          double heightToSkip = 0;
                          if (nameFocusNode.hasFocus) {
                            double screenHeight = MediaQuery.of(context).size.height;
                            double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                            double keyboardTop = screenHeight - keyboardHeight;

                            double nameDYPosBottom = nameDYPos + (nameHeight + 6);

                            double heightToAdd = 0;
                            if (nameDYPosBottom > keyboardTop) {
                              heightToAdd = nameDYPosBottom - keyboardTop;
                            }

                            heightToSkip = heightToAdd;
                          } else if (descriptionFocusNode.hasFocus) {
                            double screenHeight = MediaQuery.of(context).size.height;
                            double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                            double keyboardTop = screenHeight - keyboardHeight;

                            double descriptionDYPosBottom = descriptionDYPos + (descriptionHeight + 6); // 6 is for bottom padding

                            double heightToAdd = 0;
                            if (descriptionDYPosBottom > keyboardTop) {
                              heightToAdd = (descriptionDYPosBottom - keyboardTop);
                            }

                            heightToSkip = heightToAdd;
                          }
                          return SizedBox(
                            height: heightToSkip * 2, // * 2 Because the widgets are vertically centered
                          );
                        }
                      ),
                      const SizedBox(height: 45 + 20),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  List getDYPos(GlobalKey<State<StatefulWidget>> globalKey) {
    final renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero); // position of the widget
    final widgetHeight = getWidgetHeight(globalKey, renderBox);

    final pos = position.dy;

    return [pos, widgetHeight];
  }

  double getWidgetHeight(GlobalKey<State<StatefulWidget>> globalKey, RenderBox? renderBoxP) {
    RenderBox renderBox;
    if (renderBoxP != null) {
      renderBox = renderBoxP;
    } else {
      renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    }
    final widgetHeight = renderBox.size.height;

    return widgetHeight;
  }
  
  @override
  bool get wantKeepAlive => true;
}