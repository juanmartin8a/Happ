import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/profile/profileState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileController extends StateNotifier<ProfileState> {

  ProfileController() : super(ProfileInitState());

  UserRepo get userRepo => UserRepo();

  void getUser(int userId) async {
    state = ProfileLoadingState();
    try {
      final res = await userRepo.getUser(userId);
      state = ProfileLoadedState(user: res);
    } catch (e) {
      print(e);
      state = ProfileErrorState();
    }
  }
}

final profileProvider =
  StateNotifierProvider.family<ProfileController, ProfileState, String>(
    (ref, key) => ProfileController()
  );