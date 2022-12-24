import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTimeState.dart';
import 'package:intl/intl.dart';

class DateAndTimeWidget extends ConsumerStatefulWidget {
  final bool isDate;
  const DateAndTimeWidget({
    required this.isDate,
    required Key key
  }) : super(key: key);

  @override
  _DateAndTimeWidgetState createState() => _DateAndTimeWidgetState();
}

class _DateAndTimeWidgetState extends ConsumerState<DateAndTimeWidget> {

  String dateOrTime = "";

  // PickDateState? dateState;
  // PickTimeState? timeState;

  @override
  Widget build(BuildContext context) {
    
    // ref.listen<PickDate>(signInProvider, ((previous, state) {}));
    if (widget.isDate) {
      final state = ref.watch(pickDateControllerProvider);
      if (state is PickDatePickedState) {
        // dateState.
        var month = DateFormat.MMM().format(state.date);
        var year = DateFormat.y().format(state.date);
        var day = DateFormat.d().format(state.date);
        
        dateOrTime = "$month $day, $year";
      }
    } else {
      final state = ref.watch(pickTimeControllerProvider);
      if (state is PickTimePickedState) {
        var time = DateFormat.Hm().format(state.time);
        dateOrTime = time;
      }
    }
    return Container(
      height: 40,
      width: (MediaQuery.of(context).size.width - 32) * 0.5,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.isDate
          ? const Icon(
            FluentIcons.calendar_ltr_12_regular,
          )
          : const Icon(
           FluentIcons.clock_12_regular,
          ),
          const SizedBox(width: 8),
          Text(
            widget.isDate 
            ? dateOrTime == "" ? "Date" : dateOrTime
            : dateOrTime == "" ? "Time" : dateOrTime,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            )
          ),
        ]
      )
    );
  }
}