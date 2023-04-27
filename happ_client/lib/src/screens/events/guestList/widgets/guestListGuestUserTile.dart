import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListAction.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListActionState.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelect.dart';

class GuestListGuestUserTile extends ConsumerStatefulWidget {
  final GetEventGuests$Query$PaginatedEventUsersResults$User guest;
  final bool selectMode;
  const GuestListGuestUserTile({
    required this.guest,
    required this.selectMode,
    super.key
  });

  @override
  _GuestListGuestUserTileState createState() => _GuestListGuestUserTileState();
}

class _GuestListGuestUserTileState extends ConsumerState<GuestListGuestUserTile> with AutomaticKeepAliveClientMixin {

  bool isSelected = false;

  // @override
  // void initState() {
  //   super.initState();
  //   // isSelected = widget.isSelected;
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ref.listen(removeGuestSelectProvider, (prev, next) {
    //   if (next is RemoveGuestRemoveState) {
    //     if (next.userId == widget.guest.id) {
    //       if (isSelected) {
    //         setState(() {
    //           isSelected = false;
    //         });
    //       }
    //     }
    //   } else if (next is RemoveGuestSelectedState) {
    //     if (next.userId == widget.guest.id) {
    //       if (!selected) {
    //         setState(() {
    //           isSelected = true;
    //         });
    //       }
    //     }
    //   }
    // });
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
          ref.read(removeGuestSelectProvider.notifier).select(widget.guest.id, !isSelected);
          // if (isSelected) {
          //   setState(() {
          //     isSelected = false;
          //   });
          // } else {
          //   setState(() {
          //     isSelected = true;
          //   });
          // }
          setState(() {
            isSelected = !isSelected;
          });
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
                child: Image.network(widget.guest.profilePic),
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
            if (widget.selectMode)
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