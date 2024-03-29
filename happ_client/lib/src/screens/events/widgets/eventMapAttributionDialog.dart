import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class EventMapAttributionDialog extends StatelessWidget {
  const EventMapAttributionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);


    return AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top status bar
        systemNavigationBarColor: Colors.black.withOpacity(0.001), // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        // systemNavigationBarIconBrightness: null,
        
            // Brightness.dark, //navigation bar icons' color

      ),

      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.black26)
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.8,
                      // height: (MediaQuery.of(context).size.width * 0.8) * 0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 45,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: '© Mapbox',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                          Uri.parse('https://www.mapbox.com/about/maps/'));
                                    },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: '© OpenStreetMap',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                          Uri.parse('http://www.openstreetmap.org/copyright'));
                                    },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Improve this map',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                          Uri.parse('https://www.mapbox.com/map-feedback/'));
                                    },
                                ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1
                          )
                        ),
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}