import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';
import 'package:intl/intl.dart';

// class DateTimePicker extends StatefulWidget {
//   final bool isDate;
//   const DateTimePicker({
//     required this.isDate,
//     required Key key
//   }) : super(key: key);

//   @override
//   State<DateTimePicker> createState() => _DateTimePickerState();
// }

// class _DateTimePickerState extends State<DateTimePicker> {
class DateTimePicker extends ConsumerWidget {
  final bool isDate;
  const DateTimePicker({
    required this.isDate,
    required Key key
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width * 0.8;
    DateTime? dateOrTime;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black26)
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.white,
                    width: width,
                    height: (MediaQuery.of(context).size.width * 0.8) * 0.8,
                    child: Column(
                      children: [
                        Expanded(
                          child: CupertinoDatePicker(
                            // padding: EdgeInsets.zero,
                            mode: isDate ? CupertinoDatePickerMode.date : CupertinoDatePickerMode.time,
                            minimumDate: DateTime(0),
                            // dateOrder: DatePickerDateOrder.dmy,
                            initialDateTime: isDate ? DateTime.now() : DateTime(0),
                            // maximumYear: 2,
                            onDateTimeChanged: (date) {
                              // print(date);
                              // var month = DateFormat.MMMM().format(date);
                              // print(month);
                              // var year = DateFormat.y().format(date);
                              // print(year);
                              // var day = DateFormat.d().format(date);
                              // print(day);
                              // var time = DateFormat.Hm().format(date);
                              // print(time);
                              // var month = DateFormat.MMMM().format(date);
                              dateOrTime = date;
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (dateOrTime != null) {
                      if (isDate) {
                        ref.read(pickDateControllerProvider.notifier).pickDate(dateOrTime!);
                        ref.read(newEventCompleteProvider.notifier).fieldChange(
                          date: dateOrTime
                        );
                      } else {
                        ref.read(pickTimeControllerProvider.notifier).pickTime(dateOrTime!);
                        ref.read(newEventCompleteProvider.notifier).fieldChange(
                          time: dateOrTime
                        );
                      }
                    }
                  },
                  child: Container(
                    width: width,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.grey[800]!,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 1
                        )
                      ),
                    ),
                    
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}