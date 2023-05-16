import 'dart:convert';

import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/utils/network/networkUtils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/utils/constants.dart';

class LocationDetailsController extends StateNotifier<LocationDetailsState> {

  LocationDetailsController() : super(LocationDetailsInitState());

  EventRepo eventRepo = EventRepo();

  void getPlaceDetails(
    String id,
    String name
  ) async {

    // Uri uri = Uri.https(
    //   "maps.googleapis.com",
    //   "maps/api/geocode/json",
    //   {
    //     "place_id": id,
    //     "key": placesAPIKey,
    //   }
    // );

    // final res = await NetworkUtils.fetchFromUrl(uri);

    // if (res != null) {
    //   Map<String, dynamic> data = json.decode(res);

    //   state = LocationDetailsLoadedState(error: false, details: data, name: name);

    //   return data;
    // } else {
    //   state = LocationDetailsLoadedState(error: true, details: const {}, name: name);
    //   return null;
    // }
    try {
      final res = await eventRepo.locationDetails(id);
      state = LocationDetailsLoadedState(error: false, details: res.locationDetails, name: name);
    } catch(e) {
      state = LocationDetailsLoadedState(error: true, details: null, name: name);
    }
  }

  void moveToCurrentPosition(
    double latitude,
    double longitude
  ) async {

    Map<String, dynamic> detailsJSON = {
      "latitude": latitude,
      "longitude": longitude
    };

    final details = LocationDetails$Query$EventCoordinates.fromJson(detailsJSON);

    state = LocationDetailsLoadedState(error: false, details: details);
  }

  void markPosition(
    double latitude,
    double longitude
  ) async {

    Map<String, dynamic> details = {
      "lat": latitude,
      "lng": longitude
    };

    state = MarkLocationLoadedState(details: details);
  }
}

final locationDetailsProvider =
  StateNotifierProvider<LocationDetailsController, LocationDetailsState>((ref) => LocationDetailsController());

final updateLocationDetailsProvider =
  StateNotifierProvider<LocationDetailsController, LocationDetailsState>((ref) => LocationDetailsController());