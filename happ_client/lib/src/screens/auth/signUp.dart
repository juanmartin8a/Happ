import 'package:happ_client/src/riverpod/signUp/signUp.dart';
import 'package:happ_client/src/riverpod/signUp/signUpState.dart';
import 'package:happ_client/src/riverpod/userAccess/userAccess.dart';
import 'package:happ_client/src/screens/auth/signUp/birthday.dart';
import 'package:happ_client/src/screens/auth/signUp/setUp.dart';
import 'package:happ_client/src/utils/user/userTypesConverter.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends ConsumerState<SignUp> {
  final PageController _pageController = PageController();

  // SignUpCubit? _signUpCubit;
  String? birthday;
  String? name;
  String? username;
  String? email;
  String? password;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<SignUpState>(signUpProvider, ((previous, state) {
      if (state is SignUpSetBirthdayState) {
        birthday = state.birthday;
        nextPage(1);
      } else if (state is SignUpSetDataState) {
        name = state.username;
        username = state.username;
        email = state.email;
        password = state.password;

        ref.read(signUpProvider.notifier).signUp(name!, username!, email!, password!, birthday!);
      } else if (state is SignUpDoneState) {
        if (state.signUpRes.errors == null) {
          final user = UserTypesConverter().convertToUserAccessUser(state.signUpRes.user!);
          ref.read(userAccessProvider.notifier).signUserIn(user);
          context.go('/');
        }
      }
    }));

    return Material(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: const [
                BirthdayScreen(),
                SetUpAccount(),
                // VideogameGenreSelection(),
                // Container(
                //   color: Colors.green,
                // )
              ]
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45 + MediaQuery.of(context).padding.top,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45 + MediaQuery.of(context).padding.top,
                  width: 45,
                  // color: Colors.red,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        // Get.back();
                        Navigator.pop(context);
                      },
                      child: FloatingActions(
                        icon: CupertinoIcons.chevron_back,
                        padding: const EdgeInsets.only(left: 8),
                        color: Colors.grey[800]!,
                        size: 36,
                        key: const Key("goBack")
                      )
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }

  void nextPage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.decelerate
      );
    }
  }
}