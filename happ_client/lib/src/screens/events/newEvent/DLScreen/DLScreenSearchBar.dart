import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetailsState.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/searchLocationScreen.dart';
import 'package:happ_client/src/utils/userLocation/UserLocation.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class DLScreenSearchBar extends ConsumerStatefulWidget {
  final double? latitude;
  final double? longitude;
  final bool isNew;
  const DLScreenSearchBar({
    this.latitude,
    this.longitude,
    this.isNew = true,
    super.key
  });
  // const DLScreenSearchBar({super.key});

  @override
  _DLScreenSearchBarState createState() => _DLScreenSearchBarState();
}

class _DLScreenSearchBarState extends ConsumerState<DLScreenSearchBar> {

  String name = "";

  @override
  Widget build(BuildContext context) {
    ref.listen(
      widget.isNew ? locationDetailsProvider : updateLocationDetailsProvider, 
      (prev, next) {
      if (next is LocationDetailsLoadedState) {
        if (next.name != null) {
          setState(() {  
            name = next.name!;
          });
        }
      }
    });

    ref.listen(
      widget.isNew ? reverseLocationDetailsProvider : updateReverseLocationDetailsProvider,
      (prev, next) {
      if (next is ReverseLocationDetailsLoadedState) {
        setState(() {  
          name = next.name;
        });
      }
    });

    return GestureDetector(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, anim1, anim2) {
                    return SearchLocation(isNew: widget.isNew);
                  }
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: widget.latitude == null
                  ? BorderRadius.circular(20)
                  : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                height: 40,
                child: Row(
                  children: [
                    const FloatingActions(
                      icon: EvaIcons.searchOutline,
                      size: 28,
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      key: Key("searchBarIcon")
                    ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Align(
                          key: ValueKey<String>(const Uuid().v4()),
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              name.isNotEmpty ? name : "Search",
                              maxLines: 1,
                              style: TextStyle(
                                color: name.isNotEmpty ? Colors.grey[800] :Colors.grey[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.25
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.latitude != null)
          const SizedBox(width: 6),
          if (widget.latitude != null)
          GestureDetector(
            onTap: () {
              userLocationPermission();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ) 
              ),
              height: 40,
              width: 50,
              child: const Center(
                // left: 2,
                child: Icon(
                  Icons.near_me_rounded,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void userLocationPermission() async {
    bool userLocationAccess = await UserLocation().handleLocationPermission();
    if (!userLocationAccess) return;
    if (widget.latitude == null) return;
    late Position currentPosition;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      currentPosition = position;
    });
    double latitude = currentPosition.latitude;
    double longitude = currentPosition.longitude;
    ref.read(
      widget.isNew 
      ? locationDetailsProvider.notifier 
      : updateLocationDetailsProvider.notifier
    ).moveToCurrentPosition(
      latitude,
      longitude,
    );
  }
}