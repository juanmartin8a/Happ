import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventCompleteState.dart';
import 'package:happ_client/src/screens/events/newEventScreens/DLScreen.dart';
import 'package:happ_client/src/screens/events/newEventScreens/NPDScreen.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/NextButton.dart';
import 'package:happ_client/src/utils/userLocation/UserLocation.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  PageController pageController = PageController();

  late bool userLocationAccess;

  double? latitude;
  double? longitude;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    userLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    
    return Material(
      // color: Colors.red,
      // resizeToAvoidBottomInset: true,
      child: //NPDScreen()
      Stack(
        children: [
          PageView(

            controller: pageController,
            scrollDirection: Axis.vertical,
            // new event form will be divided into 3 screens:
            // 1.- for choosing a name, pictures and a description
            // 2.- for picking a place and location
            // 3.- for inviting people and adding organizers (admins)
            children: [
              const NPDScreen(),
              DLScreen(latitude: latitude, longitude: longitude,)
            ],
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              // width: Medua,
              // color: Color(0xff00ff03),
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
                // bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Center(
                child: Text(
                  "New Event",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20,
                    // letterSpacing: 0.5,
                    // fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    // height: 1
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NextButton(
              animateToPage: animateToPage, 
              page: currentPage
            )
          )
        ],
      ),
    );
  }

  void userLocationPermission() async {
    userLocationAccess = await UserLocation().handleLocationPermission();
    if (!userLocationAccess) return;
    late Position currentPosition;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      currentPosition = position;
    });
    setState(() {
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
    });
  }

  void animateToPage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}