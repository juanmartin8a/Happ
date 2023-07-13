import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListAction.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListActionState.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelect.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/profile.dart';

class GuestListGuestUserTile extends ConsumerStatefulWidget {
  final GetEventGuests$Query$PaginatedEventUsersResults$User guest;
  final bool selectMode;
  // final bool isHost;
  const GuestListGuestUserTile({
    required this.guest,
    required this.selectMode,
    // this.isHost = false,
    super.key
  });

  @override
  _GuestListGuestUserTileState createState() => _GuestListGuestUserTileState();
}

class _GuestListGuestUserTileState extends ConsumerState<GuestListGuestUserTile> with AutomaticKeepAliveClientMixin {

  bool isSelected = false;
  @override

  Widget build(BuildContext context) {
    super.build(context);

    ref.listen(guestListActionProvider, (prev, next) {
      if (next is !GuestListActionRemoveState) {
        if (isSelected != false) {
          setState(() {
            isSelected = false;
          });
        }
      }
    });

    return GestureDetector(
      onTap: () {
        if (widget.selectMode) {
          if (widget.guest.id != ref.read(currentUserProvider)!.id) {
            ref.read(removeGuestSelectProvider.notifier).select(widget.guest.id, !isSelected);
            setState(() {
              isSelected = !isSelected;
            });
          }
        } else {
          final user = ProfileUserData.fromUserData(widget.guest);
          context.push('/profile', extra: ProfileParams(
              user: user,
            )
          );
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: SizedBox(
                height: 45,
                width: 45,
                child: Image.network(
                  widget.guest.profilePic,
                  fit: BoxFit.cover
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.guest.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    height: 1
                  )
                ),
                const SizedBox(height: 2),
                Text(
                  widget.guest.username,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1
                  ),
                )
              ],
            ),
            const Spacer(),
            if (widget.selectMode && widget.guest.id != ref.read(currentUserProvider)!.id)
            isSelected
            ? Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                color: Colors.red,
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
        )
      )
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}