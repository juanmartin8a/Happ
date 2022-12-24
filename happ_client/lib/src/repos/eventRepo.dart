import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/client/client.dart';
import 'package:happ_client/src/utils/event/eventOptions.dart';
import 'package:http/http.dart' as http;

class EventRepo {

  GraphQLClient get client => Client.client!;

  Future<NewEvent$Mutation$CreateEventResponse> newEvent(
    String name,
    String description,
    String eventDate, 
    List<http.MultipartFile> eventPics,
    double latitude,
    double longitude,
  ) async {
    final result = await client.mutate(
      EventOptions().newEventMutationOptions(name, description, eventDate, eventPics, latitude, longitude)
    );

    print(result);

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return NewEvent$Mutation$CreateEventResponse.fromJson(
        (result.data as Map<String, dynamic>)["newEvent"]
      );
    }
  }
}