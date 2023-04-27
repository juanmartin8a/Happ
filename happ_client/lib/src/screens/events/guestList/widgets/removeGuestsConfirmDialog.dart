import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuests.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListAction.dart';
import 'package:happ_client/src/riverpod/removeGuests/removeGuests.dart';
import 'package:happ_client/src/riverpod/removeGuests/removeGuestsState.dart';
import 'package:uuid/uuid.dart';

class RemoveGuestsConfirmDialog extends ConsumerStatefulWidget {
  final List<int> userIds;
  final int eventId;
  const RemoveGuestsConfirmDialog({
    required this.userIds,
    required this.eventId,
    super.key
  });

  @override
  _RemoveGuestsConfirmDialogState createState() => _RemoveGuestsConfirmDialogState();
}

class _RemoveGuestsConfirmDialogState extends ConsumerState<RemoveGuestsConfirmDialog> {
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
  bool success = false;

  Color backgroundColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    ref.listen(removeGuestsProvider, (prev, next) {
      switch (next.runtimeType) {
        case RemoveGuestsDoneState:
          ref.read(eventGuestsProvider.notifier).removeGuests(widget.userIds);
          ref.read(guestListActionProvider.notifier).isAdd(null);
          // Navigator.pop(context);
          setState(() {
            success = true;
            error = false;
            loading = false;
          });
          break;
        case RemoveGuestsLoadingState:
          setState(() {
            error = false;
            success = false;
            loading = true;
          });
          break;
        case RemoveGuestsErrorState:
          setState(() {
            error = true;
            success = false;
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
                    color: !error && !success ? Colors.black : success ? Colors.greenAccent[700] : Colors.red,
                    key: Key(const Uuid().v4()),
                    // padding: const EdgeInsets.all(12),
                    child: 
                    loading
                    ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: const [
                          SizedBox(height: 15),
                          Text(
                            "Removing Guests...",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1
                            )
                          ),
                          Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )
                          ),
                          Spacer()
                        ],
                      ),
                    )
                    : !error && !success
                    ? Padding(
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
                                "Remove Selected Guests?",
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
                              if (!loading && !error) {
                                ref.read(removeGuestsProvider.notifier).removeGuests(widget.userIds, widget.eventId);
                              }
                              // Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: SizedBox(
                                height: 26,
                                child: Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    height: 1
                                  ),
                                ),
                              )
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
                        children: [
                          Expanded(
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: success ? "" : "Error while removing guests :'/",
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                    if (success)
                                    const TextSpan(text: '👋 ', style: TextStyle(fontSize: 22)),
                                    if (success)
                                    const TextSpan(text: 'Guests succefully removed!')
                                  ]
                                )
                              )
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