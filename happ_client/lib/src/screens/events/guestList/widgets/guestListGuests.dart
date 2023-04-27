import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuests.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuestsState.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListAction.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListActionState.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/screens/events/guestList/widgets/guestListGuestUserTile.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';

class GuestListGuests extends ConsumerStatefulWidget {
  final int eventId;
  final GetEventGuests$Query$PaginatedEventUsersResults paginatedGuestsRes;
  const GuestListGuests({
    required this.eventId,
    required this.paginatedGuestsRes,
    super.key
  });

  @override
  _GuestListGuestsState createState() => _GuestListGuestsState();
}

class _GuestListGuestsState extends ConsumerState<GuestListGuests> with AutomaticKeepAliveClientMixin {

  ScrollController scrollController = ScrollController();

  List<GetEventGuests$Query$PaginatedEventUsersResults$User> guests = [];
  List<int> userIds = [];

  bool isLoading = false;
  bool hasMore = true; 

  bool selectMode = false;

  @override
  void initState() {
    super.initState();
    guests = widget.paginatedGuestsRes.users;
    userIds = guests.map((user) => user.id).toList();
    hasMore = widget.paginatedGuestsRes.hasMore;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (hasMore) {
        setState(() {
          isLoading = true;
        });
        ref.read(eventGuestsProvider.notifier).getEventGuests(widget.eventId, 25, userIds);
      }
    });
    scrollController.addListener(() {
      if (hasMore) {
        final maxScrollExtent = scrollController.position.maxScrollExtent;
        final currentPos = scrollController.position.pixels;
        final screenHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + 34 + 45);

        if (currentPos >= (maxScrollExtent - screenHeight * 1.5)) {
          if (isLoading == false) {
            setState(() {
              isLoading = true;
            });
            ref.read(eventGuestsProvider.notifier).getEventGuests(widget.eventId, 25, userIds);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(eventGuestsProvider, (prev, next) {
      if (next is GetEventGuestsDoneState) {
        setState(() {
          guests = [...guests, ...next.res.users];
          userIds = guests.map((user) => user.id).toList();
          hasMore = next.res.hasMore;
          isLoading = false;
        });
      } else if (next is GetEventGuestsRemoveState) {
        if (guests.isNotEmpty) {
          setState(() {
            guests.removeWhere((user) => next.userIds.contains(user.id));
            userIds = guests.map((user) => user.id).toList();
          });
        }
      }
    });
    ref.listen(guestListActionProvider, (prev, next) {
      if (next is GuestListActionRemoveState) {
        setState(() {
          selectMode = true;
        });
      } else {
        setState(() {
          selectMode = false;
        });
        if (next is GuestListActionAddState) {
          // final inviteRes = EventTypesConverter().convertOtherInviteResToFriendsInviteRes(widget.inviteRes);
          context.push('/invite-guests', extra: InviteGuestsScreenParams(
              // event: event, invitedBy: invitedBy, userInfo: userInfo
              eventId: widget.eventId,
            )
          );
        }
      }
    });
    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: 10,
        ),

        if (guests.isNotEmpty)
        ...guests.map((guest) {
          return GuestListGuestUserTile(guest: guest, selectMode: selectMode);
        }).toList(),

        if (guests.isEmpty)
        Container(
          padding: const EdgeInsets.only(top: 150),
          color: Colors.transparent,
          child: Center(
            child: 
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                // text: r"No guests yet ¯\_(ツ)_/¯",
                text: "They'll be RSVP'ing soon!\n",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 15,
                  fontWeight: FontWeight.w600
                ),
                children: const <TextSpan>[
                  TextSpan(text: '😅', style: TextStyle(fontSize: 20))
                ]
              )
            ),
          )
        ),

        if (isLoading)
        const SizedBox(
          height: 30,
          child: Loader(radius: 8)
        ),
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}