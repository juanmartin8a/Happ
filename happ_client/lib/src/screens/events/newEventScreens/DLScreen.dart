import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/DLScreenSearchBar.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/dateAndTimeFields.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/dateTimePicker.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/mapWidget.dart';

class DLScreen extends ConsumerStatefulWidget {
  final double? latitude;
  final double? longitude;
  const DLScreen({
    this.latitude,
    this.longitude,
    Key? key
  }) : super(key: key);

  @override
  _DLScreenState createState() => _DLScreenState();
}

class _DLScreenState extends ConsumerState<DLScreen> with AutomaticKeepAliveClientMixin {
  late bool userLocationAccess;

  @override
  void initState() {
    super.initState();
  }

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
      child: Container(
        // color: Colors.red,
        // height: MediaQuery.of(context).size.height,
        // constraints: BoxConstraints(
        //   minHeight: MediaQuery.of(context).size.height - 45,
        // ),
        padding: const EdgeInsets.only(
          right: 8,
          left: 8,
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 45 + MediaQuery.of(context).padding.top,
            ),
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
            // SizedBox(
            //   height: MediaQuery.of(context).padding.top + 45,
            //   // color: Colors.yellow
            // ),
            Container(
              height: MediaQuery.of(context).viewInsets.bottom,//EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              // color: Colors.red, 
            ),
            const SizedBox(height: 45 + 20),
            const Spacer(),
          ],
        ),
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
  
  @override
  bool get wantKeepAlive => true;
}

// next 

// add user location marker
// button to go to user's location
// put marked location on the map
// a button to use user's location