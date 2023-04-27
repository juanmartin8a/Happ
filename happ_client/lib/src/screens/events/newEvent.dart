import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/newEventAddPictures/newEventAddPictures.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen.dart';
import 'package:happ_client/src/screens/events/newEvent/NPDScreen.dart';
import 'package:happ_client/src/screens/events/newEvent/widgets/NextButton.dart';
import 'package:happ_client/src/utils/userLocation/UserLocation.dart';
import 'package:uuid/uuid.dart';

class NewEvent extends ConsumerStatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends ConsumerState<NewEvent> {
  PageController pageController = PageController();

  late bool userLocationAccess;

  double? latitude;
  double? longitude;

  int currentPage = 0;

  int eventId = 0;

  bool refresh = false;

  late String uuidKey;

  @override
  void initState() {
    super.initState();
    uuidKey = const Uuid().v4();
    userLocationPermission();
  }

  @override
  Widget build(BuildContext context) {

    if (refresh == true) {
      ref.invalidate(pickDateControllerProvider);
      ref.invalidate(addPicturesProvider);
      ref.invalidate(newEventCompleteProvider);
      ref.invalidate(inviteUserSelectProvider);
      ref.invalidate(locationDetailsProvider);
      refresh = false;
    }
    
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
              NPDScreen(key: Key("NPD_$uuidKey")),
              DLScreen(latitude: latitude, longitude: longitude, key: Key("DL_$uuidKey")),
              IScreen(eventId: eventId, key: Key("I_$uuidKey"))
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
              page: currentPage,
              key: Key("nextButtonKey_$uuidKey")
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

  void animateToPage(int page, {int newEventId = 0, bool callRefresh = false}) {
    if (page == 2) {
      setState(() {
        eventId = newEventId;
      });
    }
    pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.ease);
    if (callRefresh == true) {
      // reset newEventCompleteField
      // reset pictureSlider
      // reset dateAndTimeFields
      // reset inviteGuests
      // change key in all of them, key is inherited by every child from its parent
      setState(() {
        eventId = 0;
        uuidKey = const Uuid().v4();
        refresh = true;
      });
    }
  }
}