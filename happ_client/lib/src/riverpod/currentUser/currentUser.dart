import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';

class CurrentUserController extends StateNotifier<UserFromId$Query$User?> {

  CurrentUserController() : super(null);

  void setCurrentUser(UserFromId$Query$User? user) async {
    state = user;
  }
}

final currentUserProvider =
  StateNotifierProvider<CurrentUserController, UserFromId$Query$User?>((ref) => CurrentUserController());