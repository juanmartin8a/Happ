import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';

class UserRemoveMakeOrganizerDialog extends ConsumerWidget {
  final dynamic user;
  final bool isOrganizer;
  // final SearchUsers$Query$User otherUser;
  final bool fUTAAG;
  final bool fUTAAGCUisCreator;
  const UserRemoveMakeOrganizerDialog({
    required this.user,
    required this.isOrganizer,
    this.fUTAAG = false,
    this.fUTAAGCUisCreator = true,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(isOrganizer);
    print(fUTAAGCUisCreator);
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black26)
          ),
          // if (fUTAAGCUisCreator)
          // just dont allow to see the make host thing when the user is seeing is not creator
          // if isOrganizer and 
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: isOrganizer == false && fUTAAGCUisCreator ? 90 : 45,
                color: Colors.black,
                child: Column(
                  children: [
                    if (fUTAAGCUisCreator)
                    GestureDetector(
                      onTap: () {
                        if (!isOrganizer) {
                          if (fUTAAG) {
                            ref.read(uInviteUserSelectProvider.notifier).makeRemoveOrganizer(user as SearchForUsersToAddToEvent$Query$User, true);
                          } else {
                            ref.read(inviteUserSelectProvider.notifier).makeRemoveOrganizer(user as SearchUsers$Query$User, true);
                          }
                        } else {
                          if (fUTAAG) {
                            ref.read(uInviteUserSelectProvider.notifier).makeRemoveOrganizer(user as SearchForUsersToAddToEvent$Query$User, false);
                          } else {
                            ref.read(inviteUserSelectProvider.notifier).makeRemoveOrganizer(user as SearchUsers$Query$User, false);
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            isOrganizer == false ? "Make Host" : "Remove From Hosts",
                            style: TextStyle(
                              color: isOrganizer == false ? Colors.white : Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!isOrganizer)
                    GestureDetector(
                      onTap: () {
                        if (fUTAAG) {
                          ref.read(uInviteUserSelectProvider.notifier).inviteSelect(user as SearchForUsersToAddToEvent$Query$User, false);
                        } else {
                          ref.read(inviteUserSelectProvider.notifier).inviteSelect(user as SearchUsers$Query$User, false);
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        color: Colors.transparent,
                        child: const Center(
                          child: Text(
                            "Remove",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}