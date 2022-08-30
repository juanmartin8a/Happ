import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';

class SearchController extends StateNotifier<SearchState> {

  SearchController() : super(SearchInitState());

  UserRepo get userRepo => UserRepo();

  void searchUsers(String search) async {
    // state = ProfileLoadingState();
    try {
      final res = await userRepo.searchUsers(search);
      // print(res);
      state = SearchLoadedState(searchUsersRes: res.searchUsers);
    } catch (e) {
      print(e);
      state = SearchErrorState();
    }
  }
}

final searchProvider =
  StateNotifierProvider<SearchController, SearchState>(
    (ref) => SearchController()
  );