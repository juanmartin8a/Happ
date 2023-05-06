import 'dart:ui';

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
import 'package:happ_client/src/screens/settings/settings.dart';
import 'package:happ_client/src/utils/indicators/circularTabIndicator.dart';
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
    // print("bottom: ${MediaQuery.of(context).padding.bottom}");
    return AnnotatedRegion<SystemUiOverlayStyle>( 
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        top: false,
        bottom: false,
        // maintainBottomViewPadding: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Stack(
            // padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  viewportFraction: 1.03,
                  // isScrollable: true,
                  // labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                  children: const [
                    FractionallySizedBox(
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
                        key: Key("searchTab"),
                        child: Search(key: Key("search")),
                      )
                    ),
                    FractionallySizedBox(
                      widthFactor: 1 / 1.03,                                                                      
                      child: ScreenTabWrapper(
                        key: Key("newEventTab"),
                        child: NewEvent(),
                      )
                    ),
                    FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: Key("settings Tab"),
                        child: Settings()
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
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: Container(
                    color: Colors.white,
                    height: 38 + MediaQuery.of(context).padding.bottom,//36,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    // margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                    // decoration: BoxDecoration(
                    //   color: Colors.red,
                    //   // border: Border(
                    //   //   top: BorderSide(color: Colors.grey[200]!, width: 1)
                    //   // )
                    // ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                      child: TabBar(
                        // labelColor: Colors.red,
                        controller: _tabController,
                        labelPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        // indicator: CircularTabIndicator(color: Colors.greenAccent[700]!, radius: 2.5),
                        indicator: const BoxDecoration(),
                        // indicatorWeight: 0,
                        // indicatorSize: TabBa,
                        indicatorSize: TabBarIndicatorSize.tab,
                        // isScrollable: ,
                        tabs: [
                          AnimatedBuilder(
                            animation: _tabController.animation!,
                            builder: (context, child) {
                              return Tab(
                                // height: 36,
                                child: Icon(
                                  _tabController.index == 0
                                  ? FluentIcons.home_16_filled
                                  : FluentIcons.home_16_regular,
                                  size: 30,
                                  color: _tabController.index == 0 ? Colors.black : Colors.grey[850]
                                ),
                              );
                            }
                          ),
                          AnimatedBuilder(
                            animation: _tabController.animation!,
                            builder: (context, child) {
                              return Tab(
                                child: Icon(
                                  EvaIcons.search,
                                  size: 30,
                                  color: _tabController.index == 1 ? Colors.black : Colors.grey[850]
                                ),
                              );
                            }
                          ),
                          AnimatedBuilder(
                            animation: _tabController.animation!,
                            builder: (context, child) {
                              return Tab(
                                child: Icon(
                                  _tabController.index == 2
                                  ? FluentIcons.add_square_24_filled
                                  : FluentIcons.add_square_24_regular,
                                  size: 30,
                                  color: _tabController.index == 2 ? Colors.black : Colors.grey[850]
                                ),
                              );
                            }
                          ),
                          AnimatedBuilder(
                            animation: _tabController.animation!,
                            builder: (context, child) {
                              return Tab(
                                child: Icon(
                                  // _tabController.index == 3
                                  // ? FluentIcons.settings_16_filled
                                  // : FluentIcons.settings_16_regular,
                                  EvaIcons.menu,
                                  size: 30,
                                  color: _tabController.index == 3 ? Colors.black : Colors.grey[850]
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
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

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? currentToken = await messaging.getToken();

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