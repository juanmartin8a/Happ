import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/screens/search/widgets/saerchUserAddButton.dart';
import 'package:happ_client/src/screens/search/searchBar.dart';

class SearchUserTile extends ConsumerStatefulWidget {
  final List<SearchUsers$Query$User> users;
  final SearchUsers$Query$User user;
  const SearchUserTile({
    required this.users,
    required this.user,
    Key? key
  }) : super(key: key);
  
  @override
  _SearchUserTileState createState() => _SearchUserTileState();
}

class _SearchUserTileState extends ConsumerState<SearchUserTile> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class SearchUserTile extends ConsumerWidget {
//   final List<SearchUsers$Query$User> users;
//   final SearchUsers$Query$User user;
//   const SearchUserTile({
//     required this.users,
//     required this.user,
//     Key? key
//   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      color: Colors.transparent,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 45,
              height: 45,
              color: Colors.grey[350],
              child: Image.network(
                widget.user.profilePic,
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
                    widget.user.name,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.user.username,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1
                    ),
                  )
                ],
              )
            ),
          ),
          if (widget.user.id != ref.read(currentUserProvider)!.id)
          SearchUserAddButton(
            onAddOrRemoveStateChange: onAddOrRemoveStateChange,
            userId: widget.user.id.toInt(),
            isFollow: widget.user.followState,
            key: Key("addRemoveButton_${widget.user.id}")
          )
        ],
      ),
    );
  }

  void onAddOrRemoveStateChange(AddRemoveState next, int userId) {
    switch(next.runtimeType) {
      case AddRemoveAddState:
        ref.read(searchProvider.notifier).updateUserSearchTileState(widget.users, userId, {"followState": true});
      break;
      case AddRemoveRemoveState:
        ref.read(searchProvider.notifier).updateUserSearchTileState(widget.users, userId, {"followState": false});
      break;
    }
  }
}