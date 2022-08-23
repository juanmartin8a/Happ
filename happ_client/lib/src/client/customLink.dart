import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/client/client.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/utils/jwt.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import "package:gql_transform_link/gql_transform_link.dart";


class CustomLink extends Link {
  late Link _link;
  String _token = "";

  UserRepo get userRepo => UserRepo();

  CustomLink() {
    _link = Link.concat(
      ErrorLink(onGraphQLError: handleException),
      TransformLink(requestTransformer: transformRequest),
    );
  }

  Future updateToken() async {
    if (Client.client == null) {
      return ;
    }
    try {
      var refreshToken = await JWT().getRefreshJWT();

      var refreshTokensResult = await userRepo.refreshTokens("$refreshToken");

      if (refreshTokensResult.hasException) {
        // MeBloc(userRepo: _userRepo!)..add(MeSignOutEvent());
        _token = "";
        // print("exception");
        throw Exception();
      }
      final refreshTokens = RefreshTokens$Mutation$TokenResponse.fromJson(
        (refreshTokensResult.data as Map<String, dynamic>)["refreshTokens"]
      );
      _token = refreshTokens.accessToken;
    } catch(err) {
      // print("exception");
      throw Exception();
    }
  }

  Stream<Response> handleException(
    Request request,
    NextLink forward,
    Response response,
  ) async* {

    if (response.errors != null && response.errors!.isNotEmpty &&
    response.errors![0].message == 'Access Denied') {

      try {
        await updateToken();
      } catch(err) {
        throw response.errors!;
      }

      yield* forward(request);

      return;
    }

    throw response.errors!;
  }

  Request transformRequest(Request request) {
    var updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: <String, String>{
          "Authorization": "Bearer $_token",
        },
      ), 
    );

    return updatedRequest;
  }

  @override
  Stream<Response> request(Request request, [forward]) async* {
    _token = await JWT().getJWT();

    yield* _link.request(request, forward);
  }
}