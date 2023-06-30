import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/acceptInvitation/acceptInvitation.dart';
import 'package:happ_client/src/riverpod/acceptInvitation/acceptInvitationState.dart';
import 'package:happ_client/src/riverpod/seePass/seePass.dart';
import 'package:happ_client/src/riverpod/seePass/seePassState.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/screens/main/widgets/otherInvitations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AcceptButton extends ConsumerStatefulWidget {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes inviteRes;
  const AcceptButton({
    required this.inviteRes,
    super.key
  });

  @override
  _AcceptButtonState createState() => _AcceptButtonState();
}

class _AcceptButtonState extends ConsumerState<AcceptButton> with AutomaticKeepAliveClientMixin {
  WebViewController? controller;
  
  bool isDone = false;
  bool isLoading = false;

  bool isFirst = true;

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event;
  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo userInfo;

  late bool isCreator;
  late bool isHost;
  late bool isConfirmed;

  @override
  void initState() {
    super.initState();
    event = widget.inviteRes.event;
    userInfo = widget.inviteRes.invitedUserInfo;

    isCreator = userInfo.isCreator;
    isHost = userInfo.isHost;
    isConfirmed = userInfo.isConfirmed;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(acceptInvitationProvider, (previous, next) {
      if (next is AcceptInvitationDoneState) {

        if (!next.acceptInviteRes.isHost) {

          if (next.acceptInviteRes.cypherText != null) {

            final html = dynamicHTML(next.acceptInviteRes.cypherText!);
            controller = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..addJavaScriptChannel("Print", onMessageReceived: (message) {
                final blob = message.message;
                final stripped = blob.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

                Uint8List image = const Base64Codec().decode(stripped);

                context.push(
                  '/event-invitation',
                  extra: InviteParams(
                    event: event,
                    cypherText: next.acceptInviteRes.cypherText,
                    image: image
                  )
                );
                setState(() {
                  isDone = true;
                  isLoading = false;
                  isConfirmed = true;
                });
              })
              ..loadHtmlString(html);
          } else {
            context.push(
              '/event-invitation',
              extra: InviteParams(
                event: event,
                cypherText: next.acceptInviteRes.cypherText,
                image: null
              )
            );
            setState(() {
              isDone = true;
              isLoading = false;
              isConfirmed = true;
            });
          }
        } else {
          setState(() {
            isDone = true;
            isLoading = false;
            isConfirmed = true;
          });
        }

        final userInfoJson = userInfo.toJson();
        
        userInfoJson["isConfirmed"] = true;

        final newUserInfo = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo.fromJson(userInfoJson);

        ref.read(userEventsProvider.notifier).updateUserInfo(false, widget.inviteRes, newUserInfo);
        
      } else if (next is AcceptInvitationLoadingState) {
        setState(() {
          isDone = false;
          isLoading = true;
        });
      }
    });

    ref.listen(seePassProvider, (previous, next) {
      if (next is SeePassDoneState) {

        if (next.cypherText != null) {

          final html = dynamicHTML(next.cypherText!);
          controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..addJavaScriptChannel("Print", onMessageReceived: (message) {
              final blob = message.message;
              final stripped = blob.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

              Uint8List image = const Base64Codec().decode(stripped);

              context.push(
                '/event-invitation',
                extra: InviteParams(
                  event: event,
                  cypherText: next.cypherText,
                  image: image
                )
              );

              setState(() {
                isDone = true;
                isLoading = false;
              });
            })
            ..loadHtmlString(html);
        } else {
          context.push(
            '/event-invitation',
            extra: InviteParams(
              event: event,
              cypherText: next.cypherText,
              image: null
            )
          );

          setState(() {
            isDone = true;
            isLoading = false;
          });
        }
        
      } else if (next is SeePassLoadingState) {
        setState(() {
          isDone = false;
          isLoading = true;
        });
      }
    });

    String buttonTextString = "";

    if (isCreator) {
      buttonTextString = "Scan";
    } else if (isHost) {
      if (isConfirmed) {
        buttonTextString = "Scan";
      } else {
        buttonTextString = "Accept";
      }
    } else {
      if (isConfirmed) {
        buttonTextString = "See your pass";
      } else {
        buttonTextString = "Accept";
      }
    }

    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          if (isConfirmed && isHost == false) {
            ref.read(seePassProvider.notifier).seePass(event.id);
          } else if (isConfirmed == false) {
            ref.read(acceptInvitationProvider.notifier).acceptInvitation(event.id);
          } else if (isConfirmed && isHost) {
            context.push('/scan-pass', extra: InviteGuestsScreenParams(
                eventId: event.id,
              )
            );
          }
        }
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 6,
            ),
          ],
        ),

        child: Center(
          child: isLoading
          ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            )
          )
          : Text(
            buttonTextString,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )
          ),
        )
      ),
    );
  }

  String dynamicHTML(String cypherText) {
    final html = '''
    <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <title>QR Code Styling</title>
          <script type="text/javascript" src="https://unpkg.com/qr-code-styling@1.5.0/lib/qr-code-styling.js"></script>
      </head>
      <body>
      <script type="text/javascript">

        const qrCode = new QRCodeStyling({
          width: 1000,
          height: 1000,
          type: "svg",
          data: "$cypherText",
          dotsOptions: {
            color: "#000000",
            type: "rounded"
          },
          cornersSquareOptions: {
            type: "extra-rounded"
          },
          qrOptions: {
            errorCorrectionLevel: 'M'
          },
          imageOptions: {
            crossOrigin: "anonymous",
            margin: 0
          }
        });

        qrCode.getRawData().then((val) => {
          var reader = new FileReader();
          reader.readAsDataURL(val); 
          reader.onloadend = () => {
            var base64data = reader.result;                
            window.Print.postMessage(base64data)
          }
        });

      </script>
      </body>
      </html>
    ''';

    return html;
  }
  
  @override
  bool get wantKeepAlive => true;
}