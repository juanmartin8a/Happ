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

  late double bottomPadding;

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

    double pageViewHeight = MediaQuery.of(context).size.height;
    
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: [
              NPDScreen(key: Key("NPD_$uuidKey"), height: pageViewHeight),
              Builder(
                builder: (BuildContext context) {
                  return DLScreen(latitude: latitude, longitude: longitude, height: pageViewHeight, context: context, key: Key("DL_$uuidKey"));
                },
              ),
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
              height: 45 + MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                right: 8,
                left: 8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0), Colors.white],
                  stops: [0, 45 / (45 + MediaQuery.of(context).padding.top)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
              child: Center(
                child: Text(
                  "New Event",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
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
      setState(() {
        eventId = 0;
        uuidKey = const Uuid().v4();
        refresh = true;
      });
    }
  }
}