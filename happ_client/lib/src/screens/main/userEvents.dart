import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEvent.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEventState.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEvent.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEventState.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEvent.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEventState.dart';
import 'package:happ_client/src/riverpod/userEvents/userEvents.dart';
import 'package:happ_client/src/riverpod/userEvents/userEventsState.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/screens/main/widgets/otherInvitations.dart' as OI;
import 'package:happ_client/src/screens/main/widgets/invitationsFromFriends.dart' as FI;
import 'package:happ_client/src/utils/event/eventTypesConverter.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final userEventsProvider =
  StateNotifierProvider<UserEvents, UserEventState>(
    (ref) => UserEvents()
  );

class MainEvents extends ConsumerStatefulWidget {
  const MainEvents({super.key});

  @override
  _MainEventsState createState() => _MainEventsState();
}

class _MainEventsState extends ConsumerState<MainEvents> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late AnimationController _scaleController;

  ScrollController scrollController = ScrollController();

  List<GetUserEvents$Query$PaginatedEventResults$EventInviteRes> eventInvites = [];
  List<int> eventIds = [];

  bool isLoading = true;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(value: 0.0, vsync: this, upperBound: 1.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userEventsProvider.notifier).getUserEvents(10, []);
    });
    scrollController.addListener(() {
      if (hasMore) {
        final maxScrollExtent = scrollController.position.maxScrollExtent;
        final currentPos = scrollController.position.pixels;
        final screenHeight = MediaQuery.of(context).size.height - (45 + MediaQuery.of(context).padding.top);

        if (currentPos >= (maxScrollExtent - screenHeight * 2)) {
          if (isLoading == false) {
            setState(() {
              isLoading = true;
            });
            ref.read(userEventsProvider.notifier).getUserEvents(10, eventIds);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scaleController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(userEventsProvider, (prev, next) {
      switch (next.runtimeType) {
        case UserEventsLoadedState:
          final state = next as UserEventsLoadedState;
          setState(() {
            if (state.isRefresh) {
              eventInvites = [...state.res.events];
            } else {
              eventInvites = [...eventInvites, ...state.res.events];
            }
            eventIds = eventInvites.map((invite) => invite.event.id).toList();
            hasMore = next.res.hasMore;
            isLoading = false;
          });
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
    ref.listen(deleteEventProvider, (prev, next) {
      if (next is DeleteEventDoneState) {
        if (eventIds.contains(next.eventId)) {
          setState(() {
            eventInvites.removeWhere((invite) => invite.event.id == next.eventId);
            eventIds = eventInvites.map((invite) => invite.event.id).toList();
          });
        }
      }
    });
    ref.listen(updateEventProvider, (prev, next) {
      if (next is UpdateEventDoneState) {
        if (next.updateEventRes.errors == null) {
          if (eventInvites.map((invite) => invite.event.id).toList().contains(next.updateEventRes.event!.id)) {
            final newEventJson = next.updateEventRes.event!.toJson();
            GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event event = GetUserEvents$Query$PaginatedEventResults$EventInviteRes$Event.fromJson(newEventJson);
            final index = eventInvites.indexWhere((invite) => invite.event.id == event.id);
            setState(() {
              eventInvites[index].event = event;
              eventIds = eventInvites.map((invite) => invite.event.id).toList();
            });
          }
        }
      }
    });
    ref.listen(OI.userEventsProvider, (prev, next) {
      if (next is UpdateOtherEvents) {
        if (next.actionPerformed == "updateUserInfo") {
          Map<String, dynamic> inviteResJson = next.inviteRes!.toJson();
          GetUserEvents$Query$PaginatedEventResults$EventInviteRes newInviteRes = GetUserEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResJson);
          insertIntoList(newInviteRes);
        }
      }
    });
    ref.listen(FI.userEventsProvider, (prev, next) {
      if (next is UpdateFriendsEvents) {
        if (next.actionPerformed == "updateUserInfo") {
          Map<String, dynamic> inviteResJson = next.inviteRes!.toJson();
          GetUserEvents$Query$PaginatedEventResults$EventInviteRes newInviteRes = GetUserEvents$Query$PaginatedEventResults$EventInviteRes.fromJson(inviteResJson);
          insertIntoList(newInviteRes);
        }
      }
    });

    if (eventInvites.isEmpty && isLoading) {
      return Container(
        padding: const EdgeInsets.only(
          top: 150,
          left: 12,
          right: 12,
        ),
        // height: 300,
        child: const Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            // color: Colors.red,
            height: 20,
            child: Loader(radius: 8)
          ),
        )
      );
    }

    return SmartRefresher(
      enablePullDown: true,
      header: CustomHeader(
        refreshStyle: RefreshStyle.Follow,
        onOffsetChange: (offset) {
          if (_refreshController.headerMode!.value != RefreshStatus.refreshing) {
            double adjustedOffset = offset - 12;
            _scaleController.value = (adjustedOffset > 0 ? adjustedOffset : 0) / 48.0;
          }
        },
        height: 60,
        builder: (child, status) {
          if (status == RefreshStatus.failed) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(top: 12),
              child: FadeTransition(
                opacity: _scaleController,
                child: ScaleTransition(
                  scale: _scaleController,
                  child: const Text(
                    "❌",
                    style: TextStyle(fontSize: 22, height: 1)
                  )
                ),
              )
            );
          }
          if (status == RefreshStatus.completed) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(top: 12),
              child: FadeTransition(
                opacity: _scaleController,
                child: ScaleTransition(
                  scale: _scaleController,
                  child: const Text(
                    "😉",
                    style: TextStyle(fontSize: 22, height: 1)
                  )
                ),
              )
            );
          }
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FadeTransition(
              opacity: _scaleController,
              child: ScaleTransition(
                scale: _scaleController,
                child: const Loader(radius: 8),
              ),
            ),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        final success = await ref.read(userEventsProvider.notifier).getUserEvents(10, [], isRefresh: true);
    
        if (success) {
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshFailed();
        }
      },
      physics: const AlwaysScrollableScrollPhysics(),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        controller: scrollController,
        children: [
          if (eventInvites.isEmpty)
          Container(
            padding: const EdgeInsets.only(
              top: 150,
              left: 12,
              right: 12,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Event-less?",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
                children: const <TextSpan>[
                  TextSpan(text: ' 😮\n', style: TextStyle(fontSize: 18)),
                  TextSpan(text: 'Stay tuned for invitations! '),
                  TextSpan(text: '📨🎉', style: TextStyle(fontSize: 18))
                ]
              )
            )
          ),

          if (eventInvites.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              "Soonest first :)",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1
              ),
            ),
          ),
          if (eventInvites.isNotEmpty)
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
                color: Colors.transparent,
                padding: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
                
                // width: 200,
                // decoration: BoxDecoration(
                //   color: Colors.blue,
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 4/3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          invite.event.eventPics[0],
                          fit: BoxFit.cover
                        ),
                      )
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          invite.event.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                            height: 1
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // new
                        ),
                        if (invite.invitedUserInfo.isHost)
                        const SizedBox(width: 6),
                        if (invite.invitedUserInfo.isHost)
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurpleAccent
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
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
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                            height: 1
                          )
                        );
                      }
                    ),
                    if (invite.friends.isNotEmpty)
                    const SizedBox(height: 12 - 3.5),
                    if (invite.friends.isNotEmpty)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 77,
                            child: Stack(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  padding: const EdgeInsets.all(3.5),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Container(
                                      color: Colors.grey[200],
                                      child: Image.network(invite.friends[0].profilePic)
                                    )
                                  )
                                ),
                                if (invite.friends.length > 1)
                                Positioned(
                                  left: 21,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    padding: const EdgeInsets.all(3.5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Container(
                                        color: Colors.grey[200],
                                        child: Image.network(invite.friends[1].profilePic)
                                      )
                                    )
                                  ),
                                ),
                                if (invite.friends.length > 2)
                                Positioned(
                                  left: 42,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    padding: const EdgeInsets.all(3.5),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
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
                              fontSize: 15,
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
          if (isLoading && eventInvites.isNotEmpty)
          const SizedBox(
            height: 20,
            child: Loader(radius: 8)
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }

  void insertIntoList(GetUserEvents$Query$PaginatedEventResults$EventInviteRes inviteRes) {
    if (eventInvites.isNotEmpty) {
      for (int i = 0; i < eventInvites.length; i++) {
        // Place the new item where the i item's date is less than new
        final newItemDate = int.parse(inviteRes.event.eventDate);
        final currentItemDate = int.parse(eventInvites[i].event.eventDate);
        if (newItemDate <= currentItemDate) {
          setState(() {
            eventInvites.insert(i, inviteRes);
            eventIds = eventInvites.map((invite) => invite.event.id).toList();
          });
          break;
        }
      }
    } else {
      setState(() {
        eventInvites.add(inviteRes);
        eventIds = eventInvites.map((invite) => invite.event.id).toList();
      });
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}