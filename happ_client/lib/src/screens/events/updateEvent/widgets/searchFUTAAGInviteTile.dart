import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/userRemoveMakeOrganizerDialog.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/profile.dart';

class SearchFUTAAGInviteTile extends ConsumerStatefulWidget {
  final SearchForUsersToAddToEvent$Query$User user;
  final bool isOrganizer;
  final bool isSelected;
  final bool fromGuestList;
  final bool isCreatorSeeing;
  const SearchFUTAAGInviteTile({
    required this.user,
    required this.isOrganizer,
    required this.isSelected,
    this.fromGuestList = false,
    this.isCreatorSeeing = false,
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
    ref.listen(uInviteUserSelectProvider, (prev, next) {
      if (next is UInviteUserRemoveState) {
        if (next.userId == widget.user.id) {
          if (isSelected) {
            setState(() {
              isSelected = false;
            });
          }
        }
      }
    });

    Widget rightSideWidget;

    if (widget.fromGuestList) {
      rightSideWidget = GestureDetector(
        onTap: () {
          showGeneralDialog(
            context: context, 
            barrierColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, anim1, anim2) {
              return UserRemoveMakeOrganizerDialog(
                user: widget.user, 
                isOrganizer: widget.isOrganizer, 
                fUTAAG: true,
                fUTAAGCUisCreator: widget.isCreatorSeeing,
              );
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
      );
    } else {
      if (
        widget.user.eventUserStatus == EventUserStatus.invited || 
        widget.user.eventUserStatus == EventUserStatus.confirmed
      ) {
        bool isConfirmed = widget.user.eventUserStatus == EventUserStatus.confirmed;
        rightSideWidget = Container(
          height: 26,
          width: 70,
          decoration: BoxDecoration(
            color: !isConfirmed ?Colors.grey[200] : Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              !isConfirmed ? "Invited" : "Going",
              style: TextStyle(
                color: !isConfirmed ? Colors.grey[900] : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              )
            ),
          )
        );
      } else {
        rightSideWidget = isSelected 
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
        );
      }
    }

    
    return GestureDetector(
      onTap: () {
        if (widget.fromGuestList) {
          final user = ProfileUserData.fromUserData(widget.user);
          context.push('/profile', extra: ProfileParams(
              user: user,
            )
          );
        } else {
          if (
            widget.user.eventUserStatus != EventUserStatus.confirmed &&
            widget.user.eventUserStatus != EventUserStatus.invited
          ) {
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
          }
        }
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
            rightSideWidget
          ],
        ),
      ),
    );
  }
}