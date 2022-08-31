import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

class SearchUserTile extends StatelessWidget {
  final SearchUsers$Query$User user;
  const SearchUserTile({
    required this.user,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/profile', extra: user);
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
                color: Colors.yellow
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
                        fontSize: 17,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1
                      ),
                    )
                  ],
                )
              ),
            ),
            // if (isSearchedUsers)
            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       removeSearchedUser!();
            //     },
            //     child: Container(
            //       color: Colors.transparent,
            //       child: FloatingActions(
            //         icon: EvaIcons.close,
            //         padding: EdgeInsets.only(top: 8, bottom: 8, left: 4),
            //         size: 18,
            //         color: Colors.grey[600]!,
            //         key: Key("searchedUsers_$id")
            //       )
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}