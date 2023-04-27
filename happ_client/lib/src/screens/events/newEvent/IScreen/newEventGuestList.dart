import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/searchUserInviteTile.dart';
import 'package:happ_client/src/utils/user/currentUser.dart';
import 'package:happ_client/src/utils/user/userTypesConverter.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

class NewEventGuestList extends ConsumerStatefulWidget {
  final List<SearchUsers$Query$User> users;
  final List<SearchUsers$Query$User> organizers;
  final int eventId;
  const NewEventGuestList({
    required this.users,
    required this.organizers,
    required this.eventId,
    super.key
  });

  @override
  _NewEventGuestListState createState() => _NewEventGuestListState();
}

class _NewEventGuestListState extends ConsumerState<NewEventGuestList> {

  late List<SearchUsers$Query$User> users;
  late List<SearchUsers$Query$User> organizers;

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
    ref.listen(inviteUserSelectProvider, (prev, next) {
      switch (next.runtimeType) {
        case InviteUserRemoveState:
          setState(() {
            users.removeWhere((item) => item.id == (next as InviteUserRemoveState).userId);
          });
          break;
        case MakeOrganizerState:
          setState(() {
            organizers.add((next as MakeOrganizerState).user);
            users.removeWhere((item) => item.id == next.user.id);
          });
          break;
        case RemoveOrganizerState:
          setState(() {
            users.insert(0, (next as RemoveOrganizerState).user);
            organizers.removeWhere((user) => user.id == next.user.id);
          });
          break;
      }
    });

    final statusBar = MediaQuery.of(context).padding.top;

    return Material(
      color: Colors.white,
      child: Container(
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
                        fontSize: 20,
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
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  // const SizedBox(height: 8),
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
                        fontSize: 18,
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
                        if (i == 0) {
                          SearchUsers$Query$User currentUser = UserTypesConverter().convertToSearchUser(ref.read(currentUserProvider));
                          return SearchUserInviteTile(
                            user: currentUser,
                            isSelected: true,
                            fromGuestList: true,
                            key: Key("searchUserInviteTile_fromNewEventInvitedFriendsList_${currentUser.id}")
                          );
                        }

                        int organizersIndex = i - 1;

                        return SearchUserInviteTile(
                          user: organizers[organizersIndex],
                          isSelected: true,
                          fromGuestList: true,
                          isOrganizer: true,
                          key: Key("searchUserInviteTile_fromNewEventInvitedFriendsList_${organizers[organizersIndex].id}")
                        );
                      },
                      childCount: organizers.length + 1,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
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
                        fontSize: 18,
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
                        return SearchUserInviteTile(
                          user: users[i],
                          isSelected: true,
                          fromGuestList: true,
                          key: Key("searchUserInviteTile_fromNewEventInvitedFriendsList_${users[i].id}")
                        );
                      },
                      childCount: users.length,
                    ),
                  ),
                  // ...widget.users.map((user) {
                  //   return SearchUserInviteTile(
                  //     user: user,
                  //     isSelected: true,
                  //     fromGuestList: true,
                  //     key: Key("searchUserInviteTile_fromNewEventInvitedFriendsList_${user.id}")
                  //   );
                  // }).toList()
                ],
              )
              // ListView.builder(
              //   padding: const EdgeInsets.only(top: 8),
              //   itemCount: widget.users.length,
              //   itemBuilder: (context, i) =>
              //     SearchUserInviteTile(
              //       user: widget.users[i],
              //       isSelected: true,
              //       fromGuestList: true,
              //       key: Key("searchUserInviteTile_fromNewEventInvitedFriendsList_${widget.users[i]}")
              //     )
              // ),
            )
            // Text( 
            //   "Guest List",
            //   style: TextStyle(
            //     color: Colors.grey[800],
            //     fontSize: 20,
            //     // letterSpacing: 0.5,
            //     // fontStyle: FontStyle.normal,
            //     fontWeight: FontWeight.w700,
            //     // height: 1
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   // child: const SearchLocationBar()
            // ),
            // const Expanded(
            //   child: SearchLocationResults()
            // )
          ],
        ),
      ),
    );
  }
}