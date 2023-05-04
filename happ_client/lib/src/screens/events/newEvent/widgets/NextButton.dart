import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/inviteGuestsAndOrganizers/inviteGuestsAndOrganizers.dart';
import 'package:happ_client/src/riverpod/newEvent/newEvent.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventCompleteState.dart';
import 'package:flutter/material.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/inviteLoadingDialog.dart';
import 'package:happ_client/src/screens/events/newEvent/widgets/loadingDialog.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart' as latLng;

// final newEventCompleteProvider =
//   StateNotifierProvider<NewEventCompleteController, NewEventCompleteState>((ref) => NewEventCompleteController());

class NextButton extends ConsumerStatefulWidget {
  final int page;
  final Function animateToPage;
  const NextButton({
    required this.page,
    required this.animateToPage,
    super.key
  });

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends ConsumerState<NextButton> {

  String? name;
  String? description;
  List<MultipartFile>? eventPics;
  List<MultipartFile>? lightEventPics;
  DateTime? date;
  DateTime? time;
  latLng.LatLng? location;
  String? eventPlace;
  List<int> guests = [];
  List<int> organizers = [];
  int? eventId;
  
  
  @override
  Widget build(BuildContext context) {
    NewEventCompleteState state = ref.watch(newEventCompleteProvider);
    if (state is NewEventCompleteFieldsState) {
      if (state.name != null) name = state.name;
      if (state.description != null) description = state.description;
      if (state.eventPics != null) eventPics = state.eventPics;
      if (state.lightEventPics != null) lightEventPics = state.lightEventPics;
      if (state.date != null) date = state.date;
      if (state.time != null) time = state.time;
      if (state.location != null) location = state.location;
      if (state.eventPlace != null) eventPlace = state.eventPlace;
      if (state.guests != null) guests = state.guests!;
      if (state.organizers != null) organizers = state.organizers!;
      if (state.eventId != null) eventId = state.eventId;
    }

    // check if is empty
    Color buttonColor;
    String text;

    if (widget.page == 0) {
      buttonColor = (name != null && description != null && eventPics != null && lightEventPics != null) ? Colors.black : Colors.grey[500]!;
      text = "Next";
    } else if (widget.page == 1) {
      buttonColor = (date != null && time != null && location != null) ? Colors.black : Colors.grey[500]!;
      text = "Create Event";
    } else {
      buttonColor = ((guests.isNotEmpty || organizers.isNotEmpty) && eventId != null) ? Colors.black : Colors.grey[500]!;
      text = "Invite";
    }

    return GestureDetector(
      onTap: () {
        if (widget.page == 0) {
          if (name != null && description != null && eventPics != null && lightEventPics != null) {
            widget.animateToPage(1);
          }
        } else if (widget.page == 1) {
          if (date != null && time != null && location != null && eventPlace != null) {
            DateTime dateTime = DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
            String dateTimeToString = dateTime.millisecondsSinceEpoch.toString();
            ref.read(newEventProvider.notifier).newEvent(name!, description!, dateTimeToString, eventPics!, lightEventPics!, location!.latitude, location!.longitude, eventPlace!);
            
            showGeneralDialog(
              context: context,
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (context, anim1, anim2) {
                return LoadingDialog(
                  // text: "Creating Event...",
                  func: widget.animateToPage,
                );
              }
            );
          }
        } else if (widget.page == 2) {
          if ((guests.isNotEmpty || organizers.isNotEmpty) && eventId != null) {
            ref.read(inviteGuestsAndOrganizersProvider.notifier).inviteGuestsAndOrganizers(guests, organizers, eventId!);
            showGeneralDialog(
              context: context,
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (context, anim1, anim2) {
                return InviteLoadingDialog(
                  // text: "Creating Event...",
                  func: widget.animateToPage,
                );
              }
            );
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: EdgeInsets.only(bottom: 20 + 36 + MediaQuery.of(context).padding.bottom),
        height: 45,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
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