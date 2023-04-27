import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/my_flutter_app_icons.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/screens/events/newEvent.dart';
import 'package:happ_client/src/screens/main/main.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/search/search.dart';
import 'package:happ_client/src/utils/widgets/screenTabWrapper.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

import 'events/event.dart';

class Home extends StatefulWidget {
  // final UserAccess$Query$User user;
  const Home({
    // required this.user,
    Key? key
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }

// class Home extends StatelessWidget {
  // final UserAccess$Query$User user;
  // const Home({
  //   required this.user,
  //   Key? key
  // }) : super(key: key);
  // TabController tabController = TabController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    askForNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    // final statusBar = MediaQuery.of(context).viewPadding.top;
    // print()
    return AnnotatedRegion<SystemUiOverlayStyle>( 
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        top: false,
        bottom: true,
        // maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Column(
            // padding: EdgeInsets.zero,
            children: [
              Expanded(
                // height: MediaQuery.of(context).size.height - (40 + 34),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: TabBarView(
                  controller: _tabController,
                  viewportFraction: 1.03,
                  // isScrollable: true,
                  // labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                  children: [
                    const FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: Key("homeTab"),
                        child: MainScreen(),
                      ),
                    ),
                    // Container(color: Colors.blue),
                    FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: const Key("searchTab"),
                        child: Search(key: Key(const Uuid().v4())),
                      )
                    ),
                    const FractionallySizedBox(
                      widthFactor: 1 / 1.03,                                                                      
                      child: ScreenTabWrapper(
                        key: Key("newEventTab"),
                        child: NewEvent(),
                      )
                    ),
                    FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: const Key("profileTab"),
                        child: Container()
                        // Profile(
                        //   // userId: userId,
                        //   user: widget.user, 
                        //   key: Key("user_id_${widget.user.id}")
                        // ),
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(
                // color: Colors.red,
                height: 36,//36,
                // width: MediaQuery.of(context).size.width * 0.8,
                child: TabBar(
                  controller: _tabController,
                  labelPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(),
                  indicatorWeight: 0,
                  // indicatorSize: TabBa,
                  // indicatorSize: ,
                  // isScrollable: ,
                  tabs: [
                    Tab(
                      child: Icon(
                        FluentIcons.home_16_regular,
                        size: 28,
                        color: Colors.grey[600]
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FluentIcons.search_16_regular,
                        size: 28,
                        color: Colors.grey[600]
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FluentIcons.add_square_24_regular,
                        size: 28,
                        color: Colors.grey[600]
                      ),
                    ),
                    Tab(
                      child: Icon(
                        FluentIcons.person_16_regular,
                        size: 28,
                        color: Colors.grey[600]
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
          // Stack(
          //   children: [
          //     Center(
          //       child: PageView(
          //         children: [
          //           Container(color: Colors.blue),
          //           Profile(
          //             // userId: userId,
          //             user: user,
          //             key: Key("user_id_${user.id}")
          //           ),
          //         ],
          //       )
          //     ),
          //     Align(
          //       alignment: Alignment.topCenter,
          //       child: Container(
          //         margin: EdgeInsets.only(top:statusBar, left: 8, right: 8),
          //         height: 45,
          //         color: Colors.transparent,
          //         child: Align(
          //           alignment: Alignment.center,
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: [
          //               Container(
          //                 color: Colors.transparent,
          //                 child: const Text(
          //                   "Happ",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 30,
          //                     fontWeight: FontWeight.w800
          //                   )
          //                 ),
          //               ),
          //               const Spacer(),
          //               GestureDetector(
          //                 onTap: () {
          //                   showGeneralDialog(
          //                     context: context, 
          //                     // barrierDismissible: true,
          //                     // useSafeArea: false,
          //                     barrierColor: Colors.transparent,
          //                     transitionDuration: const Duration(milliseconds: 200),
          //                     pageBuilder: (context, anim1, anim2) {
          //                       return Search(key: Key(const Uuid().v4()));
          //                     }
          //                   );
          //                 },
          //                 child: const SizedBox(
          //                   height: 45,
          //                   width: 45,
          //                   // decoration: BoxDecoration(
          //                   //   // color: Colors.grey[350],
          //                   //   shape: BoxShape.circle
          //                   // ),
          //                   child: Icon(
          //                     EvaIcons.searchOutline,
          //                     size: 35
          //                   )
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     // Container(color: Colors.red,)
          //   ],
          // ),
        ),
      ),
    );
  }

  void askForNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? currentToken = await messaging.getToken();
      print(currentToken);

      var box = Hive.box('myBox');

      var token = box.get("FCM_token");


      if (currentToken != null && token != currentToken) {
        try {
          await UserRepo().saveDevice(currentToken);
          box.put("FCM_token", currentToken);
        } catch(e) {
          print(e);
        } 
      }

      messaging.onTokenRefresh.listen((String newToken) async {
        try {
          await UserRepo().saveDevice(newToken);
          box.put("FCM_token", newToken);
        } catch(e) {
          print(e);
        } 
      });
    }
  }
}