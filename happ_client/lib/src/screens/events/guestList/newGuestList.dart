import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/searchUserInviteTile.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/searchFUTAAGInviteTile.dart';
import 'package:happ_client/src/utils/user/userTypesConverter.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

class NewGuestList extends ConsumerStatefulWidget {
  final List<SearchForUsersToAddToEvent$Query$User> users;
  final List<SearchForUsersToAddToEvent$Query$User> organizers;
  final int eventId;
  final bool isCreator;
  const NewGuestList({
    required this.users,
    required this.organizers,
    required this.eventId,
    this.isCreator = true,
    super.key
  });

  @override
  _NewGuestListState createState() => _NewGuestListState();
}

class _NewGuestListState extends ConsumerState<NewGuestList> {

  late List<SearchForUsersToAddToEvent$Query$User> users;
  late List<SearchForUsersToAddToEvent$Query$User> organizers;

  @override
  void initState() {
    super.initState();
    users = widget.users;
    organizers = widget.organizers;
  }

  @override
  Widget build(BuildContext context) {
    users = users.toSet().toList();
    organizers = organizers.toSet().toList();
    // ref.listen(inviteUserSelectProvider, (prev, next) {
    //   switch (next.runtimeType) {
    //     case InviteUserRemoveState:
    //       setState(() {
    //         users.removeWhere((item) => item.id == (next as InviteUserRemoveState).userId);
    //       });
    //       break;
    //     case MakeOrganizerState:
    //       setState(() {
    //         organizers.add((next as MakeOrganizerState).user);
    //         users.removeWhere((item) => item.id == next.user.id);
    //       });
    //       break;
    //     case RemoveOrganizerState:
    //       setState(() {
    //         users.insert(0, (next as RemoveOrganizerState).user);
    //         organizers.removeWhere((user) => user.id == next.user.id);
    //       });
    //       break;
    //   }
    // });

    final statusBar = MediaQuery.of(context).padding.top;

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: statusBar),
          SizedBox(
            height: 45,
            child: Stack(
              children: [
                Center(
                  // heightFactor: 100,
                  // width
                  child: Text(
                    "Guest List",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 19,
                      // letterSpacing: 0.5,
                      // fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      // height: 1
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  height: 45,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FloatingActions(
                      icon: CupertinoIcons.chevron_back,
                      padding: const EdgeInsets.only(left: 8),
                      color: Colors.grey[800]!,
                      size: 36,
                      key: Key("goBack_newEvetnInvitedFriends${widget.eventId}")
                    ),
                  )
                ),
              ],
            )
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                if (widget.isCreator)
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                if (widget.isCreator)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 4,
                    ),
                    child: Text(
                      "Hosts",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                        height: 1
                      )
                    ),
                  ),
                ),
                if (widget.isCreator)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                      return SearchFUTAAGInviteTile(
                        user: organizers[i],
                        isSelected: true,
                        fromGuestList: true,
                        isOrganizer: true,
                        key: Key("searchUserInviteTile_fromNewGuestList_${organizers[i].id}")
                      );
                    },
                    childCount: organizers.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                if (widget.isCreator)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 4,
                    ),
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
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                      return SearchFUTAAGInviteTile(
                        user: users[i],
                        isSelected: true,
                        fromGuestList: true,
                        isOrganizer: false,
                        key: Key("searchUserInviteTile_fromNewGuestList_${users[i].id}")
                      );
                    },
                    childCount: users.length,
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}