import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationSearchState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationSearchController extends StateNotifier<LocationSearchState> {

  LocationSearchController() : super(LocationSearchInitState());

  EventRepo eventRepo = EventRepo();

  void search(
    String search,
  ) async {
    // state = LocationSearchLoadedState();
    // Uri uri = Uri.https(
    //   "maps.googleapis.com",
    //   "maps/api/place/autocomplete/json",
    //   {
    //     "input": search,
    //     "key": placesAPIKey,
    //   }
    // );

    // final res = await NetworkUtils.fetchFromUrl(uri);

    // if (res != null) {
    //   Map<String, dynamic> data = json.decode(res);
    //   // print(data["predictions"].length);

    //   state = LocationSearchLoadedState(error: false, predictions: data["predictions"], search: search);
    // } else {
    //   state = LocationSearchLoadedState(error: true, predictions: const [], search: search);
    // }
    try {
      final res = await eventRepo.searchLocation(search);
      state = LocationSearchLoadedState(error: false, predictions: res.searchLocation, search: search);
    } catch(e) {
      state = LocationSearchLoadedState(error: true, predictions: const [], search: search);
    }
  }
}

final locationSearchProvider =
  StateNotifierProvider<LocationSearchController, LocationSearchState>((ref) => LocationSearchController());