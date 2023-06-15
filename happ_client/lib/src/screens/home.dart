import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/repos/userRepo.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/screens/events/newEvent.dart';
import 'package:happ_client/src/screens/main/main.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/search/search.dart';
import 'package:happ_client/src/utils/widgets/screenTabWrapper.dart';
import 'package:hive/hive.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    Key? key
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    askForNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>( 
      // value: SystemUiOverlayStyle.dark,
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top status bar
        systemNavigationBarColor: Colors.transparent, // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.light, //navigation bar icons' color
        
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _tabController,
                  viewportFraction: 1.03,
                  children: [
                    const FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: Key("homeTab"),
                        child: MainScreen(),
                      ),
                    ),
                    const FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: Key("searchTab"),
                        child: Search(key: Key("search")),
                      )
                    ),
                    const FractionallySizedBox(
                      widthFactor: 1 / 1.03,                                                                      
                      child: ScreenTabWrapper(
                        key: Key("newEventTab"),
                        child: NewEvent(),
                      )
                    ),
                    // FractionallySizedBox(
                    //   widthFactor: 1 / 1.03,
                    //   child: ScreenTabWrapper(
                    //     key: Key("settings Tab"),
                    //     child: Settings()
                    //   ),
                    // ),
                    FractionallySizedBox(
                      widthFactor: 1 / 1.03,
                      child: ScreenTabWrapper(
                        key: const Key("profileTab"),
                        child: Builder(
                          builder: (context) {
                            final user = ProfileUserData.fromUserData(ref.read(currentUserProvider)!);
                            return Profile(
                              user: user,
                              key: const Key("currentUserProfile"),
                              comesFromMain: true,
                            );
                          }
                        )
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
                    height: 38 + MediaQuery.of(context).padding.bottom,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                      child: TabBar(
                        controller: _tabController,
                        labelPadding: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        indicator: const BoxDecoration(),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          AnimatedBuilder(
                            animation: _tabController.animation!,
                            builder: (context, child) {
                              return Tab(
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
                                  _tabController.index == 3
                                  ? FluentIcons.person_16_filled
                                  : FluentIcons.person_16_regular,
                                  // EvaIcons.profile,
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
          debugPrint(e.toString());
        } 
      }

      messaging.onTokenRefresh.listen((String newToken) async {
        try {
          await UserRepo().saveDevice(newToken);
          box.put("FCM_token", newToken);
        } catch(e) {
          debugPrint(e.toString());
        } 
      });
    }
  }
}