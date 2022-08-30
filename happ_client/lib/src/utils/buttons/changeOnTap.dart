import 'package:flutter/material.dart';

class CustomGestureDetector extends StatefulWidget {
  final Widget prevWidget;
  final Widget afterWidget;
  final Function onTap;
  const CustomGestureDetector({
    required this.prevWidget,
    required this.afterWidget,
    required this.onTap,
    required Key key
  }) : super(key: key);

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {

  bool onTapDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setOnTapVar(true);
      },
      onTapUp: (_) {
        setOnTapVar(false);
      },
      onTap: () {
        widget.onTap();
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: onTapDown ? widget.afterWidget : widget.prevWidget
      )
    );
  }

  void setOnTapVar(bool val) {
    setState(() {
      onTapDown = val;
    });
  }
}