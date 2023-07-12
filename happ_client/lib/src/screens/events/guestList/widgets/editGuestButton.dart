import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListAction.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListActionState.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelect.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelectState.dart';
import 'package:happ_client/src/screens/events/guestList/widgets/AddOrRemoveDialog.dart';
import 'package:happ_client/src/screens/events/guestList/widgets/removeGuestsConfirmDialog.dart';

class EditGuestButton extends ConsumerStatefulWidget {
  final double opacity;
  final int eventId;
  const EditGuestButton({
    required this.opacity,
    required this.eventId,
    super.key
  });

  @override
  _EditGuestButtonState createState() => _EditGuestButtonState();
}

class _EditGuestButtonState extends ConsumerState<EditGuestButton> {

  List<int> usersToRemoveIds = [];

  bool selectMode = false;
  
  @override
  Widget build(BuildContext context) {
    ref.listen(guestListActionProvider, (prev, next) {
      if (next is GuestListActionRemoveState) {
        setState(() {
          selectMode = true;
        });
      } else {
        setState(() {
          selectMode = false;
          usersToRemoveIds = [];
        });
      }
    });
    ref.listen(removeGuestSelectProvider, (prev, next) {
      if (next is RemoveGuestRemoveState) {
        setState(() {
          usersToRemoveIds.removeWhere((userId) => userId == next.userId);
        });
      } else if (next is RemoveGuestSelectedState) {
        setState(() {
          usersToRemoveIds.add(next.userId);
        });
      }
    });
    return Container(
      // width: 45 * 1.25,
      height: 45 * 1.25,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.opacity == 1) {
                if (selectMode == false) {
                  showGeneralDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (context, anim1, anim2) {
                      return const AddOrRemoveGuestDialog();
                    }
                  );
                } else {
                  if (usersToRemoveIds.isNotEmpty) {
                    showGeneralDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, anim1, anim2) {
                        return RemoveGuestsConfirmDialog(userIds: usersToRemoveIds, eventId: widget.eventId);
                      }
                    );
                  }
                }
              }
            },
            child: Container(
              width: 45 * 1.25,
              height: 45 * 1.25,
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  selectMode == false ? FluentIcons.edit_16_regular : FluentIcons.delete_16_regular,
                  size: 28,
                  color: selectMode == false ?Colors.white : usersToRemoveIds.isNotEmpty ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
          if (selectMode)
          GestureDetector(
            onTap: () {
              ref.read(guestListActionProvider.notifier).isAdd(null);
            },
            child: Container(
              width: 45 * 1.25,
              height: 45 * 1.25,
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  EvaIcons.close,
                  size: 30,
                  color: selectMode == false ?Colors.white : Colors.white,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}