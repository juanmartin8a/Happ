import 'dart:convert';

import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetailsState.dart';
import 'package:happ_client/src/utils/network/networkUtils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/utils/constants.dart';

class ReverseLocationDetailsController extends StateNotifier<ReverseLocationDetailsState> {

  ReverseLocationDetailsController() : super(ReverseLocationDetailsInitState());

  void markedPositionDetails(
    double latitude,
    double longitude
  ) async {
    String name = "";
    Uri uri = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$placesAPIKey"
    );

    final res = await NetworkUtils.fetchFromUrl(uri);

    Map<String, dynamic> data = json.decode(res!);

    for (int i = 0; i < data["results"].length; i++) {
      bool hasPlusCode = (data["results"][i]["address_components"][0]["types"] as List<dynamic>).contains("plus_code") ;
      if (!hasPlusCode) {
        name = data["results"][i]["formatted_address"];
        break ;
      }
    }

    state = ReverseLocationDetailsLoadedState(name: name);
  }
}

final reverseLocationDetailsProvider =
  StateNotifierProvider<ReverseLocationDetailsController, ReverseLocationDetailsState>((ref) => ReverseLocationDetailsController());

final updateReverseLocationDetailsProvider =
  StateNotifierProvider<ReverseLocationDetailsController, ReverseLocationDetailsState>((ref) => ReverseLocationDetailsController());