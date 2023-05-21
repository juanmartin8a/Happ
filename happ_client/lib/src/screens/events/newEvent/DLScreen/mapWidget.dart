import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/utils/widgets/mapboxMap.dart';
import 'package:latlong2/latlong.dart' as latLng;

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
          final lat = next.details!.latitude;
          final lng = next.details!.longitude;
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
          final lat = state.details!.latitude;
          final lng = state.details!.longitude;

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

          startingPos = newCoordinates;
          markerPos = newCoordinates;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _mapController.moveAndRotate(newCoordinates, 16, 0);
          });
        } else {
          final lat = state.details!.latitude;
          final lng = state.details!.longitude;

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
  }
  
  @override
  bool get wantKeepAlive => true;
}