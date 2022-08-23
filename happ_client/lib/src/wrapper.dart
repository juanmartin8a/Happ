

import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccessState.dart';
import 'package:happ_client/src/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final userAccessProvider =
//     StateNotifierProvider<UserAccessController, UserAccessState>((ref) => UserAccessController());

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  WrapperState createState() => WrapperState();

}

class WrapperState extends ConsumerState<Wrapper> {

  @override
  void initState() {
    super.initState();
    print("wrapper init");
    ref.read(userAccessProvider.notifier).userAccess();
  }

  // const Wrapper({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    print("wrapper init 2");

    // UserAccessState stateVar;
    // Widget widget;

    UserAccessState userAccessState = ref.watch(userAccessProvider);

    print(userAccessState);

    ref.listen<UserAccessState>(userAccessProvider, ((previous, state) {
      if (state is UserAccessLoadingState) {
        // stateVar = state;
        // widget = Container(color: Colors.yellow);
      } else if (state is UserAccessGrantedState) {
        // stateVar = state;
        print("hello there");
        // widget = Container(color: Colors.red);;
      } else if (state is UserAccessDeniedState) {
        // stateVar = state;
        // widget = const Auth();
      }
    }));

    switch(userAccessState.runtimeType) {
      case UserAccessLoadingState:
        return Container(color: Colors.yellow);
      case UserAccessGrantedState:
      print("aaaa");
        return Container(color: Colors.green);
      // case UserAccessDeniedState:
      default:
        return const Auth();
    }
      
    

    // return Material(
    //   child: widget
      // resizeToAvoidBottomInset: false,
      // body: Container(
      //   child: BlocBuilder<MeBloc, MeState>(
      //     builder: (context, state) {
      //       if (state is MeLoadingState) {
      //         return Container(color: Colors.yellow);
      //       } else if (state is MeIsAuthState) {
      //         return Home();
      //       } else {
      //         return AuthScreen();
      //       }
      //     }
      //   )
      // )
    // );
  }
}

// import 'package:clivy_client/src/api/graphql/graphql_api.graphql.dart';
// import 'package:clivy_client/src/repos/userRepo.dart';
// import 'package:clivy_client/src/riverpod/signIn/signIn.dart';
// import 'package:clivy_client/src/riverpod/signIn/signInState.dart';
// import 'package:clivy_client/src/riverpodFamilies/userFamilies.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod/riverpod.dart';

// // final configProvider = FutureProvider.family<
// //   SignIn$Mutation$UserAuthResponse, 
// //   SignInFamily
// //   >(
// //   (ref, signIn) async {
// //   return UserRepo().signIn(signIn.usernameOrEmail, signIn.password);
// // });

// final signInProvider =
//     StateNotifierProvider<SignInController, SignInState>((ref) => SignInController());

// class Wrapper extends StatefulHookConsumerWidget {
//   const Wrapper({Key? key}) : super(key: key);

//   @override
//   ConsumerState<Wrapper> createState() => _WrapperState();
// }

// class _WrapperState extends ConsumerState<Wrapper> {

//   TextEditingController usernameOrEmailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     // SignInState signInProviderWatch = ref.watch(signInProvider);

//     ref.listen<SignInState>(signInProvider, ((previous, state) {
//       if (state is SignInDoneState) {
//         print(state.signInRes);
//       }
//     }));

//     return Material(
//       child: Container(
//         color: Colors.red,
//         child: Column(
//           children: [
//             Spacer(),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.85,
//               height: 45,
//               child: TextField(
//                 expands: true,
//                 maxLines: null,
//                 // textInputAction: TextInputAction.go,
//                 controller: usernameOrEmailController,
//                 textInputAction: TextInputAction.done,
//                 cursorColor: Color(0xff00ff03),
//                 textAlignVertical: TextAlignVertical.center,
//                 keyboardAppearance: Brightness.dark,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   height: 1.25
//                 ),
//                 decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey[900]!, width: 2.0),
//                     // borderRadius: BorderRadius.circular(12.5),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
//                     // borderRadius: BorderRadius.circular(12.5),
//                   ),
//                   contentPadding: EdgeInsets.zero,
//                   hintText: 'Username or Email',
//                   hintStyle: TextStyle(
//                     color: Colors.grey[800],
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     height: 1.25
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.85,
//               height: 45,
//               child: TextField(
//                 expands: true,
//                 maxLines: null,
//                 // textInputAction: TextInputAction.go,
//                 controller: passwordController,
//                 textInputAction: TextInputAction.done,
//                 cursorColor: Color(0xff00ff03),
//                 textAlignVertical: TextAlignVertical.center,
//                 keyboardAppearance: Brightness.dark,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   height: 1.25
//                 ),
//                 decoration: InputDecoration(
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey[900]!, width: 2.0),
//                     // borderRadius: BorderRadius.circular(12.5),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xff00ff03), width: 2.0),
//                     // borderRadius: BorderRadius.circular(12.5),
//                   ),
//                   contentPadding: EdgeInsets.zero,
//                   hintText: 'Password',
//                   hintStyle: TextStyle(
//                     color: Colors.grey[800],
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     height: 1.25
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 ref.read(signInProvider.notifier).signIn(
//                   usernameOrEmailController.text, passwordController.text
//                 );
//               },
//               child: Container(
//                 child: Text(
//                   "Sign In"
//                 )
//               ),
//             ),
//             Spacer(),
//           ],
//         )
//       ),
//     );
//   }
// }