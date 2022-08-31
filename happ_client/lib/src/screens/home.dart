import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/search/search.dart';
import 'package:uuid/uuid.dart';

class Home extends StatelessWidget {
  final UserAccess$Query$User user;
  const Home({
    required this.user,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: PageView(
              children: [
                Container(color: Colors.blue),
                Profile(
                  // userId: userId,
                  user: user,
                  key: Key("user_id_${user.id}")
                ),
              ],
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top:statusBar, left: 8, right: 8),
              height: 45,
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: const Text(
                        "Happ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800
                        )
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          // barrierDismissible: true,
                          // useSafeArea: false,
                          barrierColor: Colors.transparent,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, anim1, anim2) {
                            return Search(key: Key(const Uuid().v4()));
                          }
                        );
                      },
                      child: const SizedBox(
                        height: 45,
                        width: 45,
                        // decoration: BoxDecoration(
                        //   // color: Colors.grey[350],
                        //   shape: BoxShape.circle
                        // ),
                        child: Icon(
                          EvaIcons.searchOutline,
                          size: 35
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Container(color: Colors.red,)
        ],
      ),
    );
  }
}