import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddAsGuestsState.dart';

class SearchForUsersToAddAsGuestsController extends StateNotifier<SearchForUsersToAddAsGuestsState> {

  SearchForUsersToAddAsGuestsController() : super(SearchForUsersToAddAsGuestsInitState());

  UserRepo get userRepo => UserRepo();

  // ADD userSearching here
  void searchUsers(String search, int eventId) async {
    // state = ProfileLoadingState();
    try {
      final res = await userRepo.searchUsersToAddAsGuests(search, eventId);
      // print(res);
      state = SearchForUsersToAddAsGuestsLoadedState(searchUsersRes: res.searchForUsersToAddAsGuests);
    } catch (e) {
      print(e);
      state = SearchForUsersToAddAsGuestsErrorState();
    }
  }

  void backToInit() {
    state = SearchForUsersToAddAsGuestsInitState();
  }
}