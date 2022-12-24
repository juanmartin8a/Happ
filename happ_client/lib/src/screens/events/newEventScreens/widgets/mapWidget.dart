import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/utils/widgets/UserLocationMarkerAnimation.dart';
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
        final lat = next.details["result"]["geometry"]["location"]["lat"];
        final lng = next.details["result"]["geometry"]["location"]["lng"];

        latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);
        ref.read(newEventCompleteProvider.notifier).fieldChange(
          location: newCoordinates
        );
      }
    });
    LocationDetailsState state = ref.watch(locationDetailsProvider);
    if (state is LocationDetailsLoadedState) {
      if (state.error == false) {
        if (state.name != null) {
          final lat = state.details["result"]["geometry"]["location"]["lat"];
          final lng = state.details["result"]["geometry"]["location"]["lng"];

          latLng.LatLng newCoordinates = latLng.LatLng(lat, lng);

          startingPos = newCoordinates;
          markerPos = newCoordinates;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _mapController.moveAndRotate(newCoordinates, 16, 0);
          });

          // ref.watch(newEventCompleteProvider.notifier).fieldChange(
          //   location: newCoordinates
          // );
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

    return FlutterMap(
      options: MapOptions(
        onTap: (_, point) {
          // print(tapPosition);
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
      // nonRotatedChildren: [
      //   AttributionWidget.defaultWidget(
      //     source: 'OpenStreetMap contributors',
      //     onSourceTapped: null,
      //   ),
      // ],
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
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}