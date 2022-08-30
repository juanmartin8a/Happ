import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/search/search.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SearchState searchUserState = ref.watch(searchProvider);
    if (searchUserState is !SearchLoadedState) {
      return const SizedBox();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (searchUserState.searchUsersRes.isEmpty)
        // Container(
          
        // ),
        // if (searchUserState.searchUsersRes.isNotEmpty)
        // Text(
        //   "Results ;)",
        //   style: TextStyle(
        //     color: Colors.grey[800],
        //     fontSize: 22,
        //     fontWeight: FontWeight.w800,
        //     height: 1
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: searchUserState.searchUsersRes.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                if (searchUserState.searchUsersRes.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Results ;)",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.only(top: 150),
                    color: Colors.transparent,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Sorry, could not find any users T_T\n",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: '🤥💀', style: TextStyle(fontSize: 28))
                        ]
                      )
                    )
                  );
                }
              }
              int searchUserResIndex = i - 1;
              String username = searchUserState.searchUsersRes[searchUserResIndex].username;
              String name = searchUserState.searchUsersRes[searchUserResIndex].name;
              return Container(
                // margin: EdgeInsets.symmetric(horizontal: 8),
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
                        margin: EdgeInsets.only(left: 8),
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
                              name,
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
                              username,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1
                              ),
                              // color: Colors.white,
                            )
                            // Text(
                            //   username,
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w600,
                            //   )
                            // ),
                            // Text(
                            //   name,
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //   )
                            // ),
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
              );
            }
          ),
        ),
      ],
    );
  }
}