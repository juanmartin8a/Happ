import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemove.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/riverpod/profile/addedMe/addedMe.dart';
import 'package:happ_client/src/riverpod/profile/addedMe/addedMeState.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/profile/myFriends/myFriends.dart';
import 'package:happ_client/src/riverpod/profile/myFriends/myFriendsState.dart';
import 'package:happ_client/src/riverpod/profile/followState/FollowState.dart';
import 'package:happ_client/src/riverpod/profile/followState/followStateState.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriends.dart';
import 'package:happ_client/src/riverpod/profile/mutualFriends/mutualFriendsState.dart';
import 'package:happ_client/src/riverpod/updateUser/updateUser.dart';
import 'package:happ_client/src/riverpod/updateUser/updateUserState.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/widgets/horizontalUserTile.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
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

  ProfileUserData.fromUserData(dynamic user) {

    late Map<String, dynamic> userJSON;

    if (user is Map<String, dynamic>) {
      userJSON = user;
    } else {
      userJSON = user.toJson();
    }

    id = userJSON["id"];
    username = userJSON["username"];
    name = userJSON["name"];
    if (userJSON["followState"] != null) {
      followState = userJSON["followState"];
    } else {
      followState = null;
    }
    profilePic = userJSON["profilePic"];
  }
}

class Profile extends ConsumerStatefulWidget {
  final ProfileUserData user;
  final bool comesFromMain;
  const Profile({
    required this.user,
    this.comesFromMain = false,
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
  late String profilePic;

  bool isInitLoading = true;
  bool? followState;


  List<MutualFriends$Query$PaginatedEventUsersResults$User> users = [];
  List<int> userIds = [];

  List<AddedMe$Query$PaginatedEventUsersResults$User> addedMeUsers = [];
  List<int> addedMeUsersIds = [];
  bool addedMeHasMore = true; 
  bool addedMeIsLoading = true;

  List<MyFriends$Query$PaginatedEventUsersResults$User> myFriendsUsers = [];
  List<int> myFriendsUsersIds = [];
  bool friendsHasMore = true; 
  bool friendsIsLoading = true;

  bool isLoading = true;
  bool hasMore = true; 

  @override
  void initState() {
    super.initState();
    id = widget.user.id.toInt();
    username = widget.user.username;
    name = widget.user.name;
    profilePic = widget.user.profilePic;
    if (widget.user.followState != null) {
      isInitLoading = false;
      followState = widget.user.followState;
    }
    if (id == ref.read(currentUserProvider)!.id) {
      followState = false;
    }
    
    if (id != ref.read(currentUserProvider)!.id) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (widget.user.followState == null) {
          ref.read(profileFollowStateProvider("PROFILE/followState/userId:${widget.user.id}+$uuid").notifier).getFollowState(id);
        }
        ref.read(profileMutualFriendsProvider("PROFILE/mutualFriends/userId:${widget.user.id}+$uuid").notifier).mutualFriends(id, 15, []);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(profileMyFriendsProvider("PROFILE/myFriends/sess:$uuid").notifier).myFriends(15, []);
        ref.read(profileAddedMeProvider("PROFILE/addedMe/sess:$uuid").notifier).addedMe(15, []);
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

    if (id == ref.read(currentUserProvider)!.id) {
      ref.listen(updateUserProvider, (prev, next) {
        if (next is  UpdateUserDoneState) {
          if (next.updateUserRes.user != null) {
            setState(() {
              username = next.updateUserRes.user!.username;
              name = next.updateUserRes.user!.name;
              profilePic = next.updateUserRes.user!.profilePic;
            });
          }
        }
      });
    }

    if (id != ref.read(currentUserProvider)!.id) {
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
            userIds = users.map((user) => user.id).toList();
            hasMore = next.val.hasMore;
            isLoading = false;
          });
        } else if (next is MutualFriendsChangeFollowState) {
          if (next.followState) {
            setState(() {
              users.insert(0, next.user);
              userIds = users.map((user) => user.id).toList();
            });
          } else {
            setState(() {
              users.removeWhere((user) => user.id == next.user.id);
              userIds = users.map((user) => user.id).toList();
            });
          }
        }
      });
    } else {
      ref.listen(profileMyFriendsProvider("PROFILE/myFriends/sess:$uuid"), (prev, next) {
        if (next is MyFriendsLoadedState) {
          if (myFriendsUsers.isEmpty) {
            setState(() {
              myFriendsUsers = [...myFriendsUsers, ...next.val.users];
              myFriendsUsersIds = myFriendsUsers.map((user) => user.id).toList();
              friendsHasMore = next.val.hasMore;
              friendsIsLoading = false;
            });
          }
        } else if (next is MyFriendsChangeFollowState) {
          if (next.followState) {
            setState(() {
              myFriendsUsers.insert(0, next.user);
              myFriendsUsersIds = myFriendsUsers.map((user) => user.id).toList();
            });
          } else {
            setState(() {
              myFriendsUsers.removeWhere((user) => user.id == next.user.id);
              myFriendsUsersIds = myFriendsUsers.map((user) => user.id).toList();
            });
          }
        }
      });

      ref.listen(profileAddedMeProvider("PROFILE/addedMe/sess:$uuid"), (prev, next) {
        if (next is AddedMeLoadedState) {
          if (next.isUpdate == true) {
            setState(() {
              addedMeUsers = next.val.users.length > 20 ? next.val.users.sublist(0, 20) : next.val.users;
              addedMeUsersIds = addedMeUsers.map((user) => user.id).toList();
            });
          } else {
            if (addedMeUsers.isEmpty) {
              setState(() {
                addedMeUsers = [...addedMeUsers, ...next.val.users];
                addedMeUsersIds = addedMeUsers.map((user) => user.id).toList();
                hasMore = next.val.hasMore;
                isLoading = false;
              });
            }
          }
        }
      });
    }

    Widget? notCurrentUserWidget;
    Widget? currentUserWidget;

    if (id != ref.read(currentUserProvider)!.id) {
      notCurrentUserWidget = GestureDetector(
        onTap: () {
          context.push(
            "/mutual-friends",
            extra: MutualFriendsParams(
              userId: id,
              users: List.from(users),
              hasMore: hasMore,
              uuid: uuid,
            )
          );
        },
        child: Column(
          children: [
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
            const SizedBox(height: 3),
            if (isLoading && users.isEmpty)
            Container(
              height: 66,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: const Loader(radius: 8)
                ),
              ),
            ),
      
            if (users.isNotEmpty)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 66,
              // padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                itemCount: users.length + 2,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  if (index == 0 || index == (users.length + 2) - 1) {
                    return const SizedBox(width: 6);
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
            ),
            if (users.isEmpty && !isLoading)
            Container(
              height: 66,
              // color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      text: "No mutual friends :0",
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  )
                ),
              )
            )
          ],
        ),
      );
    } else {
      currentUserWidget = Column(
        children: [
          GestureDetector(
            onTap: () {
              context.push(
                "/my-friends",
                extra: MyFriendsParams(
                  users: List.from(myFriendsUsers),
                  hasMore: friendsHasMore,
                  uuid: uuid,
                )
              );
            },
            child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Friends",
                    style: TextStyle(
                      color: Colors.grey[800]!,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                if (friendsIsLoading && myFriendsUsers.isEmpty)
                Container(
                  height: 66,
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
                ),

                if (myFriendsUsers.isNotEmpty)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  // padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.builder(
                    itemCount: myFriendsUsers.length + 2,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == (myFriendsUsers.length + 2) - 1) {
                        return const SizedBox(width: 6);
                      }
          
                      int realIndex = index - 1;
                      // int realIndex = 0;
          
                      return HorizontalUserTile(
                        followState: true,
                        name: myFriendsUsers[realIndex].name,
                        profilePic: myFriendsUsers[realIndex].profilePic,
                        username: myFriendsUsers[realIndex].username,
                        id: myFriendsUsers[realIndex].id,
                        key: Key("myFriends/from:$id+to:${myFriendsUsers[realIndex].id}"),
                      );
                    }
                  )
                ),
                if (myFriendsUsers.isEmpty && !friendsIsLoading)
                Container(
                  height: 66,
                  // color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          // text: "You haven't added your friends yet? ",
                          text: "Your friends' list is still empty? ",
                          style: TextStyle(
                            fontFamily: "Inter",
                            color: Colors.grey[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            if (Platform.isIOS) const TextSpan(text: '😱', style: TextStyle(fontSize: 18)),
                            if (!Platform.isIOS) const TextSpan(text: ':0'),
                          ]
                        )
                      )
                    ),
                  )
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              context.push(
                "/added-me",
                extra: AddedMeParams(
                  addedMeUsers: List.from(addedMeUsers),
                  hasMore: addedMeHasMore,
                  uuid: uuid,
                )
              );
            },
            child: Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Added Me",
                    style: TextStyle(
                      color: Colors.grey[800]!,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                if (addedMeIsLoading && addedMeUsers.isEmpty)
                Container(
                  height: 66,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: const Loader(radius: 8)
                    ),
                  ),
                ),

                if (addedMeUsers.isNotEmpty)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  // color: Colors.red,
                  // padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.builder(
                    itemCount: addedMeUsers.length + 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == (addedMeUsers.length + 2) - 1) {
                        return const SizedBox(width: 6);
                      }
          
                      int realIndex = index - 1;
          
                      return HorizontalUserTile(
                        followState: addedMeUsers[realIndex].followState,
                        name: addedMeUsers[realIndex].name,
                        profilePic: addedMeUsers[realIndex].profilePic,
                        username: addedMeUsers[realIndex].username,
                        id: addedMeUsers[realIndex].id,
                        key: Key("addedMe/from:$id+to:${addedMeUsers[realIndex].id}"),
                      );
                    }
                  )
                ),
                if (addedMeUsers.isEmpty && !addedMeIsLoading)
                Container(
                  height: 66,
                  // color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          text: "No one has added you as a friend... Yet! ",
                          style: TextStyle(
                            fontFamily: "Inter",
                            color: Colors.grey[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            if (Platform.isIOS) const TextSpan(text: '😉', style: TextStyle(fontSize: 18)),
                            if (!Platform.isIOS) const TextSpan(text: ';)'),
                          ]
                        )
                      )
                    ),
                  )
                )
              ],
            ),
          )
        ],
      );
    }


    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        top: false,
        child: Stack(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
                child: Column(
                  children: [
                    SizedBox(
                      height: 28 + MediaQuery.of(context).padding.top,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          profilePic,
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
                        name,
                        // "Juan Martin Zabala",
                        style: TextStyle(
                          color: Colors.grey[800]!,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      )
                    ),
                    const SizedBox(
                      height: 3
                    ),
                    Text(
                      username,
                      // "juanmartin8a",
                      style: TextStyle(
                        color: Colors.grey[600]!,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 16
                    ),
                    GestureDetector(
                      onTap: () {
                        if (id != ref.read(currentUserProvider)!.id) {
                          if (followState != null) {
                            ref.read(addOrRemoveUserProvider("userId:$id").notifier).addOrRemoveUser(id, !followState!);
                            isLoading = false;
                          }
                        } else {
                          Map<String, dynamic> userJson = {
                            "id": id,
                            "username": username,
                            "name": name,
                            "profilePic": profilePic,
                          };
                          final user = ProfileUserData.fromUserData(userJson);
                          // context.push('/profile', extra: ProfileParams(
                          //     user: user,
                          //   )
                          // );
                          context.push('/update-user', extra: ProfileParams(
                            user: user,
                          ));                        
                        }
                      },
                      child: Container(
                        height: 36,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isInitLoading ? Colors.grey[200]! : followState! ? Colors.grey[200]!.withOpacity(1): Colors.black,
                          // border: Border.all(color: Colors.grey[800]!, width: 2),
                          borderRadius: BorderRadius.circular(20)
                          // shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text(
                            id != ref.read(currentUserProvider)!.id
                            ? isInitLoading ? "Loading..." : followState! ? "Added" : "Add"
                            : "Edit",
                            style: TextStyle(
                              color: isInitLoading
                              ?Colors.grey[800]
                              : followState! ? Colors.grey[800] : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (id != ref.read(currentUserProvider)!.id)
                    notCurrentUserWidget!,
                    if (id == ref.read(currentUserProvider)!.id)
                    currentUserWidget!,
                  ],
                ),
              )
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
                height: 45 + MediaQuery.of(context).padding.top,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    
                    children: [
                      if (!widget.comesFromMain)
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
                      const Spacer(),
                      if (widget.comesFromMain)
                       Center(
                        child: GestureDetector(
                          onTap: () {
                            context.push('/settings');
                          },
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.only(right: 12, left: 12),
                            color: Colors.transparent,
                            child: const Icon(
                              EvaIcons.menu,
                              color: Colors.black,
                              size: 28
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}