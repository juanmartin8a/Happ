import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/searchLocationScreen.dart';
import 'package:happ_client/src/utils/userLocation/UserLocation.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class DLScreenSearchBar extends ConsumerStatefulWidget {
  final double? latitude;
  final double? longitude;
  const DLScreenSearchBar({
    this.latitude,
    this.longitude,
    super.key
  });
  // const DLScreenSearchBar({super.key});

  @override
  _DLScreenSearchBarState createState() => _DLScreenSearchBarState();
}

class _DLScreenSearchBarState extends ConsumerState<DLScreenSearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class DLScreenSearchBar extends ConsumerWidget {
//   final double? latitude;
//   final double? longitude;
//   const DLScreenSearchBar({
//     this.latitude,
//     this.longitude,
//     super.key
//   });

  @override
  Widget build(BuildContext context) {
    LocationDetailsState state = ref.watch(locationDetailsProvider);
    String name = "";
    if (state is LocationDetailsLoadedState) {
      if (state.name != null) {
        name = state.name!; 
      }
    }
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
                    return const SearchLocation();
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
                          child: Text(
                            name.isNotEmpty ? name : "Search",
                            maxLines: 1,
                            style: TextStyle(
                              color: name.isNotEmpty ? Colors.grey[800] :Colors.grey[500],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.25
                            )
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
                  size: 28,
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
    ref.read(locationDetailsProvider.notifier).moveToCurrentPosition(
      latitude,
      longitude,
    );
  }
}