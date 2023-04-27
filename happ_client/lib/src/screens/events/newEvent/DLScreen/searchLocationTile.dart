import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/utils/buttons/changeOnTap.dart';

class SearchLocationTile extends ConsumerWidget {
  final dynamic tile;
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
              color: Colors.grey[900]
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
                  tile["description"],
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 15,
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
    return CustomGestureDetector(
      onTap: () async {        
        ref.read(
          isNew 
          ? locationDetailsProvider.notifier
          : updateLocationDetailsProvider.notifier
        ).getPlaceDetails(tile["place_id"], tile["description"]);
        Navigator.pop(context);
      },
      prevWidget: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: Colors.transparent,
        child: widget
      ),
      afterWidget: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: Colors.grey[200],
        child: widget
      ),
      key: Key("place_id_${tile["place_id"]}")
    );
  }
}