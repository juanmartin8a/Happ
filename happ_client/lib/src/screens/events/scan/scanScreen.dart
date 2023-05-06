import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/scanPass/scanPass.dart';
import 'package:happ_client/src/riverpod/scanPass/scanPassState.dart';
import 'package:happ_client/src/screens/events/scan/widgets/processPassDialog.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';

class ScanScreen extends ConsumerStatefulWidget {
  final int eventId;
  const ScanScreen({
    required this.eventId,
    super.key
  });

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {

  final MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    controller.stop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  if (ref.read(scanPassProvider) is ScanPassInitState) {
                    ref.read(scanPassProvider.notifier).scanPass(widget.eventId, barcodes[0].rawValue!);
                    showGeneralDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, anim1, anim2) {
                        return const ProcessPass();
                      }
                    );
                  }
                }
              },
              // key: Key(const Uuid().v4())
            ),
            Container(
              height: 45 + MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top:  MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black26],
                  // stops: [-10, 1],
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