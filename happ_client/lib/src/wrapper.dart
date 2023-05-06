import 'package:firebase_auth/firebase_auth.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifier.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifierState.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/firebaseAuthProvider/firebaseAuthProvider.dart';
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
  bool isAuth = false;
  bool isComplete = false;
  late Stream<User?> authStateChanges;

  String tokenId = "";

  @override
  void initState() {
    super.initState();
    final auth = ref.read(firebaseAuthProvider);
    authStateChanges = auth.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {

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
            // if (isAuth) {
            //   return const Home(key: Key("Home"));
            // }

            return FutureBuilder(
              future: saveCurrentUser(ref.read(firebaseAuthProvider)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Home(key: Key("Home"));
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

    // print(userId);
    // print(claims[]);

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