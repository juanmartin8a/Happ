import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happ_client/src/screens/events/widgets/leaveEventConfirmDialog.dart';

class LeaveEventDialog extends StatelessWidget {
  final int eventID;
  final bool isConfirmed;

  const LeaveEventDialog({
    required this.eventID,
    required this.isConfirmed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black26)
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width * 0.6,
                    // height: (MediaQuery.of(context).size.width * 0.8) * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showGeneralDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              transitionDuration: const Duration(milliseconds: 200),
                              pageBuilder: (context, anim1, anim2) {
                                return LeaveEventConfirmDialog(eventId: eventID, isConfirmed: isConfirmed);
                              }
                            );
                          },
                          child: Container(
                            height: 45,
                            // width: 60,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isConfirmed)
                                  const RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      EvaIcons.logOutOutline,
                                      size: 26,
                                      color: Colors.red
                                    ),
                                  ),
                                  if (isConfirmed)
                                  const SizedBox(width: 8),
                                  if (!isConfirmed)
                                  const Icon(
                                    EvaIcons.close,
                                    size: 30,
                                    color: Colors.red
                                  ),
                                  if (!isConfirmed)
                                  const SizedBox(width: 4),
                                  Text(
                                    isConfirmed ? "Can't make it" : 'Skip this one',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      height: 1
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}