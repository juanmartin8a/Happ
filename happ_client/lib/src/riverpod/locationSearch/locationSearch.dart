import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearchState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationSearchController extends StateNotifier<LocationSearchState> {

  LocationSearchController() : super(LocationSearchInitState());

  EventRepo eventRepo = EventRepo();

  void search(
    String search,
  ) async {
    try {
      final res = await eventRepo.searchLocation(search);
      state = LocationSearchLoadedState(error: false, predictions: res.searchLocation, search: search);
    } catch(e) {
      debugPrint("error in search location: $e");
      state = LocationSearchLoadedState(error: true, predictions: const [], search: search);
    }
  }
}

final locationSearchProvider =
  StateNotifierProvider<LocationSearchController, LocationSearchState>((ref) => LocationSearchController());