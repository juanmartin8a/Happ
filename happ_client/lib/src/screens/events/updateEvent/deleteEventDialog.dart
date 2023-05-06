import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEvent.dart';
import 'package:happ_client/src/riverpod/deleteEvent/deleteEventState.dart';
import 'package:uuid/uuid.dart';

class DeleteEventDialog extends ConsumerStatefulWidget {
  final int eventId;
  const DeleteEventDialog({
    required this.eventId,
    super.key
  });

  @override
  _DeleteEventDialogState createState() => _DeleteEventDialogState();
}

class _DeleteEventDialogState extends ConsumerState<DeleteEventDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class RemoveGuestsConfirmDialog extends ConsumerWidget {
  // final List<int> userIds;
  // final int eventId;
  // const RemoveGuestsConfirmDialog({
  //   required this.userIds,
  //   required this.eventId,
  //   super.key
  // });

  bool error = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(deleteEventProvider, (prev, next) {
      switch (next.runtimeType) {
        case DeleteEventDoneState:
          // ref.read(deleteEventProvider.notifier).deleteEvent(widget.eventId);
          // ref.read(guestListActionProvider.notifier).isAdd(null);
          Navigator.pop(context);
          break;
        case DeleteEventLoadingState:
          setState(() {
            error = false;
            loading = true;
          });
          break;
        case DeleteEventErrorState:
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
                                !loading ? "Delete Event?" : "Deleting Event...",
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
                                ref.read(deleteEventProvider.notifier).deleteEvent(widget.eventId);
                              }
                              // Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: 
                              !loading ? const Text(
                                'Delete',
                                style: TextStyle(
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
                          const Expanded(
                            child: Center(
                              child: Text(
                                "Error while deleting event :'/",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child:
                              Text(
                                'Done',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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