import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/acceptInvitation/acceptInvitation.dart';
import 'package:happ_client/src/riverpod/acceptInvitation/acceptInvitationState.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEvent.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEventState.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuests.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuestsState.dart';
import 'package:happ_client/src/riverpod/eventHosts/eventHosts.dart';
import 'package:happ_client/src/riverpod/eventHosts/eventHostsState.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEvent.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEventState.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEvent.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEventState.dart';
import 'package:happ_client/src/screens/events/widgets/acceptButton.dart';
import 'package:happ_client/src/screens/events/widgets/eventMap.dart';
import 'package:happ_client/src/screens/events/widgets/updateOrDeleteEventDialog.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:intl/intl.dart';

import 'class/eventAndInviteParams.dart';

class Event extends ConsumerStatefulWidget {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes inviteRes;
  // final GetUserEventsFromFriends$Query$EventInviteRes$Event event;
  // final GetUserEventsFromFriends$Query$EventInviteRes$User invitedBy;
  // final GetUserEventsFromFriends$Query$EventInviteRes$InvitedUserInfo userInfo;
  const Event({
    required this.inviteRes,
    // required this.event,
    // required this.invitedBy,
    // required this.userInfo,
    Key? key
  }) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends ConsumerState<Event> {
  // final PageController pageController = PageController(length: );

  int currentPage = 0;

  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event;
  late GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo userInfo;

  late GetEventGuests$Query$PaginatedEventUsersResults paginatedGuestsRes;
  late GetEventHosts$Query$PaginatedEventUsersResults paginatedHostsRes;

  List<GetEventGuests$Query$PaginatedEventUsersResults$User> guests = [];
  List<GetEventHosts$Query$PaginatedEventUsersResults$User> hosts = [];

  bool isGuestsLoading = true;
  bool isHostsLoading = true;

  // String pressedItems = [
  //   "Update",
  //   "Remove"
  // ]

  @override
  void initState() {
    super.initState();
    event = widget.inviteRes.event;
    userInfo = widget.inviteRes.invitedUserInfo;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
      ref.read(eventHostsProvider.notifier).getEventHosts(event.id, 25, []);
      ref.read(eventGuestsProvider.notifier).getEventGuests(event.id, 25, []);
    });
  }

  @override
  Widget build(BuildContext context) {

    if (userInfo.isCreator) {
      ref.listen(deleteEventProvider, (prev, next) {
        if (next is DeleteEventDoneState) {
          context.pop();
        }
      });
      ref.listen(updateEventProvider, (prev, next) {
        if (next is UpdateEventDoneState) {
          if (next.updateEventRes.errors == null) {
            if (next.updateEventRes.event!.id == event.id) {
              final newEventJson = next.updateEventRes.event!.toJson();
              final newEvent = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(newEventJson);

              setState(() {
                event = newEvent;
              });
            }
          }
        }
      });
    } else {
      ref.listen(leaveEventProvider, (prev, next) {
        if (next is LeaveEventDoneState) {
          context.pop();
        }
      });
    }

    if (!userInfo.isConfirmed) {
      ref.listen(acceptInvitationProvider, (previous, next) {
        if (next is AcceptInvitationDoneState) {

          final userInfoJson = userInfo.toJson();
          
          userInfoJson["isConfirmed"] = true;

          final newUserInfo = GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$InvitedUserInfo.fromJson(userInfoJson);

          setState(() {
            userInfo = newUserInfo;
          });

        }
      });
    }


    ref.listen(eventGuestsProvider, (prev, next) {
      if (next is GetEventGuestsDoneState) {
        if (guests.isEmpty) {
          setState(() {
            paginatedGuestsRes = next.res;
            guests = next.res.users;
            isGuestsLoading = false;
          });
        }
      } else if (next is GetEventGuestsRemoveState) {
        if (guests.isNotEmpty) {
          setState(() {
            paginatedGuestsRes.users.removeWhere((user) => next.userIds.contains(user.id));
            guests.removeWhere((user) => next.userIds.contains(user.id));
          });
        }
      }
    });

    ref.listen(eventHostsProvider, (prev, next) {
      if (next is GetEventHostsDoneState) {
        if (hosts.isEmpty) {
          setState(() {
            paginatedHostsRes = next.res;
            hosts = next.res.users;
            isHostsLoading = false;
          });
        }
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top
                ),
                Container(
                  height: 45,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FloatingActions(
                          icon: EvaIcons.arrowBackOutline,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          // padding:  EdgeInsets.zero,
                          color: Colors.grey[800]!,
                          size: 36,
                          key: Key("goBack_${event.id}")
                        )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Characters(event.name)
                              .replaceAll(Characters(' '), Characters('\u{000A0}'))
                              .toString(),
                            style: TextStyle(
                              fontSize: event.name.length <= 22 ? 19 : 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                              height: 1
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Builder(
                            builder: (context) {
                              String date = "";
    
                              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(event.eventDate));
                              DateTime dateTimeNow = DateTime.now();
    
                              if (dateTimeNow.year == dateTime.year) {
                                date ="${DateFormat.EEEE().format(dateTime)}, ${DateFormat.MMMM().format(dateTime)} ${dateTime.day}";
                              } else {
                                date ="${DateFormat.EEEE().format(dateTime)}, ${DateFormat.MMMM().format(dateTime)}  ${dateTime.day}, ${dateTime.year}";
                              }
    
                              return Text(
                                date,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                  height: 1
                                )
                              );
                            }
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          final newInviteRes = widget.inviteRes;
                          newInviteRes.event = event;
                          newInviteRes.invitedUserInfo = userInfo;
  
                          showGeneralDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            transitionDuration: const Duration(milliseconds: 200),
                            pageBuilder: (context, anim1, anim2) {
                              return UpdateOrDeleteEventDialog(inviteRes: newInviteRes);
                            }
                          );
                        },
                        child: FloatingActions(
                          icon: FluentIcons.more_vertical_16_regular,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          // padding:  EdgeInsets.zero,
                          color: Colors.grey[800]!,
                          size: 26,
                          key: Key("goBack_${event.id}")
                        ),
                      )
                    ],
                  )
                ),
                Expanded(
                  // padding: EdgeInsets.symmetric(horizontal:8),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        SizedBox(
                          height: (MediaQuery.of(context).size.width - 24) * 0.75,
                          child: PageView.builder(
                            itemCount: event.eventPics.length,
                            onPageChanged: (value) {
                              setState(() {
                                currentPage = value;
                              });
                            },
                            itemBuilder: (context, i) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                // height: MediaQuery.of(context).size.width,
                                child: AspectRatio(
                                  aspectRatio: 4/3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Image.network(
                                        event.eventPics[i],
                                        fit: BoxFit.cover
                                      ),//Image.asset('assets/images/image2.jpeg', fit: BoxFit.cover)
                                    ),
                                  )
                                )
                              );
                            }
                          ),
                        ),
                        if (event.eventPics.length > 1)
                        const SizedBox(height: 4),
                        if (event.eventPics.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...event.eventPics.asMap().entries.map((entry) {
                              Color color = Colors.grey[300]!;
                              double marginRight = 4;
    
                              if (entry.key == currentPage) {
                                color = Colors.blue;
                              }
    
                              if (entry.key == event.eventPics.length - 1) {
                                marginRight = 0;
                              }
    
                              return Container(
                                height: 7,
                                width: 7,
                                margin: EdgeInsets.only(right: marginRight),
                                decoration:  BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle
                                )
                              );
                            }).toList(),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            event.description,
                            //"Birthday party at My place all of my friends and family are invited, it will be really cool",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                              // height: 1.1
                            )
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                              height: 1
                            )
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal:12),
                          // height: MediaQuery.of(context).size.width,
                          child: EventMapWidget(
                            latitude: event.coords.latitude,
                            longitude: event.coords.longitude,
                            eventPlace: event.eventPlace,
                          )
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            "Hosts",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[850],
                              height: 1
                            )
                          ),
                        ),
                        const SizedBox(height: 8),
    
                        if (isHostsLoading) 
                        const SizedBox(
                          height: 25,
                          child: Loader(radius: 8)
                        ),
    
                        if (!isHostsLoading)
                        ...hosts.map((host) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.network(host.profilePic),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  host.name,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[850],
                                    height: 1
                                  )
                                )
                              ],
                            )
                          );
                        }).toList(),
    
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            "Guests",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                              height: 1
                            )
                          ),
                        ),
                        const SizedBox(height: 8),
    
                        if (isGuestsLoading)
                        const SizedBox(
                          height: 25,
                          child: Loader(radius: 8)
                        ),
    
                        if (!isGuestsLoading && guests.isNotEmpty)
                        ...guests.map((guest) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.network(guest.profilePic),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  guest.name,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                    height: 1
                                  )
                                )
                              ],
                            )
                          );
                        }).toList(),
    
                        if (!isGuestsLoading && guests.isEmpty)
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                // text: r"No guests yet ¯\_(ツ)_/¯",
                                text: "Guest RSVPs are on their way!  ",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Colors.grey[800],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                                children: const <TextSpan>[
                                  TextSpan(text: '📬', style: TextStyle(fontSize: 18))
                                ]
                              )
                            ),
                          )
                        ),
                        const SizedBox(height: 71 - 17.5),
                        if (!isHostsLoading && !isGuestsLoading)
                        GestureDetector(
                          onTap: () {
                            if (!isGuestsLoading && !isHostsLoading) {
                              EventGuestListParams params = EventGuestListParams(
                                eventId: event.id,
                                isHost: userInfo.isHost && userInfo.isConfirmed,
                                isCreator: userInfo.isCreator,
                                paginatedHostsRes: paginatedHostsRes,
                                paginatedGuestsRes: paginatedGuestsRes,
                              );
                              context.push(
                                '/event-guest-list',
                                extra: params
                              );
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 36,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2, 
                                  color: Colors.black
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Full Guest List",
                                  style: TextStyle(
                                    // color: Colors.grey[800]!,
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1
                                  )
                                ),
                              ),
                            )
                          ),
                        ),
    
                        const SizedBox(height: 150)
                      ],
                    ),
                  )
                )
              ],
            ),
            Positioned(
              bottom: 34,
              left: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.5)) / 2,
              child: AcceptButton(inviteRes: widget.inviteRes)
            )
          ],
        )
      ),
    );
  }
}