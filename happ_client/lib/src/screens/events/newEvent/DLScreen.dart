import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/DLScreenSearchBar.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/dateAndTimeFields.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/dateTimePicker.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/editAddressName.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/mapWidget.dart';

class DLScreen extends ConsumerStatefulWidget {
  final double? latitude;
  final double? longitude;
  final double height;
  final BuildContext context;
  const DLScreen({
    this.latitude,
    this.longitude,
    required this.height,
    required this.context,
    Key? key
  }) : super(key: key);

  @override
  _DLScreenState createState() => _DLScreenState();
}

class _DLScreenState extends ConsumerState<DLScreen> with AutomaticKeepAliveClientMixin {
  late bool userLocationAccess;

  final addressGlobalKey = GlobalKey();

  late double addressDYPos;

  late double initAddressHeight;
  late double addressHeight;

  bool hasBeenInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final addressRes = getDYPos(addressGlobalKey);
      addressDYPos = addressRes[0];
      initAddressHeight = addressRes[1];
      addressHeight = initAddressHeight;
      hasBeenInitialized = true;
    });
  }


  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        right: 8,
        left: 8,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: widget.height,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(
                      //   height: 45 + MediaQuery.of(context).padding.top,
                      // ),
                      const Spacer(),
                      Text(
                        "Date and Time",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                          height: 1
                        )
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(true);
                            },
                            child: const DateAndTimeWidget(
                              isDate: true,
                              key: Key("dateAndTimeField_Date")
                            )
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(false);
                            },
                            child: const DateAndTimeWidget(
                              isDate: false,
                              key: Key("dateAndTimeField_Time")
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                          height: 1
                        )
                      ),
                      const SizedBox(height: 4),
                      DLScreenSearchBar(latitude: widget.latitude, longitude: widget.longitude),
                      const SizedBox(height: 8),
                      AspectRatio(
                        aspectRatio: 3/2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: MapWidget(
                                  latitude: widget.latitude, longitude: widget.longitude
                                )
                              ),
                            ],
                          )
                        )
                      ),
                      Container(height: 8, ),
                      Container(
                        key: addressGlobalKey,
                        // padding: EdgeInsets.only(bottom: 8),
                        // color: Colors.blue,
                        child: const DLScreenEditAddress(),
                      ),
                      // Container(height: 8, color: Colors.green,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).padding.top + 45,
                      //   // color: Colors.yellow
                      // ),
                      Builder(
                        builder: (context) {
                          double heightToAdd = 0;
                          if (hasBeenInitialized) {
                            double screenHeight = MediaQuery.of(context).size.height;
                            double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                            double keyboardTop = screenHeight - keyboardHeight;

                            double addressDYPosBottom = addressDYPos + (addressHeight + 8);

                            double preHeightToAdd = 0;
                            if (addressDYPosBottom > keyboardTop) {
                              preHeightToAdd = addressDYPosBottom - keyboardTop;
                            }

                            heightToAdd = preHeightToAdd;
                          }

                          return SizedBox(
                            height: heightToAdd * 2 // * 2 Because the widgets are vertically centered
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

  void showDialog(bool isDate) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return DateTimePicker(
          isDate: isDate,
          key: const Key("date_picker_newEvent"),
        );
      }
    );
  }

  List getDYPos(GlobalKey<State<StatefulWidget>> globalKey) {
    final pageRenderBox = widget.context.findRenderObject() as RenderBox;
    final renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: pageRenderBox);
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