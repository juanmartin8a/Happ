

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifier.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifierState.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/firebaseAuthProvider/firebaseAuthProvider.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccessState.dart';
import 'package:happ_client/src/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/screens/home.dart';
import 'package:happ_client/src/utils/getUserIdFromFBIDToken.dart';

// final userAccessProvider =
//     StateNotifierProvider<UserAccessController, UserAccessState>((ref) => UserAccessController());

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  WrapperState createState() => WrapperState();

}

class WrapperState extends ConsumerState<Wrapper> {

  // UserRepo get userRepo => UserRepo();

  bool isAuth = false;
  bool isComplete = false;

  bool isSaveLoading = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(userAccessProvider.notifier).userAccess();
    // });
    // ref.read(userAccessProvider.notifier).userAccess();
  }

  // const Wrapper({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(firebaseAuthProvider);
    final authStateChanges = auth.authStateChanges();

    ref.listen(authFlowNotifierProvider, (prev, next) {
      if (next is AuthFlowNotifierDoneState) {
        if (isAuth == true) {
          setState(() {
            isComplete = true;
          });
        }
      }
    });

    return StreamBuilder<User?>(
      stream: authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final user = snapshot.data;
          if (user == null || (isAuth == true && isComplete == false)) {
            isAuth = true;
            return const Auth();
          } else {
            if (isAuth) {
              return const Home();
            }
            return FutureBuilder(
              future: saveCurrentUser(auth),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Home();
                } else {
                  return Container();
                }
              }
            );
          }
        }
      },
    );
  }

  Future<void> saveCurrentUser(FirebaseAuth auth) async {

    String token = await auth.currentUser!.getIdToken();

    Map<String, dynamic> claims = parseJwt(token);
    if (!claims.containsKey("id")) {
      token = await auth.currentUser!.getIdToken(true);
      claims = parseJwt(token);
    }
    int userId = claims["id"];

    // print(claims);

    Map<String, dynamic> userJson = {
      "id": userId,
      "name": claims["name"],
      "username": claims["username"],
      "followState": false,
      "profilePic": claims["picture"]
    };

    UserFromId$Query$User user = UserFromId$Query$User.fromJson(userJson);

    ref.read(currentUserProvider.notifier).setCurrentUser(user);
  }
}