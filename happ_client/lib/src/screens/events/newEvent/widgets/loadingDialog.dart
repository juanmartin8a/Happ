import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEvent/newEvent.dart';
import 'package:happ_client/src/riverpod/newEvent/newEventState.dart';
import 'package:uuid/uuid.dart';

class LoadingDialog extends ConsumerWidget {
  final Function func;
  const LoadingDialog({
    required this.func,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color widgetColor = Colors.black;
    bool isDefault = true;
    int? eventId;

    NewEventState state = ref.watch(newEventProvider);
    if (state is NewEventDoneState) {
      isDefault = false;
      if (state.newEventRes.errors == null) {
        widgetColor = Colors.greenAccent[700]!;
        eventId = state.newEventRes.event!.id;
      } else {
        widgetColor = Colors.red;
      }
    } else if (state is NewEventErrorState) {
      isDefault = false;
      widgetColor = Colors.red;
    }

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // GestureDetector(
          //   onTap: () => Navigator.pop(context),
          //   child: Container(color: Colors.black26)
          // ),
          Container(color: Colors.black26),
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
                    color: widgetColor,
                    key: Key(const Uuid().v4()),
                    // padding: const EdgeInsets.all(12),
                    child: isDefault == true 
                    ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const Text(
                            "Creating Event...",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1
                            )
                          ),
                          const SizedBox(height: 1),
                          Text(
                            "will take a few seconds",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                              // height: 1.5
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )
                          ),
                          const Spacer()
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
                                widgetColor == Colors.red 
                                ? "Error while creating event :'/" 
                                : "Event succesfully created! :D",
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
                              if (widgetColor == Colors.greenAccent[700]) {
                                func(2, newEventId: eventId);
                              } else {
                                func(0);
                              }
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                widgetColor == Colors.red  ? "Done" : "Next",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                )
                              ),
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