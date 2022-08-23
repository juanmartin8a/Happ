import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double radius;
  const Loader({
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.radius = 10,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Center(
        child: Theme(
          data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark)),
          child: CupertinoActivityIndicator(
            radius: radius,
          )
        )
      )
    );
  }
}