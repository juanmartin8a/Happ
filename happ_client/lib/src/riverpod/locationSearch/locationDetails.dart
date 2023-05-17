import 'package:flutter/foundation.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationDetailsController extends StateNotifier<LocationDetailsState> {

  LocationDetailsController() : super(LocationDetailsInitState());

  EventRepo eventRepo = EventRepo();

  void getPlaceDetails(
    String id,
    String name
  ) async {
    try {
      final res = await eventRepo.locationDetails(id);
      state = LocationDetailsLoadedState(error: false, details: res.locationDetails, name: name);
    } catch(e) {
      debugPrint("error in getPlaceDetails: $e");
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