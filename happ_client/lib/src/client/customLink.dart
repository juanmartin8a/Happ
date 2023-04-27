// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:happ_client/src/api/graphql/graphql_api.dart';
// import 'package:happ_client/src/client/client.dart';
// import 'package:happ_client/src/repos/userRepo.dart';
// import 'package:happ_client/src/utils/jwt.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import "package:gql_transform_link/gql_transform_link.dart";


// class CustomLink extends Link {
//   late Link _link;
//   String _token = "";
//   int? userId;

//   UserRepo get userRepo => UserRepo();

//   CustomLink() {
//     _link = Link.concat(
//       ErrorLink(onGraphQLError: handleException),
//       TransformLink(requestTransformer: transformRequest),
//     );
//   }

//   Future updateToken() async {
//     if (Client.client == null) {
//       return ;
//     }
//     try {
//       var refreshToken = await JWT().getRefreshJWT();

//       var refreshTokensResult = await userRepo.refreshTokens("$refreshToken");

//       if (refreshTokensResult.hasException) {
//         // MeBloc(userRepo: _userRepo!)..add(MeSignOutEvent());
//         _token = "";
//         print("exception");
//         throw Exception();
//       }
//       final refreshTokens = RefreshTokens$Mutation$TokenResponse.fromJson(
//         (refreshTokensResult.data as Map<String, dynamic>)["refreshTokens"]
//       );
//       _token = refreshTokens.accessToken;
//     } catch(err) {
//       print("exception 2");
//       throw Exception();
//     }
//   }

//   Stream<Response> handleException(
//     Request request,
//     NextLink forward,
//     Response response,
//   ) async* {
//     if (response.errors != null && response.errors!.isNotEmpty &&
//     response.errors![0].message == 'access denied') {

//       try {
//         await updateToken();
//       } catch(err) {
//         throw response.errors!;
//       }

//       yield* forward(request);

//       return;
//     }

//     throw response.errors!;
//   }

//   Request transformRequest(Request request) {
//     var updatedRequest = request.updateContextEntry<HttpLinkHeaders>(
//       (headers) => HttpLinkHeaders(
//         headers: <String, String>{
//           "Authorization": "Bearer $_token",
//         },
//       ),
//     );

//     // print("toke");
//     // print(_token);

//     return updatedRequest;
//   }

//   @override
//   Stream<Response> request(Request request, [forward]) async* {
//     _token = await JWT().getJWT();
//     // final firebaseAuth = FirebaseAuth.instance;
//     // if (firebaseAuth.currentUser != null) {
//     //   userId = await getUserId(firebaseAuth);
//     // }
//     // final otherToken = await JWT().getRefreshJWT();
//     // print("aaaaa");
//     // print(otherToken);

//     yield* _link.request(request, forward);
//   }
// }

// class CustomAuthLink extends Link {
//   final String token;
//   final HttpLink _httpLink;

//   CustomAuthLink({required this.token, required String uri})
//       : _httpLink = HttpLink(uri);

//   @override
//   Stream<Response> request(Request request, [NextLink? forward]) {
//     final authRequest = request.updateContextEntry<HttpLinkHeaders>((headers) {
//       return HttpLinkHeaders(
//         headers: {
//           ...?headers?.headers,
//           'Authorization': 'Bearer $token',
//         },
//       );
//     });

//     return _httpLink.request(authRequest, forward);
//   }
// }