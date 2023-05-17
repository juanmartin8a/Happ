import 'package:flutter/foundation.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddAsGuestsState.dart';

class SearchForUsersToAddAsGuestsController extends StateNotifier<SearchForUsersToAddAsGuestsState> {

  SearchForUsersToAddAsGuestsController() : super(SearchForUsersToAddAsGuestsInitState());

  UserRepo get userRepo => UserRepo();

  void searchUsers(String search, int eventId) async {
    try {
      final res = await userRepo.searchUsersToAddAsGuests(search, eventId);
      state = SearchForUsersToAddAsGuestsLoadedState(searchUsersRes: res.searchForUsersToAddAsGuests);
    } catch (e) {
      debugPrint("error in searchUsersToAddAsGuests: $e");
      state = SearchForUsersToAddAsGuestsErrorState();
    }
  }

  void backToInit() {
    state = SearchForUsersToAddAsGuestsInitState();
  }
}