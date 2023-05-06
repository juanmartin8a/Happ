import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEvent.dart';
import 'package:happ_client/src/riverpod/leaveEvent/leaveEventState.dart';
import 'package:uuid/uuid.dart';

class LeaveEventConfirmDialog extends ConsumerStatefulWidget {
  final int eventId;
  final bool isConfirmed;
  const LeaveEventConfirmDialog({
    required this.eventId,
    required this.isConfirmed,
    super.key
  });

  @override
  _LeaveEventConfirmDialogState createState() => _LeaveEventConfirmDialogState();
}

class _LeaveEventConfirmDialogState extends ConsumerState<LeaveEventConfirmDialog> {

  bool error = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(leaveEventProvider, (prev, next) {
      switch (next.runtimeType) {
        case LeaveEventDoneState:
          Navigator.pop(context);
          break;
        case LeaveEventLoadingState:
          setState(() {
            error = false;
            loading = true;
          });
          break;
        case LeaveEventErrorState:
          setState(() {
            error = true;
            loading = false;
          });
          break;
      }
    });
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!loading) {
                Navigator.pop(context);
              }
            },
            child: Container(color: Colors.black26)
          ),
          // Container(color: Colors.black26),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.black,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: Container(
                    height: 150,
                    width: 250,
                    color: !error ? Colors.black : Colors.red,
                    key: Key(const Uuid().v4()),
                    // padding: const EdgeInsets.all(12),
                    child: 
                    !error
                    ? Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        right: 12,
                        left: 12
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.isConfirmed ? "Leave Event?" : "Decline Invitation?",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  // height: 1
                                )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!loading && !error) {
                                ref.read(leaveEventProvider.notifier).leaveEvent(widget.eventId);
                              }
                              // Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: 
                              !loading ? Text(
                                widget.isConfirmed ? 'Leave' : 'Decline',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                ),
                              )
                              : const SizedBox(
                                height: 26,
                                width: 26,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3.5,
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        right: 12,
                        left: 12
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.isConfirmed 
                                  ? "Error while leaving event :'/"
                                  : "Error while declining invitation :'/",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child:
                              Text(
                                'Done',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}