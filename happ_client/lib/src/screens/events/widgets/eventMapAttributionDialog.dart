import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventMapAttributionDialog extends StatelessWidget {
  const EventMapAttributionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
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
                        Container(
                          height: 45,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: '© Mapbox',
                                style: TextStyle(
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
                        Container(
                          height: 45,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: '© OpenStreetMap',
                                style: TextStyle(
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
                        Container(
                          height: 45,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Improve this map',
                                style: TextStyle(
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
                    // if (dateOrTime != null) {
                    //   if (isDate) {
                    //     ref.read(pickDateControllerProvider.notifier).pickDate(dateOrTime!);
                    //     ref.read(newEventCompleteProvider.notifier).fieldChange(
                    //       date: dateOrTime
                    //     );
                    //   } else {
                    //     ref.read(pickTimeControllerProvider.notifier).pickTime(dateOrTime!);
                    //     ref.read(newEventCompleteProvider.notifier).fieldChange(
                    //       time: dateOrTime
                    //     );
                    //   }
                    // }
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
    );
  }
}