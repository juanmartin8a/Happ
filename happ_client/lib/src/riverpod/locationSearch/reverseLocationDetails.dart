import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetailsState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReverseLocationDetailsController extends StateNotifier<ReverseLocationDetailsState> {

  ReverseLocationDetailsController() : super(ReverseLocationDetailsInitState());

  EventRepo eventRepo = EventRepo();

  void markedPositionDetails(
    double latitude,
    double longitude
  ) async {
    String name = "";
    try {
      final res = await eventRepo.locationDetailsFromCoords(latitude, longitude);
      name = res.locationDetailsFromCoords;
      state = ReverseLocationDetailsLoadedState(name: name);
    } catch(e) {
      debugPrint("error in markedPositionDetails: $e");
      state = ReverseLocationDetailsLoadedState(name: name);
    }
  }
}

final reverseLocationDetailsProvider =
  StateNotifierProvider<ReverseLocationDetailsController, ReverseLocationDetailsState>((ref) => ReverseLocationDetailsController());

final updateReverseLocationDetailsProvider =
  StateNotifierProvider<ReverseLocationDetailsController, ReverseLocationDetailsState>((ref) => ReverseLocationDetailsController());