import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddRemoveUserController extends StateNotifier<AddRemoveState> {

  AddRemoveUserController() : super(AddRemoveInitState());

  UserRepo get userRepo => UserRepo();

  void addOrRemoveUser(int followUserId, bool isFollow) async {
    // state = ProfileLoadingState();
    String newOperationId = const Uuid().v4();
    try {
      if (isFollow) {
        state = AddRemoveAddState(
          res: AddOrRemoveUser$Mutation$AddResponse.fromJson({
            "value": 1,
            "unchanged": false,
          }),
          operationId: newOperationId,
        );
      } else {
        state = AddRemoveRemoveState(
          res: AddOrRemoveUser$Mutation$AddResponse.fromJson({
            "value": -1,
            "unchanged": false,
          }),
          operationId: newOperationId,
        );
      }
      // return to see if unchaged is == true
      final res = await userRepo.addOrRemoveUser(followUserId, isFollow);
      // print(res);
      if (res.value == 1) {
        state = AddRemoveAddState(res: res, operationId: newOperationId,);
      } else if (res.value == -1) {
        state = AddRemoveRemoveState(res: res, operationId: newOperationId,);
      } else if (res.value == 0) {
        if (isFollow) {
          state = AddRemoveAddState(
            res: AddOrRemoveUser$Mutation$AddResponse.fromJson({
              "value": -1,
              "unchanged": false,
            }),
            operationId: newOperationId,
          );
        } else {
          state = AddRemoveRemoveState(
            res: AddOrRemoveUser$Mutation$AddResponse.fromJson({
              "value": 1,
              "unchanged": false,
            }),
            operationId: newOperationId,
          );
        }
      }
    } catch (e) {
      print("errror :(");
      print(e);
    }
  }
}

final addOrRemoveUserProvider =
  StateNotifierProvider.family<AddRemoveUserController, AddRemoveState, String>(
    (ref, key) => AddRemoveUserController()
  );