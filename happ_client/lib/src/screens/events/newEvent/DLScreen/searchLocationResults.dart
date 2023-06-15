import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearch.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearchState.dart';
import 'package:happ_client/src/screens/events/newEvent/DLScreen/searchLocationTile.dart';

class SearchLocationResults extends ConsumerWidget {
  final bool isNew;
  const SearchLocationResults({
    this.isNew = true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    LocationSearchState searchLocationState = ref.watch(locationSearchProvider);
    if (searchLocationState is !LocationSearchLoadedState) {
      return const SizedBox();
    }
    
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: searchLocationState.predictions.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          if (searchLocationState.predictions.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                "Results ;)",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 150),
              color: Colors.transparent,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Sorry, could not find any locations :c\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  children: <TextSpan>[
                    if (Platform.isIOS) const TextSpan(text: '🤥💀', style: TextStyle(fontSize: 20))
                  ]
                )
              )
            );
          }
        }
        int searchResIndex = i - 1;
        return SearchLocationTile(tile: searchLocationState.predictions[searchResIndex], isNew: isNew);
      }
    );
  }
}