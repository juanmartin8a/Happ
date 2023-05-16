import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/utils/buttons/customGestureDetector.dart';

class SearchLocationTile extends ConsumerWidget {
  final SearchLocation$Query$LocationAutoCompletePrediction tile;
  final bool isNew;
  const SearchLocationTile({
    required this.tile,
    this.isNew = true,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget widget = Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox(
            width: 30,
            // color: Colors.grey[200],
            child: Icon(
              FluentIcons.location_16_filled,
              size: 26,
              color: Colors.grey[850]
            )
          )
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tile.description,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  // color: Colors.white,
                ),
              ],
            )
          ),
        ),
      ],
    );
    return BackgroundChangeOnTapGestureDetector(
      onTap: () async {        
        ref.read(
          isNew 
          ? locationDetailsProvider.notifier
          : updateLocationDetailsProvider.notifier
        ).getPlaceDetails(tile.placeId, tile.description);
        Navigator.pop(context);
      },
      key: Key("place_id_${tile.placeId}"),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        // padding: EdgeInsets.zero,
        child: widget,
      )
    );
  }
}