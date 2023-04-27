import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:happ_client/src/repos/eventRepo.dart';
import 'package:happ_client/src/riverpod/updateEvent/updateEventState.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateEventContoller extends StateNotifier<UpdateEventState> {

  UpdateEventContoller() : super(UpdateEventInitState());

  EventRepo get eventRepo => EventRepo();

  UserAccessController get userAccess => UserAccessController();

  void updateEvent(
    String? name,
    String? description,
    String? eventDate, 
    List<UpdatePictureInput>? eventPics,
    List<UpdatePictureInput>? eventPicsLight,
    double? latitude,
    double? longitude,
    String? eventPlace,
    int eventId
  ) async {
    state = UpdateEventLoadingState();
    try {
      final res = await eventRepo.updateEvent(name, description, eventDate, eventPics, eventPicsLight, latitude, longitude, eventPlace, eventId);
      state = UpdateEventDoneState(updateEventRes: res);
    } catch (e) {
      print(e);
      state = UpdateEventErrorState();
    }
  }
}

final updateEventProvider =
  StateNotifierProvider<UpdateEventContoller, UpdateEventState>((ref) => UpdateEventContoller());