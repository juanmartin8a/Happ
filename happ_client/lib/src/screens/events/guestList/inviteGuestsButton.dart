import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuests.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/addNewGuestsSelectState.dart';
import 'package:flutter/material.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/inviteLoadingDialog.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart' as latLng;

// final newEventCompleteProvider =
//   StateNotifierProvider<NewEventCompleteController, NewEventCompleteState>((ref) => NewEventCompleteController());

class InviteGuestsButton extends ConsumerStatefulWidget {
  final int eventId;
  const InviteGuestsButton({
    required this.eventId,
    super.key
  });

  @override
  _InviteGuestsButtonState createState() => _InviteGuestsButtonState();
}

class _InviteGuestsButtonState extends ConsumerState<InviteGuestsButton> {

  List<int> guests = [];
  List<int> hosts = [];  
  
  @override
  Widget build(BuildContext context) {

    ref.listen(addNewGuestsSelectProvider, (prev, next) {
      if (next is AddNewGuestsSelectedState) {
        setState(() {
          guests.add(next.user.id);
        });
      } else if (next is AddNewGuestsRemoveState) {
        setState(() {
          guests.removeWhere((item) => item == next.userId);
        });
      } else if (next is AddNewGuestsInitState) {
        setState(() {
          guests = [];
        });
      }
    });

    // ref.listen(addGuestsProvider, (prev, next) {
    //   switch (next.runtimeType) {
    //     case AddGuestsDoneState:
    //       Navigator.pop(context);
    //       break;
    //     case AddGuestsLoadingState:
    //       setState(() {
    //         error = false;
    //         loading = true;
    //       });
    //       break;
    //     case AddGuestsErrorState:
    //       setState(() {
    //         error = true;
    //         loading = false;
    //       });
    //       break;
    //   }
    // });

    return GestureDetector(
      onTap: () {
        if (guests.isNotEmpty) {
          ref.read(addGuestsProvider.notifier).addGuests(guests, hosts, widget.eventId);
          showGeneralDialog(
            context: context,
            barrierColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, anim1, anim2) {
              return InviteLoadingDialog(
                // text: "Creating Event...",
                func: () {},
                comesFromAddNewGuests: true,
                key: const Key("new_guests")
              );
            }
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 45,
        decoration: BoxDecoration(
          color: guests.isNotEmpty ? Colors.black : Colors.grey[500],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 6,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Invite",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              // height: 1
            )
          ),
        )
      ),
    );
  }
}