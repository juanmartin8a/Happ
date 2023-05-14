import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserOptions {

  // MutationOptions signUpMutationOptions(
  //   String name,
  //   String username,
  //   String email, 
  //   String password,
  //   String birthday,
  // ) {
  //   MutationOptions mutationOptions = MutationOptions(
  //     document: SignUpMutation(
  //       variables: SignUpArguments(
  //         input: SignUpInput(
  //           name: name,
  //           username: username,
  //           email: email,
  //           password: password,
  //           birthday: birthday,
  //         ),
  //       )
  //     ).document,
  //     variables: {
  //       "input": {
  //         "name": name,
  //         "username": username,
  //         "email": email,
  //         "birthday": birthday,
  //         "password": password,
  //       }
  //     },
  //     fetchPolicy: FetchPolicy.networkOnly
  //   );

  //   return mutationOptions;
  // }

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
    MutationOptions  mutationOptions = MutationOptions(
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
    MutationOptions  mutationOptions = MutationOptions(
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
    MutationOptions  mutationOptions = MutationOptions(
      document: DeleteUserMutation().document,
      fetchPolicy: FetchPolicy.noCache
    );

    return mutationOptions;
  }

}