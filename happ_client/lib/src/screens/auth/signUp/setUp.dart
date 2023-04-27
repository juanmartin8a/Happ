// import 'package:happ_client/src/riverpod/auth/buttonState.dart';
// import 'package:happ_client/src/riverpod/signUp/signUp.dart';
// import 'package:happ_client/src/riverpod/signUp/signUpState.dart';
// import 'package:happ_client/src/screens/auth/widgets/buttonAction.dart';
// import 'package:happ_client/src/screens/auth/widgets/passwordField.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final signUpButtonStateProvider = StateNotifierProvider<ButtonStateController, ButtonState>((ref) {
//   return ButtonStateController();
// });

// class SetUpAccount extends ConsumerStatefulWidget {
//   const SetUpAccount({ 
//     Key? key 
//   }) : super(key: key);

//   @override
//   SetUpAccountState createState() => SetUpAccountState();
// }

// class SetUpAccountState extends ConsumerState<SetUpAccount> with AutomaticKeepAliveClientMixin {

//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   String? usernameError;
//   String? emailError;
//   String? passwordError;

//   bool isPasswordVisible = false;

//   @override
//   void initState() {
//     _usernameController.addListener(() {
//       textControllerListenerFunc();
//     });
//     _usernameController.addListener(() {
//       textControllerListenerFunc();
//     });
//     _passwordController.addListener(() {
//       textControllerListenerFunc();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Column(
//       children: [
//         Container(
//           height: 45,
//           // color: Color(0xff00ff03),
//           margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//         ),
//         const Text(
//           "Set up your account",
//           style: TextStyle(
//             color: Color(0xff00ff03),
//             fontSize: 22,
//             // letterSpacing: 0.5,
//             // fontStyle: FontStyle.normal,
//             fontWeight: FontWeight.w600,
//             // height: 1
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           height: 45,
//           // color: Colors.blue,
//           child: TextField(
//             expands: true,
//             maxLines: null,
//             // textInputAction: TextInputAction.go,
//             controller: _usernameController,
//             textInputAction: TextInputAction.done,
//             cursorColor: const Color(0xff00ff03),
//             textAlignVertical: TextAlignVertical.center,
//             keyboardAppearance: Brightness.dark,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               height: 1.25
//             ),
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: usernameError != null ? Colors.red[700]! : Colors.grey[900]!, width: 2.0),
//                 // borderRadius: BorderRadius.circular(12.5),
//               ),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
//                 // borderRadius: BorderRadius.circular(12.5),
//               ),
//               contentPadding: EdgeInsets.zero,
//               hintText: 'Username',
//               hintStyle: TextStyle(
//                 color: Colors.grey[800],
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 height: 1.25
//               ),
//             ),
//           ),
//         ),
//         if (usernameError != null)
//         const SizedBox(height: 6),
//         if (usernameError != null)
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           child: Text(
//             usernameError!,
//             style: TextStyle(
//               color: Colors.red[700],
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               height: 1.2
//             ),
//           )
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           height: 45,
//           // color: Colors.red,
//           child: TextField(
//             expands: true,
//             maxLines: null,
//             controller: _emailController,
//             textInputAction: TextInputAction.done,
//             cursorColor: const Color(0xff00ff03),
//             textAlignVertical: TextAlignVertical.center,
//             keyboardAppearance: Brightness.dark,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               height: 1.25
//             ),
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: emailError != null ? Colors.red[700]! : Colors.grey[900]!, width: 2),
//                 // borderRadius: BorderRadius.circular(12.5),
//               ),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xff00ff03), width: 2),
//                 // borderRadius: BorderRadius.circular(12.5),
//               ),
//               contentPadding: EdgeInsets.zero,
//               hintText: 'Email',
//               hintStyle: TextStyle(
//                 color: Colors.grey[800],
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 height: 1.25
//               ),
//             ),
//           ),
//         ),
//         if (emailError != null)
//         const SizedBox(height: 6),
//         if (emailError != null)
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           child: Text(
//             emailError!,
//             style: TextStyle(
//               color: Colors.red[700],
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               height: 1.2
//             ),
//           )
//         ),
//         const SizedBox(height: 12),
//         PasswordField(
//           passwordController: _passwordController,
//           key: const Key("signup_password_controller_textField")
//         ),
//         if (passwordError != null)
//         const SizedBox(height: 6),
//         if (passwordError != null)
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           child: Text(
//             passwordError!,
//             style: TextStyle(
//               color: Colors.red[700],
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               height: 1.2
//             ),
//           )
//         ),
//         const SizedBox(height: 30),
//         GestureDetector(
//           onTap: () async {
//             await clientValidation();
//             if (
//               usernameError == null &&
//               emailError == null &&
//               passwordError == null
//             ) {
//               print("aaaa");
//               ref.read(signUpProvider.notifier).setData(
//                 _usernameController.text.trim(), 
//                 _emailController.text.trim(), 
//                 _passwordController.text
//               );
//             }
//           },
//           child: AuthActionButton(
//             notifierProvider: signUpButtonStateProvider,
//             isLoadingProvider: signUpProvider,
//             text: "Sign up",
//             classParam: SignUpLoadingState,
//             key: const Key("signUn_action_button_state")
//           ),
//         ),
//       ],
//     );
//   }

//   clientValidation() async {
//     String username = _usernameController.text.trim();
//     String email = _emailController.text.trim();
//     String password = _passwordController.text;

//     RegExp spaceRegex = RegExp(
//       r"\s\b|\b\s"
//     );

//     if (username.length < 2 || username.length > 30) {
//       if (username.isEmpty) {
//         usernameError = "Username must not be empty";
//       } else if (username.length < 2) {
//         usernameError = "Username must have at least 2 characters";
//       } else if (spaceRegex.hasMatch(username)) {
//         usernameError = "Username must not have any spaces";
//       } else if (username.length > 30) {
//         usernameError = "Username must have no more than 20 characters";
//       }
//     } else {
//       usernameError = null;
//     }

//     RegExp emailRegExp = RegExp(
//       r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])'''
//     );
//     if (!emailRegExp.hasMatch(email)) {
//       emailError = "Invalid Email";
//     } else {
//       emailError = null;
//     }

//     RegExp passwordRegExp = RegExp(
//       r'(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}'
//     );
//     if (!passwordRegExp.hasMatch(password)) {
//       if (password.length < 8) {
//         passwordError = 'Password must have at least 8 characters';
//       } else if (spaceRegex.hasMatch(password)) {
//         passwordError = 'Password must not have any spaces';
//       } else if (!passwordRegExp.hasMatch(password)) {
//         passwordError = 'Password must have at least one letter and one number';
//       }
//     } else {
//       passwordError = null;
//     }

//     setState(() {});
//   }

//   void textControllerListenerFunc() {
//     if (_usernameController.text.isNotEmpty && 
//       _passwordController.text.isNotEmpty &&
//       _emailController.text.isNotEmpty
//     ) {
//       ref.read(signUpButtonStateProvider.notifier).setButtonValue(true);
//     } else {
//       ref.read(signUpButtonStateProvider.notifier).setButtonValue(false);
//     }
//   }

//   @override
//   bool get wantKeepAlive => true;
// }