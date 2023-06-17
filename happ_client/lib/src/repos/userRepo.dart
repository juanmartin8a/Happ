import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:happ_client/src/client/client.dart';
import 'package:happ_client/src/utils/user/userOptions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

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

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
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

  Future<GetFollowState$Query> getFollowState(
    int id
  ) async {
    final result = await client.query(
      UserOptions().getFollowStateQueryOptions(id)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return GetFollowState$Query.fromJson(
        result.data!
      );
    }
  }

  Future<MutualFriends$Query> getMutualFriends(
    int id,
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      UserOptions().mutualFriendsQueryOptions(id, limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return MutualFriends$Query.fromJson(
        result.data!
      );
    }
  }

  Future<UpdateUser$Mutation$UpdateUserResponse> updateUser(
    http.MultipartFile? profilePic,
    String? username,
    String? name
  ) async {
    final result = await client.mutate(
      UserOptions().updateUserMutatioOptions(profilePic, username, name)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return UpdateUser$Mutation$UpdateUserResponse.fromJson(
        (result.data as Map<String, dynamic>)["updateUser"]
      );
    }
  }

  Future<AddedMe$Query> addedMe(
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      UserOptions().addedMeQueryOptions(limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return AddedMe$Query.fromJson(
        result.data!
      );
    }
  }

  Future<MyFriends$Query> myFriends(
    int limit,
    List<int> idsList
  ) async {
    final result = await client.query(
      UserOptions().myFriendsQueryOptions(limit, idsList)
    );

    if (result.hasException) {
      throw (result.exception as OperationException);
    } else {
      return MyFriends$Query.fromJson(
        result.data!
      );
    }
  }

}