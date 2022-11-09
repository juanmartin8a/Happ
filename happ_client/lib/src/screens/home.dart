import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/my_flutter_app_icons.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/search/search.dart';
import 'package:happ_client/src/utils/widgets/screenTabWrapper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';

import 'events/newEvent.dart';

class Home extends StatefulWidget {
  final UserAccess$Query$User user;
  const Home({
    required this.user,
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
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).viewPadding.top;
    // print()
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            // height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              viewportFraction: 1.03,
              // isScrollable: true,
              // labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              children: [
                FractionallySizedBox(
                  widthFactor: 1 / 1.03,
                  child: ScreenTabWrapper(
                    child: Container(
                      color: Colors.white
                    ),
                    key: const Key("homeTab")
                  ),
                ),
                // Container(color: Colors.blue),
                FractionallySizedBox(
                  widthFactor: 1 / 1.03,
                  child: ScreenTabWrapper(
                    child: Search(key: Key(const Uuid().v4())),
                    key: const Key("searchTab")
                  )
                ),
                const FractionallySizedBox(
                  widthFactor: 1 / 1.03,                                                                      
                  child: ScreenTabWrapper(
                    child: NewEvent(),
                    key: const Key("newEventTab")
                  )
                ),
                FractionallySizedBox(
                  widthFactor: 1 / 1.03,
                  child: ScreenTabWrapper(
                    child: Profile(
                      // userId: userId,
                      user: widget.user, 
                      key: Key("user_id_${widget.user.id}")
                    ),
                    key: const Key("profileTab")
                  ),
                ),
              ]
            ),
          ),
          Container(
            // height: 70,

            color: Colors.black,
            padding: EdgeInsets.only(
              // top: 8,
              bottom: MediaQuery.of(context).padding.bottom
            ),
            child: Container(
              color: Colors.black,
              height: 36,
              child: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                // indicatorSize: ,
                // isScrollable: ,
                tabs: const [
                  Tab(
                    child: Icon(
                      FluentIcons.home_16_regular,
                      size: 28,
                      color: Colors.white
                    ),
                  ),
                  Tab(
                    child: Icon(
                      FluentIcons.search_16_regular,
                      size: 28,
                      color: Colors.white
                    ),
                  ),
                  Tab(
                    child: Icon(
                      FluentIcons.add_square_24_regular,
                      size: 28,
                      color: Colors.white
                    ),
                  ),
                  Tab(
                    child: Icon(
                      FluentIcons.person_16_regular,
                      size: 28,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            )
      //       Container(
      //         color: Colors.black,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: const [
      //             Icon(
      //               FluentIcons.home_16_regular,
      //               size: 30,
      //               color: Colors.white
      //             ),
      //             Icon(
      //               FluentIcons.search_16_regular,
      //               size: 30,
      //               color: Colors.white
      //             ),
      //             Icon(
      //               FluentIcons.add_square_24_regular,
      //               size: 30,
      //               color: Colors.white
      //             ),
      //             Icon(
      //               FluentIcons.person_16_regular,
      //               size: 30,
      //               color: Colors.white
      //             ),

      //             // Icon(
      //             //   FluentIcons.home_24_regular,
      //             //   size: 35,
      //             //   color: Colors.white
      //             // ),
      //             // Icon(
      //             //   FluentIcons.search_12_regular,
      //             //   size: 35,
      //             //   color: Colors.white
      //             // ),
      //             // Icon(
      //             //   FluentIcons.add_square_24_regular,
      //             //   size: 35,
      //             //   color: Colors.white
      //             // ),
      //             // Icon(
      //             //   FluentIcons.person_16_regular,
      //             //   size: 35,
      //             //   color: Colors.white
      //             // ),
      //           ],
      //         ),
            // ),
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
    );
  }
}