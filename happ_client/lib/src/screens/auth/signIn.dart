// import 'package:happ_client/src/riverpod/auth/buttonState.dart';
// import 'package:happ_client/src/riverpod/signIn/signIn.dart';
// import 'package:happ_client/src/riverpod/signIn/signInState.dart';
// import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
// import 'package:happ_client/src/screens/auth/widgets/AuthErrors.dart';
// import 'package:happ_client/src/screens/auth/widgets/buttonAction.dart';
// import 'package:happ_client/src/screens/auth/widgets/passwordField.dart';
// import 'package:happ_client/src/utils/user/userTypesConverter.dart';
// import 'package:happ_client/src/utils/widgets/floatingActions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// final signInButtonStateProvider = StateNotifierProvider<ButtonStateController, ButtonState>((ref) {
//   return ButtonStateController();
// });

// class SignIn extends ConsumerStatefulWidget {
//   const SignIn({Key? key}): super(key: key);

//   @override
//   SignInWidgetState createState() => SignInWidgetState();
// }

// class SignInWidgetState extends ConsumerState<SignIn> {
//   // SignInCubit? _signInCubit;

//   final _usernameOrEmailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   String? usernameOrEmailError;
//   String? passwordError;

//   bool isPasswordVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     _usernameOrEmailController.addListener(() {
//       textControllerListenerFunc();
//     });
//     _passwordController.addListener(() {
//       textControllerListenerFunc();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _usernameOrEmailController.dispose();
//     _passwordController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ref.listen<SignInState>(signInProvider, ((previous, state) {
//       if (state is SignInDoneState) {
//         if (state.signInRes.errors == null) {
//           final user = UserTypesConverter().convertToUserAccessUser(state.signInRes.user!);
//           ref.read(userAccessProvider.notifier).signUserIn(user);
//           context.go('/');
//         }
//       }
//     }));

//     return Material(
//       color: Colors.white,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         // height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
            
//             SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 45 + MediaQuery.of(context).padding.top,
//                       // color: Color(0xff00ff03),
//                       margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//                     ),
//                     const Text(
//                       "Sign in",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 26,
//                         letterSpacing: 0.5,
//                         // fontStyle: FontStyle.normal,
//                         fontWeight: FontWeight.w600,
//                         // height: 1
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30
//                     ),
//                     // Spacer(),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.85,
//                       height: 45,
//                       // color: Colors.blue,
//                       child: TextField(
//                         // expands: true,
//                         // maxLines: null,
//                         // textInputAction: TextInputAction.go,
//                         controller: _usernameOrEmailController,
//                         textInputAction: TextInputAction.done,
//                         cursorColor: Colors.blue,
//                         textAlign: TextAlign.start,
//                         keyboardAppearance: Brightness.dark,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           height: 1.25
//                         ),
//                         decoration: InputDecoration(
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey[900]!, width: 2.0),
//                             // borderRadius: BorderRadius.circular(12.5),
//                           ),
//                           focusedBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                             // borderRadius: BorderRadius.circular(12.5),
//                           ),
//                           contentPadding: EdgeInsets.zero,
//                           hintText: 'Username or Email',
//                           hintStyle: TextStyle(
//                             color: Colors.grey[800],
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             height: 1.25
//                           ),
//                         ),
//                       ),
//                     ),
//                     AuthErrors(
//                       stateNotifierProvider: signInProvider,
//                       errorField: "usernameOrEmail",
//                       key: const Key("signIn_usernameOrEmail_field")
//                     ),
//                     const SizedBox(height: 12),
//                     PasswordField(
//                       passwordController: _passwordController,
//                       key: const Key("signIn_password_controller_textField")
//                     ),
//                     AuthErrors(
//                       stateNotifierProvider: signInProvider,
//                       errorField: "password",
//                       key: const Key("signIn_password_field")
//                     ),
//                     const SizedBox(height: 3),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.85,
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             // Get.to(ForgotPassword(key: Key(Uuid().v4())));
//                           },
//                           child: Text(
//                             "Forgot password?",
//                             style: TextStyle(
//                               color: Colors.grey[800],
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               // height: 1.25
//                             ),
//                           ),
//                         )
//                       )
//                     ),
//                     const SizedBox(height: 30),
//                     // Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         ref.read(signInProvider.notifier).signIn(
//                           _usernameOrEmailController.text, 
//                           // _passwordController.text
//                         );
//                       },
//                       child: AuthActionButton(
//                         notifierProvider: signInButtonStateProvider,
//                         isLoadingProvider: signInProvider,
//                         text: "Sign in",
//                         classParam: SignInLoadingState,
//                         key: const Key("signIn_action_button_state")
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 35,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 45 + MediaQuery.of(context).padding.top,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   height: 45 + MediaQuery.of(context).padding.top,
//                   width: 45,
//                   margin: EdgeInsets.only(
//                     top: MediaQuery.of(context).padding.top
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: FloatingActions(
//                         icon: CupertinoIcons.chevron_back,
//                         padding: const EdgeInsets.only(left: 8),
//                         color: Colors.grey[800]!,
//                         size: 36,
//                         key: const Key("goBack")
//                       )
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         )
//       )
//     );
//   }

//   void textControllerListenerFunc() {
//     if (_usernameOrEmailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
//       ref.read(signInButtonStateProvider.notifier).setButtonValue(true);
//     } else {
//       ref.read(signInButtonStateProvider.notifier).setButtonValue(false);
//     }
//   }
// }