import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdatePictureActions/pictureActions.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearch.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEvent.dart';
import 'package:happ_client/src/riverpod/updatePictures/updatePictures.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/DLScreenSearchBar.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/editAddressName.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/updateButton.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/updateDatetime.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/updateDatetimePicker.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/updateEventMap.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/updateEventPictureSlider.dart';
import 'package:happ_client/src/utils/userLocation/UserLocation.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:http/src/multipart_file.dart';
import 'package:photo_manager/photo_manager.dart';

class CustomImage {
  final String? imageUrl;
  final AssetEntity? assetEntityImage;
  final bool isAsset;

  CustomImage({this.imageUrl, this.assetEntityImage, this.isAsset = false});
}

class UpdateEvent extends ConsumerStatefulWidget {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes inviteRes;
  const UpdateEvent({
    required this.inviteRes,
    super.key
  });

  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends ConsumerState<UpdateEvent> {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late bool userLocationAccess;

  double? latitude;
  double? longitude;

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event;

  @override
  void initState() {
    super.initState();
    event = widget.inviteRes.event;
    nameController.text = event.name;
    descriptionController.text = event.description;
    userLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen()
    return Material (
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top
              ),
              Container(
                height: 45,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          invalidateProviders();
                          Navigator.pop(context);
                        },
                        child: FloatingActions(
                          icon: EvaIcons.arrowBackOutline,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          // padding:  EdgeInsets.zero,
                          color: Colors.grey[800]!,
                          size: 36,
                          key: Key("goBack_update_${event.id}")
                        )
                      ),
                    ),
                    // const Spacer(),
                    Center(
                      child: Text(
                        "Update Event",
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
                    // const Spacer(),
                    // const Spacer(),
                  ],
                )
              ),
              Expanded(
                // padding: EdgeInsets.symmetric(horizontal:8),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      // const Spacer(),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 12,
                            left: 12,
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
                              height: 1.25
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
                                height: 1.25
                              ),
                            ),
                            onChanged: (text) {
                              // ref.read(newEventCompleteProvider.notifier).fieldChange(
                              //   name: text
                              // );
                              ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
                                name: text
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // const PictureSlider(),
                      SizedBox(
                        height: (MediaQuery.of(context).size.width - 24) * 0.75,
                        child: UpdateEventPictureSlider(
                          eventPics: event.eventPics, 
                          key: const Key("UpdateEventPictureSlider"),
                        )
                        // PageView.builder(
                        //   itemCount: updateEventPics.length,//event.eventPics.length,
                        //   onPageChanged: (value) {
                        //     // setState(() {
                        //     //   // currentPage = value;
                        //     // });
                        //   },
                        //   itemBuilder: (context, i) {
                        //     return GestureDetector(
                        //       onTap: () {
                        //         showGeneralDialog(
                        //           context: context, 
                        //           barrierColor: Colors.transparent,
                        //           transitionDuration: const Duration(milliseconds: 200),
                        //           pageBuilder: (context, anim1, anim2) {
                        //             return const ImageActionsDialog();
                        //           }
                        //         );
                        //       },
                        //       child: Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         padding: const EdgeInsets.symmetric(horizontal: 12),
                        //         // height: MediaQuery.of(context).size.width,
                        //         child: AspectRatio(
                        //           aspectRatio: 4/3,
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(20),
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 color: Colors.grey[200],
                        //                 borderRadius: BorderRadius.circular(20)
                        //               ),
                        //               // user taps image
                        //               // user selects action
                            
                        //               // if remove then dialog close and remove image
                            
                        //               // if edit dialog close and open photos dialog
                        //               // when image chosen, load images, replace and close dialog 
                        //               child: Image.network(
                        //                 updateEventPics[i].imageUrl!,
                        //                 fit: BoxFit.cover
                        //               ),//Image.asset('assets/images/image2.jpeg', fit: BoxFit.cover)
                        //             ),
                        //           )
                        //         )
                        //       ),
                        //     );
                        //   }
                        // ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            right: 12,
                            left: 12,
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
                              height: 1.25
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              // alignLabelWithHint: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.25
                              ),
                            ),
                            onChanged: (text) {
                              ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
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
                      // Container(
                      //   height: MediaQuery.of(context).viewInsets.bottom,//EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      //   // color: Colors.red, 
                      // ),
                      const SizedBox(height: 40),
                      // const Spacer(),
                      Container(
                        // color: Colors.red,
                        // height: MediaQuery.of(context).size.height,
                        // constraints: BoxConstraints(
                        //   minHeight: MediaQuery.of(context).size.height - 45,
                        // ),
                        padding: const EdgeInsets.only(
                          right: 12,
                          left: 12,
                          // bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                // move this to UpdateDateTime
                                GestureDetector(
                                  onTap: () {
                                    showDialog(true);
                                  },
                                  child: UpdateDatetime(
                                    isDate: true,
                                    dateTime: DateTime.fromMillisecondsSinceEpoch(int.parse(event.eventDate)),
                                    key: const Key("updateDatetime_Date")
                                  )
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(false);
                                  },
                                  child: UpdateDatetime(
                                    isDate: false,
                                    dateTime: DateTime.fromMillisecondsSinceEpoch(int.parse(event.eventDate)),
                                    key: const Key("updateDateTime_Time")
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
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
                            DLScreenSearchBar(latitude: latitude, longitude: longitude, isNew: false),
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
                                      child: UpdateEventMap(
                                        currentPos: latitude != null 
                                          ? latLng.LatLng(latitude!, longitude!)
                                          : null, 
                                        markerPos: latLng.LatLng(event.coords.latitude, event.coords.longitude)
                                      )
                                    ),
                                  ],
                                )
                              )
                            ),
                            const SizedBox(height: 8),
                            DLScreenEditAddress(isNew: false, address: event.eventPlace),
                            // SizedBox(
                            //   height: MediaQuery.of(context).padding.top + 45,
                            //   // color: Colors.yellow
                            // ),
                            // Container(
                            //   height: MediaQuery.of(context).viewInsets.bottom,//EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            //   // color: Colors.red, 
                            // ),
                            // const SizedBox(height: 45 + 20),
                            // const Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                      const SizedBox(height: 150)
                    ],
                  ),
                )
              )
            ],
          ),
          Positioned(
            bottom: 34,
            left: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.5)) / 2,
            child: UpdateButton(event: event)
          )
        ],
      )
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

  void showDialog(bool isDate) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return UpdateDatetimePicker(
          isDate: isDate,
          datetime: DateTime.fromMillisecondsSinceEpoch(int.parse(event.eventDate)),
          key: const Key("date_picker_newEvent"),
        );
      }
    );
  }

  void invalidateProviders() {
    ref.invalidate(locationSearchProvider);
    ref.invalidate(updatePickDateControllerProvider);
    ref.invalidate(updatePickTimeControllerProvider);
    ref.invalidate(updateLocationDetailsProvider);
    ref.invalidate(updateReverseLocationDetailsProvider);
    ref.invalidate(eventUpdateReadyControllerProvider);
    ref.invalidate(picturesActionsProvider);
    ref.invalidate(updatePicturesProvider);
    ref.invalidate(updateEventProvider);
  }
}