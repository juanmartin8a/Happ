import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/userRemoveMakeOrganizerDialog.dart';
import 'package:happ_client/src/utils/user/currentUser.dart';

class SearchUserInviteTile extends ConsumerStatefulWidget {
  final SearchUsers$Query$User user;
  final bool isSelected;
  final bool fromGuestList;
  final bool isOrganizer;
  const SearchUserInviteTile({
    required this.user,
    required this.isSelected,
    this.fromGuestList = false,
    this.isOrganizer = false,
    super.key
  });

  @override
  _SearchUserInviteTileState createState() => _SearchUserInviteTileState();
}

class _SearchUserInviteTileState extends ConsumerState<SearchUserInviteTile> {

  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(inviteUserSelectProvider, (prev, next) {
      if (next is InviteUserRemoveState) {
        if (next.userId == widget.user.id) {
          if (isSelected) {
            setState(() {
              isSelected = false;
            });
          }
        }
      }
    });
    return GestureDetector(
      onTap: !widget.fromGuestList ? () {
        if (isSelected) {
          setState(() {
            isSelected = false;
          });
        } else {
          setState(() {
            isSelected = true;
          });
        }
        ref.read(inviteUserSelectProvider.notifier).inviteSelect(widget.user, isSelected);
      } : null,
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
            !widget.fromGuestList
            ? isSelected 
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
            : GestureDetector(
              onTap: () {
                // call dialog that lets user remove guest 
                // and (upgrade it to admin || remove it from admin)
                showGeneralDialog(
                  context: context, 
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, anim1, anim2) {
                    return UserRemoveMakeOrganizerDialog(user: widget.user, isOrganizer: widget.isOrganizer);
                  }
                );
              },
              child: SizedBox(
                height: 26,
                width: 26,
                child: Center(
                  child: Icon(
                    FluentIcons.more_vertical_20_regular,
                    color: Colors.grey[800]!,
                    size: 26
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}