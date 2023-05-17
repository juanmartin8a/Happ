import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEvent.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEventState.dart';
import 'package:happ_client/src/riverpod/userEvents/userEvents.dart';
import 'package:happ_client/src/riverpod/userEvents/userEventsState.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/utils/event/eventTypesConverter.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:intl/intl.dart';

final userEventsProvider =
  StateNotifierProvider<UserEvents, UserEventState>(
    (ref) => UserEvents()
  );

class OtherInvitations extends ConsumerStatefulWidget {
  // final Function friendsOtherFunc;
  final Function? friendsOtherDoneFunc;
  final bool? ready;
  const OtherInvitations({
    // required this.friendsOtherFunc,
    this.friendsOtherDoneFunc,
    this.ready,
    super.key
  });

  @override
  _OtherInvitationsState createState() => _OtherInvitationsState();
}

class _OtherInvitationsState extends ConsumerState<OtherInvitations> {

  ScrollController scrollController = ScrollController();

  List<GetUserOtherEvents$Query$PaginatedEventResults$EventInviteRes> eventInvites = [];
  List<int> eventIds = [];

  bool isLoading = true;
  bool hasMore = true;
  bool firstCall = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userEventsProvider.notifier).getUserOtherEvents(8, []);
    });
    scrollController.addListener(() {
      if (hasMore) {
        final maxScrollExtent = scrollController.position.maxScrollExtent;
        final currentPos = scrollController.position.pixels;
        final screenWidth = MediaQuery.of(context).size.width;

        if (currentPos >= (maxScrollExtent - screenWidth * 1.5)) {
          if (isLoading == false) {
            setState(() {
              isLoading = true;
            });
            ref.read(userEventsProvider.notifier).getUserOtherEvents(8, eventIds);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userEventsProvider, (prev, next) {
      switch (next.runtimeType) {
        case UserOtherEventsLoadedState:
          final state = next as UserOtherEventsLoadedState;

          setState(() {
            eventInvites = [...eventInvites, ...state.res.events];
            eventIds = eventInvites.map((invite) => invite.event.id).toList();
            hasMore = next.res.hasMore;
            isLoading = false;
          });


          if (firstCall == true) {
            if (eventInvites.isNotEmpty) {
              widget.friendsOtherDoneFunc!(false, true);
            } else {
              widget.friendsOtherDoneFunc!(false, false);
            }
          }

          firstCall = false;

          break ;

        case UserOtherEventsRefreshedState:
          final state = next as UserOtherEventsRefreshedState;

          setState(() {
            eventInvites = [...state.res.events];
            eventIds = eventInvites.map((invite) => invite.event.id).toList();
            hasMore = next.res.hasMore;
            isLoading = false;
          });

          break;

        case UpdateOtherEvents:
          final state = next as UpdateOtherEvents;
          if (state.actionPerformed == "updateUserInfo") {
            final index = eventInvites.indexWhere((invite) => invite.event.id == state.inviteRes!.event.id);

            if (index >= 0) {
              // eventInvites[index] = state.inviteRes!;
              setState(() {
                eventInvites.removeAt(index);
                eventIds = eventInvites.map((invite) => invite.event.id).toList();
              });
            }
          }

          break ;
      }
    });

    ref.listen(leaveEventProvider, (prev, next) {
      if (next is LeaveEventDoneState) {
        if (eventIds.contains(next.eventId)) {
          setState(() {
            eventInvites.removeWhere((invite) => invite.event.id == next.eventId);
            eventIds = eventInvites.map((invite) => invite.event.id).toList();
          });
        }
      }
    });

    // need friendsDone and otherDone variables
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Other invitations",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
              height: 1
            )
          ),
        ),
        const SizedBox(height: 4),
        eventInvites.isEmpty
        ? isLoading
        ? Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: const Loader(radius: 8)
            ),
          ),
        )
        : Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: 
              RichText(
                textAlign: TextAlign.center,
                
                text: TextSpan(
                  text: "No invites?",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: ' 🤔 ', style: TextStyle(fontSize: 18)),
                    TextSpan(text: 'Be the host!'),
                    TextSpan(text: '🎊😄', style: TextStyle(fontSize: 18))
                  ]
                )
              )
            ),
          ),
        )
        : SizedBox(
          height: 252,
          // color: Colors.red,
          child: ListView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),

            children: [
              ...eventInvites.map((invite) {
                return GestureDetector(
                  onTap: () {
                    final inviteRes = EventTypesConverter().convertOtherInviteResToFriendsInviteRes(invite);
                    context.push('/event', extra: EventParams(
                        inviteRes: inviteRes,
                      )
                    );
                  },
                  child: Container(
                    margin: invite == eventInvites[0] ? null : const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            if (invite.invitedUserInfo.isHost)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurpleAccent
                              ),
                            ),
                            if (invite.invitedUserInfo.isHost)
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                Characters("Invited by ${invite.invitedBy.name}")
                                .replaceAll(Characters(' '), Characters('\u{000A0}'))
                                .toString(),
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                  height: 1
                                ),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // new
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height:2),
                        AspectRatio(
                          aspectRatio: 4/3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              invite.event.lightEventPics[0],
                              fit: BoxFit.cover
                            ),
                          )
                        ),
                        const SizedBox(height: 8),
                        Text(
                          Characters(invite.event.name)
                          .replaceAll(Characters(' '), Characters('\u{000A0}'))
                          .toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                            height: 1
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // new
                        ),
                        const SizedBox(height: 3),
                        Builder(
                          builder: (context) {
                            String date = "";

                            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(invite.event.eventDate));
                            DateTime dateTimeNow = DateTime.now();

                            if (dateTimeNow.year == dateTime.year) {
                              date ="${DateFormat.MMMM().format(dateTime)} ${dateTime.day}";
                            } else {
                              date ="${DateFormat.MMMM().format(dateTime)} ${dateTime.day}, ${dateTime.year}";
                            }

                            return Text(
                              date,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                                height: 1
                              )
                            );
                          }
                        ),
                        if (invite.friends.isNotEmpty)
                        const SizedBox(height: 8 - 2.5),
                        if (invite.friends.isNotEmpty)
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 55,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      padding: const EdgeInsets.all(2.5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Container(
                                          color: Colors.grey[200],
                                          child: Image.network(invite.friends[0].profilePic)
                                        )
                                      )
                                    ),
                                    if (invite.friends.length > 1)
                                    Positioned(
                                      left: 15,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        padding: const EdgeInsets.all(2.5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Container(
                                            color: Colors.grey[200],
                                            child: Image.network(invite.friends[1].profilePic)
                                          )
                                        )
                                      ),
                                    ),
                                    if (invite.friends.length > 2)
                                    Positioned(
                                      left: 30,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        padding: const EdgeInsets.all(2.5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Container(
                                            color: Colors.grey[200],
                                            child: Image.network(invite.friends[2].profilePic)
                                          )
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (invite.event.confirmedCount > 3)
                              const SizedBox(width: 4),
                              if (invite.event.confirmedCount > 3)
                              Text(
                               "+ ${invite.event.confirmedCount - 3} More",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                  height: 1
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }).toList(),
              if (isLoading)
              Container(
                width: 80,
                height: 252,
                padding: const EdgeInsets.only(top: 21, left: 4, right: 4,),

                child: const Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 192 * 0.75,
                    child: Align(
                      child: Loader(radius: 8)
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}