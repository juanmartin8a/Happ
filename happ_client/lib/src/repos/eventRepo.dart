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
    List<http.MultipartFile> eventPicsLight,
    double latitude,
    double longitude,
    String eventPlace,
  ) async {
    final result = await client.mutate(
      EventOptions().newEventMutationOptions(name, description, eventDate, eventPics, eventPicsLight, latitude, longitude, eventPlace)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return NewEvent$Mutation$CreateEventResponse.fromJson(
        (result.data as Map<String, dynamic>)["newEvent"]
      );
    }
  }

  Future<InviteGuestsAndOrganizers$Mutation> inviteGuestsAndOrganizers(
    List<int> guests,
    List<int> organizers,
    int eventId
  ) async {
    final result = await client.mutate(
      EventOptions().inviteGuestsAndOrganizersMutationOptions(guests, organizers, eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return InviteGuestsAndOrganizers$Mutation.fromJson(
        result.data!
      );
    }
  }

  Future<GetUserEvents$Query$PaginatedEventResults> getEvents(
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      EventOptions().getUserEventsQueryOptions(limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return GetUserEvents$Query$PaginatedEventResults.fromJson(
        (result.data as Map<String, dynamic>)["getUserEvents"]
      );
    }
  }

  Future<GetUserEventsFromFriends$Query$PaginatedEventResults> getEventsFromFriends(
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      EventOptions().getUserEventsFromFriendsQueryOptions(limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return GetUserEventsFromFriends$Query$PaginatedEventResults.fromJson(
        (result.data as Map<String, dynamic>)["getUserEventsFromFriends"]
      );
    }
  }

  Future<GetUserOtherEvents$Query$PaginatedEventResults> getOtherEvents(
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      EventOptions().getUserOtherEventsQueryOptions(limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return GetUserOtherEvents$Query$PaginatedEventResults.fromJson(
        (result.data as Map<String, dynamic>)["getUserOtherEvents"]
      );
    }
  }

  Future<AcceptInvitation$Mutation$AcceptInvitationResponse> acceptInvitation(
    int eventId
  ) async {
    final result = await client.mutate(
      EventOptions().acceptInvitationMutationOptions(eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AcceptInvitation$Mutation$AcceptInvitationResponse.fromJson(
        (result.data as Map<String, dynamic>)["acceptInvitation"]
      );
    }
  }

  Future<SeePass$Query> seePass(
    int eventId
  ) async {
    final result = await client.query(
      EventOptions().seePassQueryOptions(eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SeePass$Query.fromJson(
        result.data!
      );
    }
  }

  Future<GetEventGuests$Query$PaginatedEventUsersResults> getEventGuests(
    int eventId,
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      EventOptions().getEventGuestsQueryOptions(eventId, limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return GetEventGuests$Query$PaginatedEventUsersResults.fromJson(
        (result.data as Map<String, dynamic>)["getEventGuests"]
      );
    }
  }

  Future<GetEventHosts$Query$PaginatedEventUsersResults> getEventHosts(
    int eventId,
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      EventOptions().getEventHostsQueryOptions(eventId, limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return GetEventHosts$Query$PaginatedEventUsersResults.fromJson(
        (result.data as Map<String, dynamic>)["getEventHosts"]
      );
    }
  }

  Future<UpdateEvent$Mutation$CreateEventResponse> updateEvent(
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
    final result = await client.mutate(
      EventOptions().updateEventMutationOptions(name, description, eventDate, eventPics, eventPicsLight, latitude, longitude, eventPlace, eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return UpdateEvent$Mutation$CreateEventResponse.fromJson(
        (result.data as Map<String, dynamic>)["updateEvent"]
      );
    }
  }

  Future<DeleteEvent$Mutation> deleteEvent(
    int eventId
  ) async {
    final result = await client.mutate(
      EventOptions().deleteEventMutationOptions(eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return DeleteEvent$Mutation.fromJson(
        result.data!
      );
    }
  }

  Future<RemoveGuests$Mutation> removeGuests(
    List<int> guests,
    List<int> hosts,
    int eventId
  ) async {
    final result = await client.mutate(
      EventOptions().removeGuests(guests, hosts, eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return RemoveGuests$Mutation.fromJson(
        result.data!
      );
    }
  }

  // Future<AddGuests$Mutation> addGuests(
  //   List<int> userIds,
  //   int eventId
  // ) async {
  //   final result = await client.mutate(
  //     EventOptions().addGuests(userIds, eventId)
  //   );

  //   if (result.hasException) {
  //     throw (result.exception as OperationException);
  //   } else {
  //     return AddGuests$Mutation.fromJson(
  //       result.data!
  //     );
  //   }
  // }

  Future<LeaveEvent$Mutation> leaveEvent(
    int eventId
  ) async {
    final result = await client.mutate(
      EventOptions().leaveEventMutationOptions(eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return LeaveEvent$Mutation.fromJson(
        result.data!
      );
    }
  }

  Future<ScanPass$Mutation> scanPass(
    int eventId,
    String cypherText
  ) async {
    final result = await client.mutate(
      EventOptions().scanPassMutationOptions(eventId, cypherText)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return ScanPass$Mutation.fromJson(
        result.data!,
      );
    }
  }

  Future<SearchLocation$Query> searchLocation(
    String search
  ) async {
    final result = await client.query(
      EventOptions().searchLocationQueryOptions(search)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SearchLocation$Query.fromJson(
        result.data!,
      );
    }
  }

  Future<LocationDetails$Query> locationDetails(
    String placeID
  ) async {
    final result = await client.query(
      EventOptions().locationDetailsQueryOptions(placeID)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return LocationDetails$Query.fromJson(
        result.data!,
      );
    }
  }

  Future<LocationDetailsFromCoords$Query> locationDetailsFromCoords(
    double latitude,
    double longitude
  ) async {
    final result = await client.query(
      EventOptions().locationDetailsFromCoordsQueryOptions(latitude, longitude)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return LocationDetailsFromCoords$Query.fromJson(
        result.data!,
      );
    }
  }
}