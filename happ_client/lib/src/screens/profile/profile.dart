import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemove.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/profile/followState/FollowState.dart';
import 'package:happ_client/src/riverpod/profile/followState/followStateState.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriends.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriendsState.dart';
import 'package:happ_client/src/screens/profile/widgets/addRemoveButton.dart';
import 'package:happ_client/src/screens/profile/widgets/horizontalUserTile.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class ProfileUserData {
  ProfileUserData();

  late int id;
  late String username;
  late String name;
  late bool? followState;
  late String profilePic;

  ProfileUserData.fromSearchUsersQueryUser(SearchUsers$Query$User user) {
    id = user.id;
    username = user.username;
    name = user.name;
    followState = user.followState;
    profilePic = user.profilePic;
  }

  ProfileUserData.fromIdUsernameNameAndProfilePic(dynamic user) {

    final userJSON = user.toJson();

    id = userJSON["id"];
    username = userJSON["username"];
    name = userJSON["name"];
    followState = null;
    profilePic = userJSON["profilePic"];
  }
}

class Profile extends ConsumerStatefulWidget {
  final ProfileUserData user;
  const Profile({
    required this.user,
    required Key key,
  }) : super(key: key);

  @override
  ConsumerState<Profile> createState() => ProfileState();
}

class ProfileState extends ConsumerState<Profile> with AutomaticKeepAliveClientMixin {

  String uuid = const Uuid().v4();

  late int id;
  late String username;
  late String name;

  bool isInitLoading = true;
  bool? followState;


  List<MutualFriends$Query$PaginatedEventUsersResults$User> users = [];
  List<int> userIds = [];

  bool isLoading = false;
  bool hasMore = true; 

  @override
  void initState() {
    super.initState();
    id = widget.user.id.toInt();
    username = widget.user.username;
    name = widget.user.name;
    if (widget.user.followState != null) {
      isInitLoading = false;
      followState = widget.user.followState;
    }
    
    if (id != ref.read(currentUserProvider)!.id) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (widget.user.followState == null) {
          ref.read(profileFollowStateProvider("PROFILE/followState/userId:${widget.user.id}+$uuid").notifier).getFollowState(id);
        }
        ref.read(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.user.id}+$uuid").notifier).mutualFriends(id, 15, []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ref.listen<AddRemoveState>(addOrRemoveUserProvider("userId:$id"), (prev, next) {
      switch(next.runtimeType) {
        case AddRemoveAddState:
          setState(() {
            followState = true;
          });
        break;
        case AddRemoveRemoveState:
          setState(() {
            followState = false;
          });
        break;
        default: {}
        break;
      }
    });

    if (widget.user.followState == null) {
      ref.listen(profileFollowStateProvider("PROFILE/followState/userId:${widget.user.id}+$uuid"), (prev, next) {
        if (next is FollowStateLoadedState) {
          setState(() {
            if (isInitLoading == true) {
              isInitLoading = false;
            }
            followState = true;
          });
        }
      });
    }

    ref.listen(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.user.id}+$uuid"), (prev, next) {
      if (next is MutualFriendsLoadedState) {
        setState(() {
          users = [...users, ...next.val.users];
          userIds = users.map((invite) => invite.id).toList();
          hasMore = next.val.hasMore;
          isLoading = false;
        });
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
          // mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // margin: EdgeInsets.only(top:statusBar, left: 8, right: 8),
                height: 45,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    
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
                          key: Key("goBack_${widget.user.id}")
                        )
                      ),
                      Center(
                        child: Text(
                          username,
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 17,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            // if (isLoading != true)
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            widget.user.profilePic,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16
                      ),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          widget.user.name,
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        )
                      ),
                      const SizedBox(
                        height: 24
                      ),
                      GestureDetector(
                        onTap: () {
                          if (followState != null) {
                            ref.read(addOrRemoveUserProvider("userId:$id").notifier).addOrRemoveUser(id, !followState!);
                          }
                        },
                        child: Container(
                          height: 35,
                          // width: 80,
                          width: MediaQuery.of(context).size.width - 24,
                          decoration: BoxDecoration(
                            color: isInitLoading ? Colors.transparent : followState! ? Colors.grey[200] : Colors.black,
                            // border: Border.all(color: Colors.grey[800]!, width: 2),
                            borderRadius: BorderRadius.circular(50)
                            // shape: BoxShape.circle
                          ),
                          child: Center(
                            child: Text(
                              isInitLoading ? "" : followState! ? "Added" : "Add",
                              style: TextStyle(
                                color: followState! ? Colors.grey[800] : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Mutual Friends",
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 157,
                        // padding: const EdgeInsets.symmetric(horizontal: 24),
                        child:  users.isNotEmpty
                        ? ListView.builder(
                          itemCount: users.length + 2,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            if (index == 0 || index == (users.length + 2) - 1) {
                              return const SizedBox(width: 12);
                            }
                
                            int realIndex = index - 1;
                
                            return HorizontalUserTile(
                              followState: true,
                              name: users[realIndex].name,
                              profilePic: users[realIndex].profilePic,
                              username: users[realIndex].username,
                              id: users[realIndex].id,
                              key: Key("mutualUser/from:$id+to:${users[realIndex].id}"),
                            );
                          }
                        )
                        : Container()
                      ),
                    ],
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}