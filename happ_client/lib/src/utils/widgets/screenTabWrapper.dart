import 'package:flutter/material.dart';

class ScreenTabWrapper extends StatelessWidget {
  final Widget child;
  const ScreenTabWrapper({
    required this.child,
    required Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}