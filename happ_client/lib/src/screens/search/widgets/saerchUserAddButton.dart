import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemove.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/riverpod/search/search.dart';

// class SearchUserAddButton extends ConsumerStatefulWidget {
class SearchUserAddButton extends ConsumerWidget {
  final List<SearchUsers$Query$User> users;
  final bool isFollow;
  final int userId;
  const SearchUserAddButton({
    required this.users,
    required this.isFollow,
    required this.userId,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen<AddRemoveState>(addOrRemoveUserProvider("userId:$userId"), (prev, next) {
      switch(next.runtimeType) {
        case AddRemoveAddState:
          ref.read(searchProvider.notifier).updateUserSearchTileState(users, userId, {"followState": true});
        break;
        case AddRemoveRemoveState:
          ref.read(searchProvider.notifier).updateUserSearchTileState(users, userId, {"followState": false});
        break;
        default: {}
        break;
      }
    });

    return GestureDetector(
      onTap: () {
        ref.read(addOrRemoveUserProvider("userId:$userId").notifier).addOrRemoveUser(userId, !isFollow);
      },
      child: Container(
        height: 26,
        width: 75,
        decoration: BoxDecoration(
          color: isFollow ?Colors.grey[200] : Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            isFollow ? "Added" : "Add",
            style: TextStyle(
              color: isFollow ?Colors.grey[800] : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1
            )
          ),
        )
      ),
    );
  }
}