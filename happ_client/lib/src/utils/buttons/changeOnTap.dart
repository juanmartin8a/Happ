import 'dart:async';
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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!isLoading) {
          isLoading = true;
          setOnTapVar(true);
        }
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          isLoading = false;
          setOnTapVar(false);
        });
      },
      onTap: () {
        widget.onTap();
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          isLoading = false;
          setOnTapVar(false);
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        child: onTapDown ? widget.afterWidget : widget.prevWidget
      )
    );
  }

  void setOnTapVar(bool val) {
    if (mounted) {
      setState(() {
        onTapDown = val;
      });
    }
  }
}