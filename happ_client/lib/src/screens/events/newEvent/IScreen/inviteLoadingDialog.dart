import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuests.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuestsState.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/inviteGuestsAndOrganizers/inviteGuestsAndOrganizers.dart';
import 'package:happ_client/src/riverpod/inviteGuestsAndOrganizers/inviteGuestsAndOrganizersState.dart';
import 'package:uuid/uuid.dart';

class InviteLoadingDialog extends ConsumerWidget {
  final Function func;
  final bool comesFromAddNewGuests;
  const InviteLoadingDialog({
    required this.func,
    this.comesFromAddNewGuests = false,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Color widgetColor = Colors.black;
    bool isDefault = true;

    if (!comesFromAddNewGuests) {
      InviteGuestsAndOrganizersState state = ref.watch(inviteGuestsAndOrganizersProvider);
      if (state is InviteGuestsAndOrganizersDoneState) {
        if (state.res == true) {
          isDefault = false;
          widgetColor = Colors.greenAccent[700]!;
        } else {
          isDefault = false;
          widgetColor = Colors.red;
        }
      } else if (state is InviteGuestsAndOrganizersErrorState) {
        isDefault = false;
        widgetColor = Colors.red;
      }
    } else {
      AddGuestsState state = ref.watch(addGuestsProvider);
      if (state is AddGuestsDoneState) {
        if (state.res == true) {
          isDefault = false;
          widgetColor = Colors.greenAccent[700]!;

          ref.invalidate(addNewGuestsSelectProvider);
        } else {
          isDefault = false;
          widgetColor = Colors.red;
        }
      } else if (state is AddGuestsErrorState) {
        isDefault = false;
        widgetColor = Colors.red;
      }
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
                        children: const [
                          // const Spacer(),
                          SizedBox(height: 15),
                          Text(
                            "Inviting Guests...",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1
                            )
                          ),
                          // const SizedBox(height: 1),
                          // Text(
                          //   "May take a few seconds",
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w400,
                          //     color: Colors.grey[500],
                          //     // height: 1.5
                          //   ),
                          // ),
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
                                ? "Error while inviting guests :'(" 
                                : "Guests succesfully invited! :D",
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
                              // if (widgetColor == Colors.greenAccent[700]) {
                              //   func(0, newEventId: eventId);
                              // } else {
                              if (comesFromAddNewGuests) {
                                ref.invalidate(addGuestsProvider);
                              }
                              Navigator.pop(context);
                              if (!comesFromAddNewGuests) {
                                func(0, callRefresh: true);
                              }
                              // }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 17,
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