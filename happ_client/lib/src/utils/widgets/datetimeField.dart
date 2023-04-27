import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class DatetimeField extends StatelessWidget {
  final bool isDate;
  final String dateOrTime;
  const DatetimeField({
    required this.isDate,
    required this.dateOrTime,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: (MediaQuery.of(context).size.width - 36) * 0.5,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isDate
          ? const Icon(
            FluentIcons.calendar_ltr_12_regular,
          )
          : const Icon(
           FluentIcons.clock_12_regular,
          ),
          const SizedBox(width: 8),
          Text(
            isDate 
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