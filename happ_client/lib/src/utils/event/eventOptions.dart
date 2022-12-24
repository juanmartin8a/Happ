import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:http/http.dart';

class EventOptions {

  MutationOptions newEventMutationOptions(
    String name,
    String description,
    String eventDate, 
    List<MultipartFile> eventPics,
    double latitude,
    double longitude,
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: NewEventMutation(
        variables: NewEventArguments(
          input: NewEventInput(
            name: name,
            description: description,
            eventPics: eventPics,
            eventDate: eventDate,
            latitude: latitude,
            longitude: longitude
          ),
        )
      ).document,
      variables: {
        "input": {
          "name": name,
          "description": description,
          "eventPics": eventPics,
          "eventDate": eventDate,
          "latitude": latitude,
          "longitude": longitude
        }
      },
      fetchPolicy: FetchPolicy.networkOnly
    );

    return mutationOptions;
  }
}