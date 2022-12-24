import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/PictureSlider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class NPDScreen extends ConsumerStatefulWidget {
  const NPDScreen({Key? key}) : super(key: key);

  @override
  _NPDScreenState createState() => _NPDScreenState();
}

class _NPDScreenState extends ConsumerState<NPDScreen> with AutomaticKeepAliveClientMixin{
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<AssetEntity> imagesList = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.only(
      //   right: 8,
      //   left: 8,
      //   // bottom: MediaQuery.of(context).viewInsets.bottom,
      // ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // Container(
          //   height: 45,
          //   // width: Medua,
          //   // color: Color(0xff00ff03),
          //   padding: const EdgeInsets.only(
          //     right: 8,
          //     left: 8,
          //     // bottom: MediaQuery.of(context).viewInsets.bottom,
          //   ),
          //   margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          //   child: Center(
          //     child: Text(
          //       "Create Event",
          //       style: TextStyle(
          //         color: Colors.grey[800],
          //         fontSize: 20,
          //         // letterSpacing: 0.5,
          //         // fontStyle: FontStyle.normal,
          //         fontWeight: FontWeight.w700,
          //         // height: 1
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 45,
                ),
                // padding: const EdgeInsets.only(
                //   right: 8,
                //   left: 8,
                //   // bottom: MediaQuery.of(context).viewInsets.bottom,
                // ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                            // bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          width: MediaQuery.of(context).size.width,
                          // height: 45,
                          // padding: EdgeInsets.symmetric(horizontal: 8),
                          // color: Colors.red,
                          child: TextFormField(
                            // expands: true,
                            // maxLines: null,
                            controller: nameController,
                            textInputAction: TextInputAction.done,
                            // textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardAppearance: Brightness.dark,
                            style: TextStyle(
                              color: Colors.grey[800]!,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.5
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Event Name',
                              hintStyle: TextStyle(
                                color: Colors.grey[600]!,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 1.5
                              ),
                            ),
                            onChanged: (text) {
                              ref.read(newEventCompleteProvider.notifier).fieldChange(
                                name: text
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const PictureSlider(),
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                            // bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          // height: 45,
                          // padding: EdgeInsets.symmetric(horizontal: 8),
                          // color: Colors.red,
                          child: TextFormField(
                            // expands: true,
                            maxLines: null,
                            controller: descriptionController,
                            textInputAction: TextInputAction.done,
                            // textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardAppearance: Brightness.dark,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                              height: 1.5
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.5
                              ),
                            ),
                            onChanged: (text) {
                              ref.read(newEventCompleteProvider.notifier).fieldChange(
                                description: text
                              );
                            },
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).padding.top + 45,
                      //   // color: Colors.yellow
                      // ),
                      // Container(
                      //   height: 100,
                      //   color: Colors.black
                      // ),
                      // const Spacer(),
                      Container(
                        height: MediaQuery.of(context).viewInsets.bottom,//EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        // color: Colors.red, 
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
  
  @override
  bool get wantKeepAlive => true;
}