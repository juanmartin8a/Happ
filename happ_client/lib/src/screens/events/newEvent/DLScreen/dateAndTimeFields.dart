import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTimeState.dart';
import 'package:happ_client/src/utils/widgets/datetimeField.dart';
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

  @override
  Widget build(BuildContext context) {
    
    if (widget.isDate) {
      final state = ref.watch(pickDateControllerProvider);
      if (state is PickDatePickedState) {
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
    return DatetimeField(isDate: widget.isDate, dateOrTime: dateOrTime);
  }
}