import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/screens/search/widgets/saerchUserAddButton.dart';

class UserTile extends ConsumerWidget {
  final String profilePic;
  final String name;
  final String username;
  const UserTile({
    required this.profilePic,
    required this.name,
    required this.username,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                profilePic,
                fit: BoxFit.cover
              )
            )
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    username,
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
          // if (user.id != ref.read(currentUserProvider)!.id)
          // SearchUserAddButton(
          //   users: users,
          //   userId: user.id.toInt(),
          //   isFollow: user.followState,
          //   key: Key("addRemoveButton_${user.id}")
          // )
        ],
      ),
    );
  }
}