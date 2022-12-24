import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserLocationMarkerAnimation extends StatefulWidget {
  const UserLocationMarkerAnimation({super.key});

  @override
  State<UserLocationMarkerAnimation> createState() => _UserLocationMarkerAnimationState();
}

class _UserLocationMarkerAnimationState extends State<UserLocationMarkerAnimation> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  late AnimationController animController;

  late Animation<double> smallCircle;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this
    )..repeat(reverse: true);
    smallCircle = Tween(begin: 12.0, end: 16.0).animate(
      CurvedAnimation(
        parent: animController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: smallCircle.value,
            // width: ,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle
            ),
          )
        )
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}