import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddToEventState.dart';

class SearchForUsersToAddToEventController extends StateNotifier<SearchForUsersToAddToEventState> {

  SearchForUsersToAddToEventController() : super(SearchForUsersToAddToEventInitState());

  UserRepo get userRepo => UserRepo();

  void searchUsers(String search, int eventId) async {
    try {
      final res = await userRepo.searchForUsersToAddToEvent(search, eventId);
      state = SearchForUsersToAddToEventLoadedState(searchUsersRes: res.searchForUsersToAddToEvent);
    } catch (e) {
      debugPrint("error in searchUsersToAddToEvent: $e");
      state = SearchForUsersToAddToEventErrorState();
    }
  }

  void backToInit() {
    state = SearchForUsersToAddToEventInitState();
  }
}