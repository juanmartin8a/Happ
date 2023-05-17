import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:http/http.dart';

class EventOptions {

  MutationOptions newEventMutationOptions(
    String name,
    String description,
    String eventDate,
    List<MultipartFile> eventPics,
    List<MultipartFile> eventPicsLight,
    double latitude,
    double longitude,
    String eventPlace,
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: NewEventMutation(
        variables: NewEventArguments(
          input: NewEventInput(
            name: name,
            description: description,
            eventPics: eventPics,
            eventPicsLight: eventPicsLight,
            eventDate: eventDate,
            latitude: latitude,
            longitude: longitude,
            eventPlace: eventPlace,
          ),
        )
      ).document,
      variables: {
        "input": {
          "name": name,
          "description": description,
          "eventPics": eventPics,
          "eventPicsLight": eventPicsLight,
          "eventDate": eventDate,
          "latitude": latitude,
          "longitude": longitude,
          "eventPlace": eventPlace,
        }
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions inviteGuestsAndOrganizersMutationOptions(
    List<int> guests,
    List<int> organizers,
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: InviteGuestsAndOrganizersMutation(
        variables: InviteGuestsAndOrganizersArguments(
          guests: guests,
          organizers: organizers,
          eventId: eventId
        )
      ).document,
      variables: {
        "guests": guests,
        "organizers": organizers,
        "eventId": eventId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  QueryOptions getUserEventsQueryOptions(
    int limit,
    List<int> idsList
  ) {
    QueryOptions mutationOptions = QueryOptions(
      document: GetUserEventsQuery(
        variables: GetUserEventsArguments(
          limit: limit,
          idsList: idsList
        )
      ).document,
      variables: {
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

   QueryOptions getUserEventsFromFriendsQueryOptions(
    int limit,
    List<int> idsList
  ) {
    QueryOptions mutationOptions = QueryOptions(
      document: GetUserEventsFromFriendsQuery(
        variables: GetUserEventsFromFriendsArguments(
          limit: limit,
          idsList: idsList
        )
      ).document,
      variables: {
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

   QueryOptions getUserOtherEventsQueryOptions(
    int limit,
    List<int> idsList
  ) {
    QueryOptions mutationOptions = QueryOptions(
      document: GetUserOtherEventsQuery(
        variables: GetUserOtherEventsArguments(
          limit: limit,
          idsList: idsList
        )
      ).document,
      variables: {
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions acceptInvitationMutationOptions(
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: AcceptInvitationMutation(
        variables: AcceptInvitationArguments(
          eventId: eventId
        )
      ).document,
      variables: {
        "eventId": eventId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  QueryOptions seePassQueryOptions(
    int eventId
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: SeePassQuery(
        variables: SeePassArguments(
          eventId: eventId
        )
      ).document,
      variables: {
        "eventId": eventId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions getEventGuestsQueryOptions(
    int eventId,
    int limit,
    List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: GetEventGuestsQuery(
        variables: GetEventGuestsArguments(
          eventId: eventId,
          limit: limit,
          idsList: idsList
        )
      ).document,
      variables: {
        "eventId": eventId,
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions getEventHostsQueryOptions(
    int eventId,
    int limit,
    List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: GetEventHostsQuery(
        variables: GetEventHostsArguments(
          eventId: eventId,
          limit: limit,
          idsList: idsList
        )
      ).document,
      variables: {
        "eventId": eventId,
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  MutationOptions updateEventMutationOptions(
    String? name,
    String? description,
    String? eventDate, 
    List<UpdatePictureInput>? eventPics,
    List<UpdatePictureInput>? eventPicsLight,
    double? latitude,
    double? longitude,
    String? eventPlace,
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: UpdateEventMutation(
        variables: UpdateEventArguments(
          input: UpdateEventInput(
            name: name,
            description: description,
            eventPics: eventPics,
            eventPicsLight: eventPicsLight,
            eventDate: eventDate,
            latitude: latitude,
            longitude: longitude,
            eventPlace: eventPlace,
          ),
          eventId: eventId
        )
      ).document,
      variables: {
        "input": {
          "name": name,
          "description": description,
          // "eventPics": eventPics,
          // "eventPicsLight": eventPicsLight,
          "eventDate": eventDate,
          "eventPics": eventPics?.map((e) => e.toJson()).toList(),
          "eventPicsLight": eventPicsLight?.map((e) => e.toJson()).toList(),
          "latitude": latitude,
          "longitude": longitude,
          "eventPlace": eventPlace,
        },
        "eventId": eventId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions deleteEventMutationOptions(
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: DeleteEventMutation(
        variables: DeleteEventArguments(
          eventId: eventId
        )
      ).document,
      variables: {
        "eventId": eventId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions removeGuests(
    List<int> userIds,
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: RemoveGuestsMutation(
        variables: RemoveGuestsArguments(
          userIds: userIds,
          eventId: eventId
        )
      ).document,
      variables: {
        "userIds": userIds,
        "eventId": eventId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions addGuests(
    List<int> userIds,
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: AddGuestsMutation(
        variables: AddGuestsArguments(
          userIds: userIds,
          eventId: eventId
        )
      ).document,
      variables: {
        "userIds": userIds,
        "eventId": eventId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions leaveEventMutationOptions(
    int eventId
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: LeaveEventMutation(
        variables: LeaveEventArguments(
          eventId: eventId
        )
      ).document,
      variables: {
        "eventId": eventId
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions scanPassMutationOptions(
    int eventId,
    String cypherText
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: ScanPassMutation(
        variables: ScanPassArguments(
          eventId: eventId,
          cypherText: cypherText,
        )
      ).document,
      variables: {
        "eventId": eventId,
        "cypherText": cypherText,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  QueryOptions searchLocationQueryOptions(
    String search
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: SearchLocationQuery(
        variables: SearchLocationArguments(
          search: search
        )
      ).document,
      variables: {
        "search": search,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions locationDetailsQueryOptions(
    String placeID
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: LocationDetailsQuery(
        variables: LocationDetailsArguments(
          placeID: placeID
        )
      ).document,
      variables: {
        "placeID": placeID,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions locationDetailsFromCoordsQueryOptions(
    double latitude,
    double longitude
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: LocationDetailsFromCoordsQuery(
        variables: LocationDetailsFromCoordsArguments(
          coords: CoordinatesInput(latitude: latitude, longitude: longitude),
        )
      ).document,
      variables: {
        "coords": {
          "latitude": latitude,
          "longitude": longitude
        },
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }
}