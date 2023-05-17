import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/pickDateAndTime/pickDateAndTime.dart';

class UpdateDatetimePicker extends ConsumerWidget {
  final bool isDate;
  final DateTime datetime;
  const UpdateDatetimePicker({
    required this.isDate,
    required this.datetime,
    required Key key
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width * 0.8;
    DateTime? dateOrTime;
    if (isDate == true) {
      dateOrTime = datetime;
    } else {
      dateOrTime = DateTime(0, 0, 0, datetime.hour, datetime.minute, datetime.second, datetime.millisecond, datetime.microsecond);
    }
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
                    color: Colors.black,
                    width: width,
                    height: (MediaQuery.of(context).size.width * 0.8) * 0.8,
                    child: Column(
                      children: [
                        Expanded(
                          child: CupertinoTheme(
                            data: const CupertinoThemeData(
                              brightness: Brightness.dark,
                            ),
                            child: CupertinoDatePicker(
                              // padding: EdgeInsets.zero,
                              mode: isDate ? CupertinoDatePickerMode.date : CupertinoDatePickerMode.time,
                              minimumDate: isDate ? DateTime.now() : null,
                              // dateOrder: DatePickerDateOrder.dmy,
                              initialDateTime: dateOrTime,
                              // maximumYear: 2,
                              onDateTimeChanged: (date) {
                                dateOrTime = date;
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (dateOrTime != null) {
                      if (isDate) {
                        ref.read(updatePickDateControllerProvider.notifier).pickDate(dateOrTime!);
                        ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
                          date: dateOrTime
                        );
                      } else {
                        ref.read(updatePickTimeControllerProvider.notifier).pickTime(dateOrTime!);
                        ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
                          time: dateOrTime
                        );
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: width,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
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