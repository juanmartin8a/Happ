import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addedMe/addedMe.dart';
import 'package:happ_client/src/riverpod/addedMe/addedMeState.dart';
import 'package:happ_client/src/screens/profile/widgets/userTile.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

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

class _AddedMeScreenState extends ConsumerState<AddedMeScreen> {

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
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(profileAddedMeProvider("PROFILE/addedMe/sess:${widget.uuid}"), (prev, next) {
      if (next is AddedMeLoadedState) {
        setState(() {
          addedMeUsers = [...addedMeUsers, ...next.val.users];
          addedMeUsersIds = addedMeUsers.map((user) => user.id).toList();
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                itemCount: addedMeUsers.length + 1,
                itemBuilder: (context, i) {
            
                  if (i == (addedMeUsers.length + 1) - 1) {
                    return const SizedBox(height: 150);
                  }
            
                  // int realIndex = i - 1;
            
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
                    // FlOW (nothing happens, just update the followState)

                    // FLOW on mutual friends and friends (user has added that user by default)
                    // On remove just remove the selected user from the list.
                    child: UserTile(
                      profilePic: addedMeUsers[i].profilePic, 
                      name: addedMeUsers[i].name,
                      username: addedMeUsers[i].username,
                      key: Key("userTile_addedMe_${addedMeUsers[i].id}")
                    )
                  );
                  //
                }
              ),
            )
          ],
        ),
      )
    );
  }
}