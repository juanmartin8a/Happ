import "package:flutter/material.dart";

class SettingsTile extends StatelessWidget {
  final String name;
  final Color? textColor;
  final Icon icon;
  const SettingsTile({
    required this.name,
    this.textColor,
    required this.icon,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.grey[850],
              height: 1
            )
          )
        ],
      )
    );
  }
}