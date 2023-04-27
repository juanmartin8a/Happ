import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';

class InviteUserSelectController extends StateNotifier<InviteUserSelectState> {

  InviteUserSelectController() : super(InviteUserSelectInitState());

  void inviteSelect(SearchUsers$Query$User user, bool isAdded) async {
    if (isAdded) {
      state = InviteUserSelectedState(user: user);
    } else {
      state = InviteUserRemoveState(userId: user.id);
    }
  }

  void makeRemoveOrganizer(SearchUsers$Query$User user, bool isMake) async {
    if (isMake) {
      state = MakeOrganizerState(user: user);
    } else {
      state = RemoveOrganizerState(user: user);
    }
  }
}

final inviteUserSelectProvider =
  StateNotifierProvider<InviteUserSelectController, InviteUserSelectState>(
    (ref) => InviteUserSelectController()
  );

// final inviteUserSelectProvider =
//   StateNotifierProvider.family<InviteUserSelectController, InviteUserSelectState, String>(
//     (ref, key) => InviteUserSelectController()
//   );