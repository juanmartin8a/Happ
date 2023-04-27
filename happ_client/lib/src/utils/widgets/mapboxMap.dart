import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happ_client/src/screens/events/widgets/eventMapAttributionDialog.dart';
import 'package:happ_client/src/utils/widgets/UserLocationMarkerAnimation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';


class MapboxMap extends StatelessWidget {
  final MapController? controller;
  final void Function(LatLng) onTap;
  final LatLng startingPos;
  final LatLng? markerPos;
  final LatLng? currentPos;
  const MapboxMap({
    required this.controller,
    required this.onTap,
    required this.startingPos,
    required this.markerPos,
    required this.currentPos,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (_, point) {
              onTap(point);
            },
            center: startingPos,
            zoom: 16,
          ),
          mapController: controller,
          children: [
            TileLayer(
              urlTemplate: 'https://api.mapbox.com/styles/v1/juanmartin8a/clbmlm8zb000c14qr0567d9bo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoianVhbm1hcnRpbjhhIiwiYSI6ImNsYmt5bG5tejAyYzUzcG15YjZ0YXlvc2sifQ.KzBZls5QTMmbpO4iGmxBrQ',
              additionalOptions: const {
                'accessToken': 'pk.eyJ1IjoianVhbm1hcnRpbjhhIiwiYSI6ImNsYmt5bG5tejAyYzUzcG15YjZ0YXlvc2sifQ.KzBZls5QTMmbpO4iGmxBrQ',
              },
            ),
            MarkerLayer(
              markers: [
                if (currentPos != null)
                Marker(
                  point: currentPos!,
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
        )
      ],
    );
  }
}