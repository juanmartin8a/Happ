import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happ_client/src/screens/events/widgets/eventMapAttributionDialog.dart';
import 'package:happ_client/src/utils/userLocation/UserLocation.dart';
import 'package:happ_client/src/utils/widgets/UserLocationMarkerAnimation.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventMapWidget extends ConsumerStatefulWidget {
  final double latitude;
  final double longitude;
  final String eventPlace;
  const EventMapWidget({
    required this.latitude,
    required this.longitude,
    required this.eventPlace,
    super.key
  });

  @override
  _EventMapWidgetState createState() => _EventMapWidgetState();
}

class _EventMapWidgetState extends ConsumerState<EventMapWidget> with AutomaticKeepAliveClientMixin {

  late bool userLocationAccess;

  final MapController _mapController = MapController();
  // late CameraPosition _initialCameraPosition;


  late latLng.LatLng startingPos;
  // latLng.LatLng? markerPos;

  latLng.LatLng? currentPosMarker;

  // double? latitude;
  // double? longitude;

  @override
  void initState() {
    super.initState();
    startingPos = latLng.LatLng(widget.latitude, widget.longitude);
    // _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userLocationPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3/2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: startingPos,
                    zoom: 15.5,
                  ),
                  mapController: _mapController,
                  children: [
                    TileLayer(
                      urlTemplate: 'https://api.mapbox.com/styles/v1/juanmartin8a/clbmlm8zb000c14qr0567d9bo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoianVhbm1hcnRpbjhhIiwiYSI6ImNsYmt5bG5tejAyYzUzcG15YjZ0YXlvc2sifQ.KzBZls5QTMmbpO4iGmxBrQ',
                      additionalOptions: const {
                        'accessToken': 'pk.eyJ1IjoianVhbm1hcnRpbjhhIiwiYSI6ImNsYmt5bG5tejAyYzUzcG15YjZ0YXlvc2sifQ.KzBZls5QTMmbpO4iGmxBrQ',
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        if (currentPosMarker != null)
                        Marker(
                          point: currentPosMarker!,
                          width: 30,
                          height: 30,
                          // anchorPos: AnchorPos.align(AnchorAlign.top),
                          builder: (context) => const UserLocationMarkerAnimation()
                        ),
                        Marker(
                          point: startingPos,
                          width: 32,
                          height: 32,
                          anchorPos: AnchorPos.align(AnchorAlign.top),
                          builder: (context) => const Icon(
                            FluentIcons.location_16_filled,
                            size: 32,
                            color: Colors.red
                          )
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        context: context, 
                        barrierColor: Colors.transparent,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (context, anim1, anim2) {
                          return const EventMapAttributionDialog();
                        }
                      );
                    },
                    child: const Icon(
                      FluentIcons.info_16_regular,
                      size: 22,
                      color: Colors.blue
                    ),
                  ),
                ),
                Positioned(
                  // alignment: Alignment.bottomLeft,
                  left: 8,
                  bottom: 8,
                  child: GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://www.mapbox.com/about/maps/'));
                    },
                    child: Container(
                      // color: Colors.red,
                      child: SvgPicture.asset(
                        // uriName,
                        // color:Colors.red,
                        width: 80,
                        // height: 20,
                        "assets/logos/mapbox-logo-svg-black.svg",
                        placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 4
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.eventPlace,
            // maxLines: 1,
            style:  TextStyle(
              color: Colors.grey[800]!,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1
            )
          ),
        ),
        // MapboxMap(initialCameraPosition: initialCameraPosition)
      ],
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
      currentPosMarker = latLng.LatLng(currentPosition.latitude, currentPosition.longitude);
    });
  }
  
  @override
  bool get wantKeepAlive => true;
}