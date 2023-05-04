import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatefulWidget {
  final int eventId;
  const ScanScreen({
    required this.eventId,
    super.key
  });

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        child: Stack(
          children: [
            MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                }
              },
            ),
            Container(
              height: 45 + MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top:  MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black26],
                  stops: [0, 0.75],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      "Scan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700
                      )
                    )
                  ),
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 45,
                        child: FloatingActions(
                          icon: EvaIcons.arrowBackOutline,
                          color: Colors.white,
                          size: 36,
                          key: Key("goBackScan_${widget.eventId}")
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}