
import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:happ_client/src/client/client.dart';
import 'package:happ_client/src/utils/userOptions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// enum UserParams { Client.client! }

class UserRepo {

  GraphQLClient get client => Client.client!;

  Future<SignIn$Mutation$SignInResponse> signIn(
    String token,
    SignInProvider provider,
    String? name,
    String? authorizationCode
  ) async {
    final result = await client.mutate(
      UserOptions().signInMutationOptions(token, provider, name, authorizationCode)
    );

    print("result");
    print(result);

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      // if ((result.data as Map<String, dynamic>)["signIn"]["tokens"] != null) {
      //   // print(result.data);
      //   // await JWT().createJWTS(
      //   //   (result.data as Map<String, dynamic>)["signIn"]["tokens"]["accessToken"],
      //   //   (result.data as Map<String, dynamic>)["signIn"]["tokens"]["refreshToken"]
      //   // );
      //   // var refreshToken = await JWT().getRefreshJWT();

      //   // print("refresh token is: $refreshToken");
      // }
      // print((result.data as Map<String, dynamic>)["signIn"]["user"]["id"].runtimeType);
      return SignIn$Mutation$SignInResponse.fromJson(
        (result.data as Map<String, dynamic>)["signIn"]
      );
    }
  }

  Future<UserFromId$Query$User> getUser(
    int userId
  ) async {
    final result = await client.query(
      UserOptions().userFromIdQueryOptions(userId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return UserFromId$Query$User.fromJson(
        (result.data as Map<String, dynamic>)["userFromId"]
      );
    }
  }

  Future<SearchUsers$Query> searchUsers(
    String search,
    int userSearching
  ) async {
    final result = await client.query(
      UserOptions().searchUsersQueryOptions(search, userSearching)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SearchUsers$Query.fromJson(result.data as Map<String, dynamic>);
    }
  }

  Future<SearchForUsersToAddAsGuests$Query> searchUsersToAddAsGuests(
    String search,
    int eventId
  ) async {
    final result = await client.query(
      UserOptions().searchUsersToAddAsGuestsQueryOptions(search, eventId)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SearchForUsersToAddAsGuests$Query.fromJson(result.data as Map<String, dynamic>);
    }
  }

  Future<AddOrRemoveUser$Mutation$AddResponse> addOrRemoveUser(
    int followUserId,
    bool isFollow
  ) async {
    final result = await client.mutate(
      UserOptions().addOrRemoveUserMutationOptions(followUserId, isFollow)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AddOrRemoveUser$Mutation$AddResponse.fromJson(
        (result.data as Map<String, dynamic>)["addOrRemoveUser"]
      );
    }
  }

  Future<SaveDevice$Mutation> saveDevice(
    String token,
  ) async {
    final result = await client.mutate(
      UserOptions().saveDeviceMutationOptions(token)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SaveDevice$Mutation.fromJson(
        result.data!
      );
    }
  }

  Future<DeleteUser$Mutation> deleteUser() async {
    final result = await client.mutate(
      UserOptions().deleteUser()
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return DeleteUser$Mutation.fromJson(
        result.data!
      );
    }
  }

}