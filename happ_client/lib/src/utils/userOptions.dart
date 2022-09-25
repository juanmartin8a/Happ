import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserOptions {

  MutationOptions signUpMutationOptions(
    String name,
    String username,
    String email, 
    String password,
    String birthday,
  ) {
    MutationOptions mutationOptions = MutationOptions(
      document: SignUpMutation(
        variables: SignUpArguments(
          input: SignUpInput(
            name: name,
            username: username,
            email: email,
            password: password,
            birthday: birthday,
          ),
        )
      ).document,
      variables: {
        "input": {
          "name": name,
          "username": username,
          "email": email,
          "birthday": birthday,
          "password": password,
        }
      },
      fetchPolicy: FetchPolicy.networkOnly
    );

    return mutationOptions;
  }

  MutationOptions signInMutationOptions(String usernameOrEmail, String password) {
    MutationOptions mutationOptions = MutationOptions(
      document: SignInMutation(
        variables: SignInArguments(
          input: SignInInput(
            usernameOrEmail: usernameOrEmail,
            password: password,
          ),
        )
      ).document,
      variables: {
        "input": {
          "usernameOrEmail": usernameOrEmail,
          "password": password
        }
      },
      fetchPolicy: FetchPolicy.networkOnly
    );

    return mutationOptions;
  }

  QueryOptions userAccessQueryOptions() {
    QueryOptions queryOptions = QueryOptions(
      document: UserAccessQuery().document,
      fetchPolicy: FetchPolicy.networkOnly
    );

    return queryOptions;
  }

  MutationOptions refreshTokensMutationOptions(String token) {
    MutationOptions mutationOptions = MutationOptions(
      document: RefreshTokensMutation(
        variables: RefreshTokensArguments(
          token: token
        )
      ).document,
      variables: {
        "token": token
      },
      fetchPolicy: FetchPolicy.networkOnly
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
      fetchPolicy: FetchPolicy.networkOnly
    );

    return queryOptions;
  }

  QueryOptions searchUsersQueryOptions(String search) {
    QueryOptions queryOptions = QueryOptions(
      document: SearchUsersQuery(
        variables: SearchUsersArguments(
          search: search,
        )
      ).document,
      variables: {
        "search": search
      },
      fetchPolicy: FetchPolicy.networkOnly
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
      fetchPolicy: FetchPolicy.networkOnly
    );

    return mutationOptions;
  }

}