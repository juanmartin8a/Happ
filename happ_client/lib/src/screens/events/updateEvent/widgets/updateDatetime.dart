import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTimeState.dart';
import 'package:happ_client/src/utils/widgets/datetimeField.dart';
import 'package:intl/intl.dart';

class UpdateDatetime extends ConsumerStatefulWidget {
  final bool isDate;
  final DateTime dateTime;
  const UpdateDatetime({
    required this.isDate,
    required this.dateTime,
    required Key key
  }) : super(key: key);

  @override
  _UpdateDatetimeState createState() => _UpdateDatetimeState();
}

class _UpdateDatetimeState extends ConsumerState<UpdateDatetime> {

  String dateOrTime = "";
  

  @override
  void initState() {
    super.initState();
    if (widget.isDate) {
      var month = DateFormat.MMM().format(widget.dateTime);
      var year = DateFormat.y().format(widget.dateTime);
      var day = DateFormat.d().format(widget.dateTime);
          
      setState(() {  
        dateOrTime = "$month $day, $year";
      });
    } else {
      var time = DateFormat.Hm().format(widget.dateTime);
      dateOrTime = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    if (widget.isDate) {
      final state = ref.watch(updatePickDateControllerProvider);
      if (state is PickDatePickedState) { // Output: Mar
        var month = DateFormat.MMM().format(state.date);
        var year = DateFormat.y().format(state.date);
        var day = DateFormat.d().format(state.date);
        
        dateOrTime = "$month $day, $year";
        // print(dateOrTime);
      }
    } else {
      final state = ref.watch(updatePickTimeControllerProvider);
      if (state is PickTimePickedState) {
        var time = DateFormat.Hm().format(state.time);
        dateOrTime = time;
      }
    }
    return DatetimeField(isDate: widget.isDate, dateOrTime: dateOrTime);
  }
}