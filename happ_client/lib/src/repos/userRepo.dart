
import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:happ_client/src/client/client.dart';
import 'package:happ_client/src/utils/jwt.dart';
import 'package:happ_client/src/utils/userOptions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// enum UserParams { Client.client! }

class UserRepo {

  GraphQLClient get client => Client.client!;

  Future<UserAccess$Query$User> userAccess() async {
    final result = await client.query(
      UserOptions().userAccessQueryOptions()
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return UserAccess$Query$User.fromJson(
        (result.data as Map<String, dynamic>)["userAccess"]
      );
    }
  }

  Future<SignIn$Mutation$UserAuthResponse> signIn(
    String usernameOrEmail, String password
  ) async {
    final result = await client.mutate(
      UserOptions().signInMutationOptions(usernameOrEmail, password)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      if ((result.data as Map<String, dynamic>)["signIn"]["tokens"] != null) {
        // print(result.data);
        await JWT().createJWTS(
          (result.data as Map<String, dynamic>)["signIn"]["tokens"]["accessToken"],
          (result.data as Map<String, dynamic>)["signIn"]["tokens"]["refreshToken"]
        );
      }
      print((result.data as Map<String, dynamic>)["signIn"]["user"]["id"].runtimeType);
      return SignIn$Mutation$UserAuthResponse.fromJson(
        (result.data as Map<String, dynamic>)["signIn"]
      );
    }
  }

  Future<SignUp$Mutation$UserAuthResponse> signUp(
    String name,
    String username,
    String email, 
    String password,
    String birthday,
  ) async {
    final result = await client.mutate(
      UserOptions().signUpMutationOptions(name, username, email, password,birthday)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      if ((result.data as Map<String, dynamic>)["signUp"]["tokens"] != null) {
        await JWT().createJWTS(
          (result.data as Map<String, dynamic>)["signUp"]["tokens"]["accessToken"],
          (result.data as Map<String, dynamic>)["signUp"]["tokens"]["refreshToken"]
        );
      }
      return SignUp$Mutation$UserAuthResponse.fromJson(
        (result.data as Map<String, dynamic>)["signUp"]
      );
    }
  }

  Future<QueryResult> refreshTokens(String token) async {
    final result = await client.mutate(
      UserOptions().refreshTokensMutationOptions(token)
    );

    if (result.hasException) {
      await JWT().deleteJWTS();
      throw (result.exception as OperationException);
    } else {
      await JWT().createJWTS(
        result.data!["refreshTokens"]["accessToken"],
        result.data!["refreshTokens"]["refreshToken"]
      );
    }

    return result;
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
    String search
  ) async {
    final result = await client.query(
      UserOptions().searchUsersQueryOptions(search)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return SearchUsers$Query.fromJson(result.data as Map<String, dynamic>);
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

}