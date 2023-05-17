import 'package:flutter/foundation.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';

class SearchController extends StateNotifier<SearchState> {

  final UserFromId$Query$User currentUser;

  SearchController({required this.currentUser}) : super(SearchInitState());

  UserRepo get userRepo => UserRepo();

  void searchUsers(String search) async {
    // state = ProfileLoadingState();
    try {
      final res = await userRepo.searchUsers(search, currentUser.id);
      state = SearchLoadedState(searchUsersRes: res.searchUsers);
    } catch (e) {
      debugPrint("error in searchUsers: $e");
      state = SearchErrorState();
    }
  }

  void updateUserSearchTileState(List<SearchUsers$Query$User> searchRes, int userToChange, Map<String, dynamic> changeMap) async {

    int listIndex = searchRes.indexWhere((user) => user.id.toInt() == userToChange);

    Map<String, dynamic> searchResJson = searchRes[listIndex].toJson();

    for (int i = 0; i < changeMap.length; i++) {
      searchResJson[changeMap.keys.toList()[i]] = changeMap.values.toList()[i];
    }

    searchRes[listIndex] = SearchUsers$Query$User.fromJson(searchResJson);

    state = SearchLoadedState(searchUsersRes: searchRes);
  }
  
  void backToInit() {
    state = SearchInitState();
  }
}