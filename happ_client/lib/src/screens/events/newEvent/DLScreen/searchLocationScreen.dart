import 'package:flutter/material.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/searchLocationBar.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/searchLocationResults.dart';

class SearchLocation extends StatelessWidget {
  final bool isNew;
  const SearchLocation({
    Key? key,
    this.isNew = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white.withOpacity(1.0),
        child: Column(
          children: [
            SizedBox(height: statusBar),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const SearchLocationBar()
            ),
            Expanded(
              child: SearchLocationResults(isNew: isNew)
            )
          ],
        )
      )
    );
  }
}