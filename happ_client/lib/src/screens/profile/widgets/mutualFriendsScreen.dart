import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriends.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriendsState.dart';
import 'package:happ_client/src/screens/profile/widgets/userTile.dart';
import 'package:happ_client/src/screens/search/widgets/saerchUserAddButton.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';

class MutualFriendsScreen extends ConsumerStatefulWidget {
  final int userId;
  final List<MutualFriends$Query$PaginatedEventUsersResults$User> users;
  final bool hasMore;
  final String uuid;
  const MutualFriendsScreen({
    required this.userId,
    required this.users,
    required this.hasMore,
    required this.uuid,
    super.key
  });

  @override
  _MutualFriendsScreenState createState() => _MutualFriendsScreenState();
}

class _MutualFriendsScreenState extends ConsumerState<MutualFriendsScreen> with AutomaticKeepAliveClientMixin {

  ScrollController controller = ScrollController();

  late List<MutualFriends$Query$PaginatedEventUsersResults$User> users;
  late List<int> usersIds;
  late bool hasMore;
  List<int> userIdsWhereUnfollow = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    users = widget.users;
    usersIds = users.map((user) => user.id).toList();
    hasMore = widget.hasMore;
    controller.addListener(() {
      if (hasMore) {
        final maxScrollExtent = controller.position.maxScrollExtent;
        final currentPos = controller.position.pixels;
        final screenHeight = MediaQuery.of(context).size.height - (45 + MediaQuery.of(context).padding.top);

        if (currentPos >= (maxScrollExtent - screenHeight * 2)) {
          if (isLoading == false) {
            setState(() {
              isLoading = true;
            });
            ref.read(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.userId}+${widget.uuid}").notifier).mutualFriends(widget.userId, 20, usersIds);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.userId}+${widget.uuid}"), (prev, next) {
      if (next is MutualFriendsLoadedState) {
        setState(() {
          users = [...users, ...next.val.users];
          usersIds = users.map((user) => user.id).toList();
          hasMore = next.val.hasMore;
          isLoading = false;
        });
      } else if (next is MutualFriendsChangeFollowState) {
        if (next.followState) {
          setState(() {
            userIdsWhereUnfollow.removeWhere((id) => id == next.user.id);
          });
        } else {
          setState(() {
            userIdsWhereUnfollow.add(next.user.id);
          });
        }
      }
    });

    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        top: true,
        child: Column(
          children: [
            SizedBox(
              // margin: EdgeInsets.only(top:statusBar, left: 8, right: 8),
              height: 45,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 45,
                        child: Center(
                          child: FloatingActions(
                            icon: EvaIcons.arrowBackOutline,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            // padding:  EdgeInsets.zero,
                            color: Colors.grey[800]!,
                            size: 36,
                            key: const Key("goBack_update_user")
                          ),
                        ),
                      )
                    ),
                  ),
                  Center(
                    child: Text(
                      // username,
                      "Mutual Friends",
                      style: TextStyle(
                        color: Colors.grey[800]!,
                        fontSize: 19,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ...users.map((user) {
                    return GestureDetector(
                      onTap: () {
                        // print("Hello there");
                        // final inviteRes = EventTypesConverter().convertOtherInviteResToFriendsInviteRes(invite);
                        // final user = ProfileUserData.fromSearchUsersQueryUser(searchUsersRes[searchUserResIndex]);
                        // context.push('/profile', extra: ProfileParams(
                        //     user: user,
                        //   )
                        // );
                      },
                      child: UserTile(
                        id: user.id,
                        profilePic: user.profilePic, 
                        name: user.name,
                        username: user.username,
                        followState: userIdsWhereUnfollow.contains(user.id) ? false : true,
                        extraWidget: SearchUserAddButton(
                          onAddOrRemoveStateChange: onAddOrRemoveStateChange,
                          userId: user.id.toInt(),
                          isFollow: userIdsWhereUnfollow.contains(user.id) ? false : true,
                          key: Key("addRemoveButton_${user.id}")
                        ),
                        key: Key("userTile_mutualFriends_${user.id}")
                      )
                    );
                  }).toList(),
                  if (isLoading && users.isNotEmpty)
                  const SizedBox(
                    height: 45,
                    child: Center(child: Loader(radius: 8))
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void onAddOrRemoveStateChange(AddRemoveState next, int userId) {

    MutualFriends$Query$PaginatedEventUsersResults$User user = users.where((user) => user.id == userId).first;

    switch(next.runtimeType) {
      case AddRemoveAddState:
        ref.read(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.userId}+${widget.uuid}").notifier).changeFollowState(user, true);
      break;
      case AddRemoveRemoveState:
        ref.read(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.userId}+${widget.uuid}").notifier).changeFollowState(user, false);
      break;
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}