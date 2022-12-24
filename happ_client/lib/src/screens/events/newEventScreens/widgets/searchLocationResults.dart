import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearch.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearchState.dart';
import 'package:happ_client/src/screens/events/newEventScreens/widgets/searchLocationTile.dart';

class SearchLocationResults extends ConsumerWidget {
  const SearchLocationResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    LocationSearchState searchLocationState = ref.watch(locationSearchProvider);
    if (searchLocationState is !LocationSearchLoadedState) {
      return const SizedBox();
    }
    // print(searchLocationState.predictions);
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
                  fontSize: 15,
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
                  text: "Sorry, could not find any locations ;(\n",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: '🤥💀', style: TextStyle(fontSize: 28))
                  ]
                )
              )
            );
          }
        }
        int searchResIndex = i - 1;
        return SearchLocationTile(tile: searchLocationState.predictions[searchResIndex]);
      }
    );
  }
}