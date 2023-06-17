import 'package:flutter/foundation.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/profile/addedMe/addedMeState.dart';

class AddedMe extends StateNotifier<AddedMeState> {

  AddedMe() : super(AddedMeInitState());

  UserRepo get userRepo => UserRepo();

  void addedMe(
    int limit, 
    List<int> idsList
  ) async {
    state = AddedMeLoadingState();
    try {
      final res = await userRepo.addedMe(limit, idsList);
      state = AddedMeLoadedState(val: res.addedMe);
    } catch (e) {
      debugPrint("error in addedMe: $e");
    }
  }

  void updateAddedMeList(List<AddedMe$Query$PaginatedEventUsersResults$User> users, bool hasMore, int userToChange, Map<String, dynamic> changeMap) async {

    final usersToJson = users.map((user) {
      return user.toJson();
    }).toList();

    int listIndex = users.indexWhere((user) => user.id.toInt() == userToChange);

    Map<String, dynamic> userToChangeJson = users[listIndex].toJson();

    for (int i = 0; i < changeMap.length; i++) {
      userToChangeJson[changeMap.keys.toList()[i]] = changeMap.values.toList()[i];
    }

    usersToJson[listIndex] = userToChangeJson;

    Map<String, dynamic> newResJson = {
      "users": usersToJson,
      "hasMore": hasMore
    };

    final newRes = AddedMe$Query$PaginatedEventUsersResults.fromJson(newResJson);

    state = AddedMeLoadedState(val: newRes, isUpdate: true);
  }
}

final profileAddedMeProvider =
  StateNotifierProvider.family<AddedMe, AddedMeState, String>(
    (ref, key) => AddedMe()
  );