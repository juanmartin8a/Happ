import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/authFlowNotifier/authFlowNotifier.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';

import 'package:happ_client/src/riverpod/signIn/signIn.dart';
import 'package:happ_client/src/riverpod/signIn/signInState.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

class Auth extends ConsumerStatefulWidget {
  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends ConsumerState<Auth> with SingleTickerProviderStateMixin {

  bool isGoogleLoading = false;
  bool isAppleLoading = false;

  bool isTermsConfirmed = false;

  AnimationController? animController;
  // Animation<double>? scaleController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animController!.addListener(() {
      if (animController!.isCompleted) {
        animController!.reverse();
      }
    });
  }

  @override
  void dispose() {
    if (animController != null) {
      animController!.dispose();
    }
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
          isGoogleLoading = false;
          isAppleLoading = false;
        });
        final user = UserFromId$Query$User.fromJson(next.signInRes.user!.toJson());

        ref.read(currentUserProvider.notifier).setCurrentUser(user);
        
        ref.read(authFlowNotifierProvider.notifier).setDone();

      } else if (next is SignInErrorState) {
        setState(() {
          isGoogleLoading = false;
          isAppleLoading = false;
        });
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>( 
      // value: SystemUiOverlayStyle.dark,
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top status bar
        systemNavigationBarColor: Colors.transparent, // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.light, //navigation bar icons' color
        statusBarBrightness: Brightness.light
        
      ),
      child: Material(
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
            if (Platform.isIOS)
            const SizedBox(
              height: 12
            ),
            if (Platform.isIOS)
            GestureDetector(
              onTap: () {
                if (isTermsConfirmed) {
                  signInWithApple();
                } else {
                  // animController!.forward();
                  if (!animController!.isAnimating) {
                    animController!.forward();
                  }
                }
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
                child: isAppleLoading 
                ? const Center(
                  child: Loader(radius: 8, brightness: Brightness.dark)
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
                        fontWeight: FontWeight.w500,
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
                if (isTermsConfirmed) {
                  signInWithGoogle();
                } else {
                  if (!animController!.isAnimating) {
                    animController!.forward();
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 47,
                // padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 2, color: Colors.grey[850]!),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: isGoogleLoading 
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
                        // fontFamily: "",
                        color: Colors.grey[850],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        // height: 1
                      )
                    ),
                  ],
                )
              ),
            ),
            const SizedBox(
              height: 24
            ),
            ScaleTransition(
              scale: animController!.drive(Tween(begin: 1.0, end: 1.06)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                // height: 50,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTermsConfirmed = !isTermsConfirmed;
                        });
                      },
                      child: SizedBox(
                        height: 19,
                        width: 19,
                        child: Container(
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            color: isTermsConfirmed ? Colors.greenAccent[700] : null,
                            borderRadius: BorderRadius.circular(7),
                            border: !isTermsConfirmed ? Border.all(width: 1.5, color: Colors.grey[500]!) : null
                          ),
                          child: isTermsConfirmed 
                          ? const Center(
                            child: Icon(
                              FluentIcons.checkmark_12_regular,
                              color: Colors.white,
                              size: 18
                            )
                          ) : null,
                        )
                      )
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: RichText(
                        // textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "I have read and agree to the ",
                          style: TextStyle(
                            fontFamily: "Inter",
                            color: Colors.grey[800],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Terms of Use ",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                    Uri.parse('https://www.happ.rsvp/legal/terms-of-use')
                                  );
                                },
                            ),
                            const TextSpan(text: "and "),
                            TextSpan(
                              text: "Privacy Policy", 
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(
                                    Uri.parse('https://www.happ.rsvp/legal/privacy-policy')
                                  );
                                },
                            ),
                            const TextSpan(text: "."),
                          ]
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom
            ),
          ],
        )
      ),
    );
  }

  void signInWithGoogle() async {
    setState(() {
      isGoogleLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setState(() {
          isGoogleLoading = false;
        });
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);

      String idToken = await userCredential.user!.getIdToken();

      ref.read(signInProvider.notifier).signIn(idToken, SignInProvider.google, null, null);
    } catch (error) {
      setState(() {
        isGoogleLoading = false;
      });
      debugPrint('Error occurred during Google sign-in: $error');
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void signInWithApple() async {
    setState(() {
      isAppleLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      String name = "${appleCredential.givenName} ${appleCredential.familyName}";

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final UserCredential userCredential = await auth.signInWithCredential(oauthCredential);

      String idToken = await userCredential.user!.getIdToken();

      ref.read(signInProvider.notifier).signIn(idToken, SignInProvider.apple, name, appleCredential.authorizationCode);
      
    } catch(e) {
      setState(() {
        isAppleLoading = false;
      });
      debugPrint('Error occurred during Google sign-in: $e');
    }
  }
}