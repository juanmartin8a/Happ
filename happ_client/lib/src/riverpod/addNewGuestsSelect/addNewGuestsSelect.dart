import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/addNewGuestsSelectState.dart';

class AddNewGuestsSelectController extends StateNotifier<AddNewGuestsSelect> {

  AddNewGuestsSelectController() : super(AddNewGuestsInitState());

  void inviteSelect(SearchForUsersToAddToEvent$Query$User user, bool isAdd) async {
    if (isAdd) {
      state = AddNewGuestsSelectedState(user: user);
    } else {
      state = AddNewGuestsRemoveState(userId: user.id);
    }
  }
}

final addNewGuestsSelectProvider =
  StateNotifierProvider<AddNewGuestsSelectController, AddNewGuestsSelect>(
    (ref) => AddNewGuestsSelectController()
  );

// final inviteUserSelectProvider =
//   StateNotifierProvider.family<AddNewGuestsSelect, InviteUserSelectState, String>(
//     (ref, key) => InviteUserSelectController()
//   );