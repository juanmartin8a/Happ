import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';

class UserRemoveMakeOrganizerDialog extends ConsumerWidget {
  final SearchUsers$Query$User user;
  final bool isOrganizer;
  const UserRemoveMakeOrganizerDialog({
    required this.user,
    required this.isOrganizer,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black26)
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: isOrganizer == false ? 90 : 45,
                color: Colors.black,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!isOrganizer) {
                          ref.read(inviteUserSelectProvider.notifier).makeRemoveOrganizer(user, true);
                        } else {
                          ref.read(inviteUserSelectProvider.notifier).makeRemoveOrganizer(user, false);
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
                        ref.read(inviteUserSelectProvider.notifier).inviteSelect(user, false);
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