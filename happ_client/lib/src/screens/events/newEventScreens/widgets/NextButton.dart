import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventCompleteState.dart';
import 'package:flutter/material.dart';
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
  DateTime? date;
  DateTime? time;
  latLng.LatLng? location;
  
  
  @override
  Widget build(BuildContext context) {
    NewEventCompleteState state = ref.watch(newEventCompleteProvider);
    if (state is NewEventCompleteFieldsState) {
      if (state.name != null) name = state.name;
      if (state.description != null) description = state.description;
      if (state.eventPics != null) eventPics = state.eventPics;
      if (state.date != null) date = state.date;
      if (state.time != null) time = state.time;
      if (state.location != null) location = state.location;
    }

    Color buttonColor;
    String text;

    if (widget.page == 0) {
      buttonColor = (name != null && description != null && eventPics != null) ? Colors.black : Colors.grey[500]!;
      text = "Next";
    } else if (widget.page == 1) {
      buttonColor = (date != null && time != null && location != null) ? Colors.black : Colors.grey[500]!;
      text = "Create Event";
    } else {
      buttonColor = Colors.black;
      text = "Invite";
    }
    

    return GestureDetector(
      onTap: () {
        if (widget.page == 0) {
          if (name != null && description != null && eventPics != null) {
            widget.animateToPage(1);
          }
        } else if (widget.page == 1) {
          if (date == true && time == true && location == true) {
            print(date);
            print(time);
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin: const EdgeInsets.only(bottom: 20),
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
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1
            )
          ),
        )
      ),
    );
  }
}