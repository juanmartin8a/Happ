import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReadyState.dart';
import 'package:flutter/material.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEvent.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/loadingUpdatedEventDialog.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart' as latLng;

// final newEventCompleteProvider =
//   StateNotifierProvider<NewEventCompleteController, NewEventCompleteState>((ref) => NewEventCompleteController());

class UpdateButton extends ConsumerStatefulWidget {
  final GetUserEventsFromFriends$Query$PaginatedEventResults$EventInviteRes$Event event;
  const UpdateButton({
    required this.event,
    super.key
  });

  @override
  _UpdateButtonState createState() => _UpdateButtonState();
}

class _UpdateButtonState extends ConsumerState<UpdateButton> {

  String? name;
  String? description;
  List<UpdatePictureInput>? eventPics;
  List<UpdatePictureInput>? lightEventPics;
  DateTime? date;
  DateTime? time;
  String? datetime;
  latLng.LatLng? location;
  String? eventPlace;

  bool get canUpdate {
    return (name != null && name != widget.event.name) ||
      (description != null && description != widget.event.description) ||
      (eventPics != null) ||
      (lightEventPics != null) ||
      (datetime != null && datetime != widget.event.eventDate) ||
      (location != null && (location!.latitude != widget.event.coords.latitude && location!.longitude != widget.event.coords.longitude)) ||
      (eventPlace != null && eventPlace != widget.event.eventPlace);
  }

  @override
  void initState() {
    super.initState();
    datetime = widget.event.eventDate;
    date = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.event.eventDate));
    time = DateTime(0, 0, 0, date!.hour, date!.minute, date!.second, date!.millisecond, date!.microsecond);
  }
  
  @override
  Widget build(BuildContext context) {
    EventUpdateReadyState state = ref.watch(eventUpdateReadyControllerProvider);
    if (state is EventUpdateReadyFieldsState) {
      if (state.name != null) name = state.name;
      if (state.description != null) description = state.description;
      if (state.eventPics != null) eventPics = state.eventPics;
      if (state.lightEventPics != null) lightEventPics = state.lightEventPics;
      if (state.date != null) {
        date = state.date;
        if (time != null) {
          DateTime dateTime = DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
          datetime = dateTime.millisecondsSinceEpoch.toString();
        }
      }
      if (state.time != null) {
        time = state.time;
        if (date != null) {
          DateTime dateTime = DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
          datetime = dateTime.millisecondsSinceEpoch.toString();
        }
      };
      if (state.location != null) location = state.location;
      if (state.eventPlace != null) eventPlace = state.eventPlace;
    } else if (state is EventUpdateReadyInitState) {
      name = null;
      description = null;
      eventPics = null;
      date = null;
      time = null;
      datetime = null;
      location = null;
      eventPlace = null;
    }

    return GestureDetector(
      onTap: () {
        if (canUpdate) {
          // print(eventPics![0].file!.);
          ref.read(updateEventProvider.notifier).updateEvent(
            name,
            description,
            datetime,
            eventPics,
            lightEventPics,
            location != null ? location!.latitude : null,
            location != null ? location!.longitude : null,
            eventPlace,
            widget.event.id,
          );
          showGeneralDialog(
            context: context,
            barrierColor: Colors.transparent,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, anim1, anim2) {
              return const LoadingUpdateEventDialog(
                // text: "Creating Event...",
              );
            }
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        // margin: const EdgeInsets.only(bottom: 20),
        height: 45,
        decoration: BoxDecoration(
          color: canUpdate ? Colors.black : Colors.grey[500]!,
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
            "Update",
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