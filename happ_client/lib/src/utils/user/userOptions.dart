import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class UserOptions {

  MutationOptions signInMutationOptions(
    String token,
    SignInProvider provider,
    String? name,
    String? authorizationCode
  ) {
    const pictureActionEnumMap = {
      SignInProvider.apple: 'APPLE',
      SignInProvider.google: 'GOOGLE',
    };

    AppleData? appleData = provider == SignInProvider.apple 
    ? AppleData(
      name: name!, 
      authorizationCode: authorizationCode!
    )
    : null;

    MutationOptions mutationOptions = MutationOptions(
      document: SignInMutation(
        variables: SignInArguments(
          input: SignInInput(
            token: token,
            provider: provider,
            appleData: appleData
          ),
        )
      ).document,
      variables: {
        "input": {
          "token": token,
          "provider": pictureActionEnumMap[provider],
          "appleData": appleData?.toJson(),
        }
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  QueryOptions userFromIdQueryOptions(int id) {
    QueryOptions queryOptions = QueryOptions(
      document: UserFromIdQuery(
        variables: UserFromIdArguments(
          id: id,
        )
      ).document,
      variables: {
        "id": id
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions searchUsersQueryOptions(String search, int userSearching) {
    QueryOptions queryOptions = QueryOptions(
      document: SearchUsersQuery(
        variables: SearchUsersArguments(
          search: search,
          userSearching: userSearching,
        )
      ).document,
      variables: {
        "search": search,
        "userSearching": userSearching,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions searchUsersToAddAsGuestsQueryOptions(String search, int eventId) {
    QueryOptions queryOptions = QueryOptions(
      document: SearchForUsersToAddAsGuestsQuery(
        variables: SearchForUsersToAddAsGuestsArguments(
          search: search,
          eventId: eventId,
        )
      ).document,
      variables: {
        "search": search,
        "eventId": eventId,
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  MutationOptions addOrRemoveUserMutationOptions(int followUserId, bool isFollow) {
    MutationOptions mutationOptions = MutationOptions(
      document: AddOrRemoveUserMutation(
        variables: AddOrRemoveUserArguments(
          followUserId: followUserId,
          isFollow: isFollow
        )
      ).document,
      variables: {
        "followUserId": followUserId,
        "isFollow": isFollow
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions saveDeviceMutationOptions(String token) {
    MutationOptions mutationOptions = MutationOptions(
      document: SaveDeviceMutation(
        variables: SaveDeviceArguments(
          token: token
        )
      ).document,
      variables: {
        "token": token
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  MutationOptions deleteUser() {
    MutationOptions mutationOptions = MutationOptions(
      document: DeleteUserMutation().document,
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  QueryOptions getFollowStateQueryOptions(
    int id
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: GetFollowStateQuery(
        variables: GetFollowStateArguments(id: id)
      ).document,
      variables: {
        "id": id
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  QueryOptions mutualFriendsQueryOptions(
    int id,
    int limit,
    List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: MutualFriendsQuery(
        variables: MutualFriendsArguments(
          id: id,
          limit: limit,
          idsList: idsList
        )
      ).document,
      variables: {
        "id": id,
        "limit": limit,
        "idsList": idsList
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return queryOptions;
  }

  MutationOptions updateUserMutatioOptions(
    http.MultipartFile? profilePic,
    String? username,
    String? name,
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: UpdateUserMutation(
        variables: UpdateUserArguments(
          input: UpdateUserInput(
            name: name,
            username: username,
            profilePic: profilePic,
          )
        )
      ).document,
      variables: {
        "input": {
          "name": name,
          "username": username,
          "profilePic": profilePic,
        }
      },
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

  QueryOptions addedMeQueryOptions(
    int limit,
    List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: AddedMeQuery(
        variables: AddedMeArguments(
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

    return queryOptions;
  }

  QueryOptions myFriendsQueryOptions(
    int limit,
    List<int> idsList
  ) {
    QueryOptions queryOptions = QueryOptions(
      document: MyFriendsQuery(
        variables: MyFriendsArguments(
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

    return queryOptions;
  }

}