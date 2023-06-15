import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/widgets/floatingActions.dart';


class EventInvitation extends ConsumerStatefulWidget {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event;
  final String? cypherText;
  const EventInvitation({
    required this.event,
    required this.cypherText,
    super.key,
  });

  @override
  _EventInvitationState createState() => _EventInvitationState();
}

class _EventInvitationState extends ConsumerState<EventInvitation> {
  late final WebViewController controller;

  Color widgetColor = Colors.black;
  bool isDefault = true;
  String? cypherText;
  // bool? isLoading;

  @override
  void initState() {
    super.initState();
    if (widget.cypherText != null) {
      // isLoading = true;
      final html = dynamicHTML();
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              setState(() {
                // isLoading = false;
              });
            },
          ),
        )
        ..loadHtmlString(html);
    }
  }
  
  @override
  Widget build(BuildContext context) {

    if (widget.cypherText == null) {
      return Material(
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Could not generate event pass.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  )
                ),
              ),
              Positioned(
                left: 0,
                child: SizedBox(
                  height: 45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FloatingActions(
                      icon: EvaIcons.arrowBackOutline, 
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      // padding:  EdgeInsets.zero,
                      color: Colors.black,
                      size: 36,
                      key: Key("goBack_${widget.event.id}")
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    UserFromId$Query$User user = ref.read(currentUserProvider)!;
    
    return Material(
      color: const Color.fromARGB(255, 1, 228, 96),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 45),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Text(
                      widget.event.name,
                      // "Testing 1 testing 1 testing 1!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )
                    ),
                  )
                ),
                 Center(
                  child: Text(
                    "Pass",
                    style:  TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      // color: Colors.black,
                      color:Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 7,
                          color: Colors.black.withOpacity(0.15),
                        )
                      ],
                    )
                  )
                ),
                const SizedBox(height: 55),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      user.profilePic,
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    user.name,
                     style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )
                  )
                ),
                const SizedBox(height: 0),
                Center(
                  child: Text(
                    "@${user.username}",
                     style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      )
                  )
                ),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.55,
                    width: MediaQuery.of(context).size.width * 0.55,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      child: Stack(
                        children: [
                          WebViewWidget(
                            controller: controller,
                            key: Key(const Uuid().v4())
                          ),
                          Container(
                            color: Colors.transparent,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 34),
                    child: const Text(
                      ";)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )
                    ),
                  )
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom > 34 ? MediaQuery.of(context).padding.bottom + 12 : 34,
                )
              ],
            ),
            Positioned(
              left: 0,
              child: SizedBox(
                height: 45,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: FloatingActions(
                    icon: EvaIcons.arrowBackOutline, 
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    // padding:  EdgeInsets.zero,
                    color: Colors.black,
                    size: 36,
                    key: Key("goBack_${widget.event.id}")
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  String dynamicHTML() {
    final html = '''<!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <title>QR Code Styling</title>
          <script type="text/javascript" src="https://unpkg.com/qr-code-styling@1.5.0/lib/qr-code-styling.js"></script>
      </head>
      <style>
        html, body {
          overflow: hidden;
          margin: 0;
          padding: 0;
          height: 100vh;
          width: 100vw;
          display: flex;
          justify-content: center;
          align-items: center;
        }
        #canvas  {
          background-color: white;
          height: 100vh;
          width: 100vw;
        }
      </style>
      <body>
      <div id="canvas"></div>
      <script type="text/javascript">

        document.addEventListener('DOMContentLoaded', function () {
          setTimeout(function() {
            const qrCode = new QRCodeStyling({
                width: window.innerWidth,
                height: window.innerHeight,
                margin: 0,
                type: "svg",
                data: "${widget.cypherText}",
                dotsOptions: {
                    color: "#000000",
                    type: "rounded"
                },
                cornersSquareOptions: {
                  type: "extra-rounded"
                },
                qrOptions: {
                  errorCorrectionLevel: 'M'
                }
            });

            qrCode.append(document.getElementById("canvas"));
          }, 150);
        });

      </script>
      </body>
      </html>''';

      return html;
  }
}