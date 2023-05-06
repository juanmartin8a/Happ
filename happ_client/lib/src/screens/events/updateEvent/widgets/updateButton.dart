import 'package:another_flushbar/flushbar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventUpdatePictureActions/pictureActions.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReadyState.dart';
import 'package:flutter/material.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearch.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEvent.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEventState.dart';
import 'package:happ_client/src/riverpod/updatePictures/updatePictures.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
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

  bool isLoading = false;

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

    ref.listen(updateEventProvider, (prev, next) {
      if (next is UpdateEventLoadingState) {
        setState(() {
          isLoading = true;
        });
      } else if (next is UpdateEventDoneState) {
        setState(() {
          isLoading = false;
        });
        if (next.updateEventRes.errors == null) {
          ref.invalidate(locationSearchProvider);
          ref.invalidate(updatePickDateControllerProvider);
          ref.invalidate(updatePickTimeControllerProvider);
          ref.invalidate(updateLocationDetailsProvider);
          ref.invalidate(updateReverseLocationDetailsProvider);
          ref.invalidate(eventUpdateReadyControllerProvider);
          ref.invalidate(picturesActionsProvider);
          ref.invalidate(updatePicturesProvider);
          Navigator.pop(context);
        } else {
          showFlushbar();
        }
      } else if (next is UpdateEventErrorState) {
        setState(() {
          isLoading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showFlushbar();
        });
      }
    });

    return GestureDetector(
      onTap: () {
        if (canUpdate && ref.read(updateEventProvider) is !UpdateEventLoadingState) {
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
        child: Center(
          child: isLoading
          ? const Loader(radius: 8, brightness: Brightness.dark)
          : const Text(
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

  void showFlushbar() {
    Flushbar(
      backgroundColor: Colors.red,
      positionOffset: 0.0,
      borderRadius: BorderRadius.circular(16),
      boxShadows: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 6.0, spreadRadius: 4)],
      messageText: SizedBox(
        height: 50,
        child: Row(
          children: [
            const Icon(
              FluentIcons.error_circle_16_regular,
              size: 32.0,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: "Error while updating event ",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '😫', style: TextStyle(fontSize: 18)),
                  ]
                )
              ),
            ),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      shouldIconPulse: false,
      duration: const Duration(seconds: 6),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      isDismissible: true,
    ).show(context);
  }
}