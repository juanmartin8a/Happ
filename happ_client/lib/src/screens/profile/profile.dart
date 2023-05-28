import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/profile/followState/FollowState.dart';
import 'package:happ_client/src/riverpod/profile/followState/followStateState.dart';
import 'package:happ_client/src/screens/profile/widgets/addRemoveButton.dart';
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

  @override
  void initState() {
    super.initState();
    id = widget.user.id.toInt();
    username = widget.user.username;
    name = widget.user.name;
    // followState = widget.user.followState;
    
    if (id != ref.read(currentUserProvider)!.id) {
      ref.read(profileFollowStateProvider("PROFILE/userId:${widget.user.id}+$uuid").notifier).getFollowState(id);
      // ref.read(profileProvider("userId:${widget.user.id}_uuid:$uuid").notifier).getUser(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final profile = ref.watch(profileProvider("userId:${widget.user.id}_uuid:$uuid"));

    // bool isLoading = false;
    // bool hasError = false;
    
    // if (profile is ProfileLoadingState) {
    //   isLoading = true;
    // } else if (profile is ProfileErrorState) {
    //   hasError = true;
    // } else if (profile is ProfileLoadedState) {
    //   name = profile.user.name;
    //   username = profile.user.username;
    //   id = profile.user.id.toInt();
    //   followState = profile.user.followState;
    // }
    ref.listen(profileFollowStateProvider("PROFILE/userId:${widget.user.id}+$uuid"), (prev, next) {
      if (next is FollowStateLoadedState) {
        setState(() {
          if (isInitLoading == true) {
            isInitLoading = false;
          }
          followState = true;
        });
      }
    });


    return Material(
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
                            fontSize: 18,
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
                child: 
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      // color: Colors.yellow,
                      child: Container(
                        width: 100,
                        height: 100,
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
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16
                    ),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.user.name,
                            style: TextStyle(
                              color: Colors.grey[800]!,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 16
                          // ),
                          // Text(
                          //   ";)",
                          //   style: TextStyle(
                          //     color: Colors.grey[600]!,
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w500,
                          //     height: 1,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 16
                          ),
                          // Spacer(),
                          // AddRemoveButton(
                          //   isAdd: followState,
                          //   userId: id,
                          //   key: Key("profile_$id ${Uuid().v4()}")
                          // ),
                          // Container(
                          //   height: 32,
                          //   width: 80,
                          //   decoration: BoxDecoration(
                          //     // color: Colors.black,
                          //     border: Border.all(color: Colors.grey[800]!, width: 2),
                          //     borderRadius: BorderRadius.circular(16)
                          //     // shape: BoxShape.circle
                          //   ),
                          //   child:  Center(
                          //     child: Text(
                          //       "Add",
                          //       style: TextStyle(
                          //         color: Colors.grey[800]!,
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.w600,
                          //         height: 1
                          //       ),
                          //     ),
                          //   ),
                          // // ),
                          // const SizedBox(
                          //   height: 16
                          // ),
                          // Text(
                          //   ";)",
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     color: Colors.grey[700]!,
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w400,
                          //     height: 1,
                          //   ),
                          // ),
                        ],
                      )
                    ),
                    // const SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Mutual Friends",
                        style: TextStyle(
                          color: Colors.grey[800]!,
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      // padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(
                              left: index == 0 ? 24 : 8,
                              // top: 30,
                              // horizontal: 8
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                          );
                        }
                      )
                    ),
                    const SizedBox(
                      height: 12
                    ),
                    Container(
                      height: 28,
                      width: 60,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        border: Border.all(color: Colors.grey[800]!, width: 2),
                        borderRadius: BorderRadius.circular(14)
                        // shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1
                          ),
                        ),
                      ),
                    ),
                  ],
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