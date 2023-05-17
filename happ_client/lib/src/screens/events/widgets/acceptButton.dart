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
        setState(() {
          isDone = true;
          isLoading = false;
          isConfirmed = true;
        });

        if (!next.acceptInviteRes.isHost) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.push(
              '/event-invitation',
              extra: InviteParams(
                event: event,
                cypherText: next.acceptInviteRes.cypherText,
              )
            );
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
        setState(() {
          isDone = true;
          isLoading = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.push(
            '/event-invitation',
            extra: InviteParams(
              event: event,
              cypherText: next.cypherText,
            )
          );
        });
        
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
        buttonTextString = "See pass";
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
  
  @override
  bool get wantKeepAlive => true;
}