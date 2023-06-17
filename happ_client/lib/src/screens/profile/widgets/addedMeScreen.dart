import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/riverpod/profile/addedMe/addedMe.dart';
import 'package:happ_client/src/riverpod/profile/addedMe/addedMeState.dart';
import 'package:happ_client/src/screens/profile/widgets/userTile.dart';
import 'package:happ_client/src/screens/search/widgets/saerchUserAddButton.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';

class AddedMeScreen extends ConsumerStatefulWidget {
  final List<AddedMe$Query$PaginatedEventUsersResults$User> addedMeUsers;
  final bool hasMore;
  final String uuid;
  const AddedMeScreen({
    required this.addedMeUsers,
    required this.hasMore,
    required this.uuid,
    super.key
  });

  @override
  _AddedMeScreenState createState() => _AddedMeScreenState();
}

class _AddedMeScreenState extends ConsumerState<AddedMeScreen> with AutomaticKeepAliveClientMixin {

  ScrollController controller = ScrollController();

  late List<AddedMe$Query$PaginatedEventUsersResults$User> addedMeUsers;
  late List<int> addedMeUsersIds;
  late bool hasMore;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    addedMeUsers = widget.addedMeUsers;
    addedMeUsersIds = addedMeUsers.map((user) => user.id).toList();
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
            ref.read(profileAddedMeProvider("PROFILE/addedMe/sess:${widget.uuid}").notifier).addedMe(15, addedMeUsersIds);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen(profileAddedMeProvider("PROFILE/addedMe/sess:${widget.uuid}"), (prev, next) {
      if (next is AddedMeLoadedState) {
        if (next.isUpdate == true) {
          setState(() {
            addedMeUsers = next.val.users;
            addedMeUsersIds = addedMeUsers.map((user) => user.id).toList();
          });
        } else {
          setState(() {
            addedMeUsers = [...addedMeUsers, ...next.val.users];
            addedMeUsersIds = addedMeUsers.map((user) => user.id).toList();
            hasMore = next.val.hasMore;
            isLoading = false;
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
                      "Added Me",
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
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
                children: [
                  ...addedMeUsers.map((user) {
                    return UserTile(
                      id: user.id,
                      profilePic: user.profilePic, 
                      name: user.name,
                      username: user.username,
                      followState: user.followState,
                      extraWidget: SearchUserAddButton(
                        onAddOrRemoveStateChange: onAddOrRemoveStateChange,
                        userId: user.id.toInt(),
                        isFollow: user.followState,
                        key: Key("addRemoveButton_${user.id}")
                      ),
                      key: Key("userTile_addedMe_${user.id}")
                    );
                  }).toList(),
                  if (isLoading && addedMeUsers.isNotEmpty)
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
    switch(next.runtimeType) {
      case AddRemoveAddState:
        ref.read(profileAddedMeProvider("PROFILE/addedMe/sess:${widget.uuid}").notifier).updateAddedMeList(addedMeUsers, hasMore, userId, {"followState": true});
      break;
      case AddRemoveRemoveState:
        ref.read(profileAddedMeProvider("PROFILE/addedMe/sess:${widget.uuid}").notifier).updateAddedMeList(addedMeUsers, hasMore, userId, {"followState": false});
      break;
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}