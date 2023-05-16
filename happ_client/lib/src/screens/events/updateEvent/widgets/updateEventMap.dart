
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/utils/widgets/mapboxMap.dart';
import 'package:latlong2/latlong.dart' as latLng;

class UpdateEventMap extends ConsumerStatefulWidget {
  final latLng.LatLng? currentPos;
  final latLng.LatLng markerPos;
  const UpdateEventMap({
    required this.currentPos,
    required this.markerPos,
    super.key
  });

  @override
  _UpdateEventMapState createState() => _UpdateEventMapState();
}

class _UpdateEventMapState extends ConsumerState<UpdateEventMap> with AutomaticKeepAliveClientMixin {

  final MapController _mapController = MapController();

  late latLng.LatLng markerPos;

  late latLng.LatLng? currentPos;

  @override
  void initState() {
    super.initState();
    markerPos = widget.markerPos;
    currentPos = widget.currentPos;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(updateLocationDetailsProvider, (prev, next) {
      if (next is LocationDetailsLoadedState) {
        if (next.name != null) {
          final lat = next.details!.latitude;
          final lng = next.details!.longitude;

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);
          ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
            location: newCoordinates,
          );
        }
      } else if (next is MarkLocationLoadedState) {
        ref.read(updateReverseLocationDetailsProvider.notifier).markedPositionDetails(next.details["lat"], next.details["lng"]);
      }
    });
    LocationDetailsState state = ref.watch(updateLocationDetailsProvider);
    if (state is LocationDetailsLoadedState) {
      if (state.error == false) {
        if (state.name != null) {
          final lat = state.details!.latitude;
          final lng = state.details!.longitude;

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

          markerPos = newCoordinates;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _mapController.moveAndRotate(newCoordinates, 16, 0);
          });
        } else {
          final lat = state.details!.latitude;
          final lng = state.details!.longitude;

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

          currentPos = newCoordinates;

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
        ref.read(updateLocationDetailsProvider.notifier).markPosition(
          point.latitude,
          point.longitude
        );
        ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
          location: point,
        );
      },
      startingPos: markerPos,
      currentPos: currentPos,
      markerPos: markerPos,
      key: const Key("updateEventMap")
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}