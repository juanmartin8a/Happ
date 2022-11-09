import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/screens/search/widgets/saerchUserAddButton.dart';
import 'package:uuid/uuid.dart';

class SearchUserTile extends StatelessWidget {
  final List<SearchUsers$Query$User> users;
  final SearchUsers$Query$User user;
  const SearchUserTile({
    required this.users,
    required this.user,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.push('/profile', extra: user);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey[350],
                child: Image.network(
                  user.profilePic,
                  fit: BoxFit.cover
                )
                // child: ProfileImgLoader(
                //   file: file,
                //   isMe: id == CurrentUser.userId,
                //   key: Key('searchUser_$id')
                // )
              )
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // UsernameUI(
                    //   username: username,
                    //   isMe: id == CurrentUser.userId,
                    //   key: Key('searchUser_username_$id')
                    // ),
                    Text(
                      user.name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1
                      ),
                      // color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    // UsernameUI(
                    //   username: name,
                    //   isMe: id == CurrentUser.userId,
                    //   forName: true,
                    //   key: Key('searchUser_name_$id'),
                    //   textStyle: TextStyle(
                    //     color: Colors.grey,
                    //     fontSize: 14.5,
                    //     fontWeight: FontWeight.w400,
                    //     height: 1
                    //   ),
                    // )
                    Text(
                      user.username,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1
                      ),
                    )
                  ],
                )
              ),
            ),
            SearchUserAddButton(
              users: users,
              userId: user.id.toInt(),
              isFollow: user.followState,
              key: Key("addRemoveButton_${user.id}")
            )
            // if (isSearchedUsers)
            // GestureDetector(
            //   onTap: () {
                
            //     // removeSearchedUser!();
            //     // print("helo there");
            //   },
            //   child: Container(
            //     height: 26,
            //     width: 75,
            //     decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.circular(20)
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Added",
            //         style: TextStyle(
            //           color: Colors.grey[800],
            //           fontSize: 15,
            //           fontWeight: FontWeight.w600,
            //           height: 1
            //         )
            //       ),
            //     )
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}