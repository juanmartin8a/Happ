import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifier.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'dart:developer' as logDev;

import 'package:happ_client/src/riverpod/signIn/signIn.dart';
import 'package:happ_client/src/riverpod/signIn/signInState.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Auth extends ConsumerStatefulWidget {
  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends ConsumerState<Auth> {

  bool isLoading = false;

  @override
  void dispose() {
    // dispose providers used (signInProvider and authFlowNotifierProvider)
    ref.invalidate(signInProvider);
    ref.invalidate(authFlowNotifierProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInProvider, (prev, next) {
      if (next is SignInDoneState) {
        setState(() {
          isLoading = false;
        });
        final user = UserFromId$Query$User.fromJson(next.signInRes.user!.toJson());

        ref.read(currentUserProvider.notifier).setCurrentUser(user);
        
        ref.read(authFlowNotifierProvider.notifier).setDone();

      } else if (next is SignInErrorState) {
        setState(() {
          isLoading = false;
        });
      }
    });

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top
          ),
          const Spacer(),
          const Center(
            child: Text(
              "Welcome to\nHapp ;)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                // height: 1
              )
            )
            
          ),
          const SizedBox(
            height: 24
          ),
          const SizedBox(
            height: 12
          ),
          GestureDetector(
            onTap: () {
              // signInWithGoogle();
              signInWithApple();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 47,
              // padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.black,
                // border: Border.all(width: 2, color: Colors.grey[800]!),
                borderRadius: BorderRadius.circular(25)
              ),
              child: isLoading 
              ? const Center(
                child: Loader(radius: 8)
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/logos/apple_logo.png",
                      height: 47,
                      width: 47,
                    ),
                  ),
                  const Text(
                    "Continue with Apple",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1
                    )
                  ),
                ],
              )
            ),
          ),
          const SizedBox(
            height: 6
          ),
          GestureDetector(
            onTap: () {
              signInWithGoogle();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 47,
              // padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 2, color: Colors.grey[800]!),
                borderRadius: BorderRadius.circular(25)
              ),
              child: isLoading 
              ? const Center(
                child: Loader(radius: 8)
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logos/google_logo.png",
                    height: 19,
                    width: 19,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Continue with Google",
                    style: TextStyle(
                      fontFamily: "",
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1
                    )
                  ),
                ],
              )
            ),
          ),
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom
          ),
        ],
      )
    );
  }

  void signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in flow
        setState(() {
          isLoading = false;
        });
        return null;
      }

      // Obtain the authentication details from the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential with the Google authentication details
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await auth.signInWithCredential(credential);

      // Get ID token
      String idToken = await userCredential.user!.getIdToken();

      // Return the signed-in Firebase user
      ref.read(signInProvider.notifier).signIn(idToken, SignInProvider.google, null, null);
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error occurred during Google sign-in: $error');
      // return null;
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void signInWithApple() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print(appleCredential.email);

      print(appleCredential.identityToken);

      print(appleCredential.authorizationCode);

      String name = "${appleCredential.givenName} ${appleCredential.familyName}";

      print(name);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.

      final UserCredential userCredential = await auth.signInWithCredential(oauthCredential);

      // Get ID token
      String idToken = await userCredential.user!.getIdToken();

      print(idToken);

      print(userCredential.user);

      ref.read(signInProvider.notifier).signIn(idToken, SignInProvider.apple, name, appleCredential.authorizationCode);
      
      // return userCredential;
    } catch(e) {
      setState(() {
        isLoading = false;
      });
      print('Error occurred during Google sign-in: $e');
    }
  }
}