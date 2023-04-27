import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/screens/events/widgets/eventMapAttributionDialog.dart';
import 'package:happ_client/src/utils/widgets/UserLocationMarkerAnimation.dart';
import 'package:happ_client/src/utils/widgets/mapboxMap.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends ConsumerStatefulWidget {
  final double? latitude;
  final double? longitude;
  const MapWidget({
    this.latitude,
    this.longitude,
    super.key
  });

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends ConsumerState<MapWidget> with AutomaticKeepAliveClientMixin {

  final MapController _mapController = MapController();

  late latLng.LatLng startingPos;
  latLng.LatLng? markerPos;

  double? latitude;
  double? longitude;

  latLng.LatLng? currentPosMarker;

  @override
  void initState() {
    super.initState();
    latitude = widget.latitude;
    longitude = widget.longitude;
    if (longitude != null) {
      currentPosMarker = latLng.LatLng(latitude!, longitude!);
      startingPos = currentPosMarker!;
    } else {
      startingPos = latLng.LatLng(51.509364, -0.128928);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(locationDetailsProvider, (prev, next) {
      if (next is LocationDetailsLoadedState) {
        if (next.name != null) {
          final lat = next.details["results"][0]["geometry"]["location"]["lat"];
          final lng = next.details["results"][0]["geometry"]["location"]["lng"];
          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);
          ref.read(newEventCompleteProvider.notifier).fieldChange(
            location: newCoordinates,
            eventPlace: next.name,
            // eventPlace: next.name,
          );
        }
      } else if (next is MarkLocationLoadedState) {
        ref.read(reverseLocationDetailsProvider.notifier).markedPositionDetails(next.details["lat"], next.details["lng"]);
      }
    });
    LocationDetailsState state = ref.watch(locationDetailsProvider);
    if (state is LocationDetailsLoadedState) {
      if (state.error == false) {
        if (state.name != null) {
          final lat = state.details["results"][0]["geometry"]["location"]["lat"];
          final lng = state.details["results"][0]["geometry"]["location"]["lng"];

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

          startingPos = newCoordinates;
          markerPos = newCoordinates;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _mapController.moveAndRotate(newCoordinates, 16, 0);
          });
        } else {
          final lat = state.details["lat"];
          final lng = state.details["lng"];

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

          latitude = lat;
          longitude = lng;

          currentPosMarker = latLng.LatLng(lat, lng);

          startingPos = newCoordinates;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _mapController.moveAndRotate(newCoordinates, 16, 0);
          });
        }
      }
    } else if (state is MarkLocationLoadedState) {
      final lat = state.details["lat"];
      final lng = state.details["lng"];

      latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

      markerPos = newCoordinates;
    }

    return MapboxMap(
      controller: _mapController,
      onTap: (point) {
        ref.read(locationDetailsProvider.notifier).markPosition(
          point.latitude,
          point.longitude
        );
        ref.read(newEventCompleteProvider.notifier).fieldChange(
          location: point
        );
      },
      startingPos: startingPos,
      currentPos: currentPosMarker,
      markerPos: markerPos,
      key: const Key("newEventMap")
    );
    Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (_, point) async {
              ref.read(locationDetailsProvider.notifier).markPosition(
                point.latitude,
                point.longitude
              );
              ref.read(newEventCompleteProvider.notifier).fieldChange(
                location: point
              );
            },
            center: startingPos,
            zoom: 16,
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
                if (latitude != null)
                Marker(
                  point: currentPosMarker!,
                  width: 30,
                  height: 30,
                  // anchorPos: AnchorPos.align(AnchorAlign.top),
                  builder: (context) => const UserLocationMarkerAnimation()
                ),
                if (markerPos != null)
                Marker(
                  point: markerPos!,
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
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}