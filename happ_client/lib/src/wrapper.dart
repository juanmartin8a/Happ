

import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccessState.dart';
import 'package:happ_client/src/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/screens/home.dart';

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

    UserAccessState userAccessState = ref.watch(userAccessProvider);

    switch(userAccessState.runtimeType) {
      case UserAccessLoadingState:
        return Container(color: Colors.yellow);
      case UserAccessGrantedState:
        // return Container(color: Colors.green);
        return Home(
          userId: (userAccessState as UserAccessGrantedState).user.id.toInt()
        );
      // case UserAccessDeniedState:
      default:
        return const Auth();
    }
  }
}