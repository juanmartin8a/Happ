import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';

class SearchFUTAAGInviteTile extends ConsumerStatefulWidget {
  final SearchForUsersToAddAsGuests$Query$User user;
  final bool isSelected;
  const SearchFUTAAGInviteTile({
    required this.user,
    required this.isSelected,
    super.key
  });

  @override
  _SearchFUTAAGInviteTileState createState() => _SearchFUTAAGInviteTileState();
}

class _SearchFUTAAGInviteTileState extends ConsumerState<SearchFUTAAGInviteTile> {

  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          setState(() {
            isSelected = false;
          });
        } else {
          setState(() {
            isSelected = true;
          });
        }
        ref.read(addNewGuestsSelectProvider.notifier).inviteSelect(widget.user, isSelected);
      },
      child: Container(
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
                      widget.user.name,
                      style: TextStyle(
                        color: Colors.grey[900],
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
            isSelected 
            ? Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.greenAccent[700]!,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  FluentIcons.checkmark_12_regular,
                  color: Colors.white,
                  size: 20
                )
              )
            )
            : Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                // color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2)
              )
            )
          ],
        ),
      ),
    );
  }
}