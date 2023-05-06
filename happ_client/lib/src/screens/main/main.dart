import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/screens/main/AllEventInvitations.dart';
import 'package:happ_client/src/screens/main/userEvents.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 1);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(userEventsProvider.notifier).getUserEvents();
    // });
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    // UserEventState state = ref.watch(userEventsProvider);
    // // print(state);
    // if (state is UserEventsLoadedState) {
    //   print(state.events);
    // }
    // Show invitations && events accetpted && other event invitations
    // Events going
    // invitations from user friends
    // invitations from other people
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: statusBar + 45,
            padding: EdgeInsets.only(top: statusBar),
            // color: Colors.red,
            width: 210,
            child: Center(
              child: TabBar(
                // physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorWeight: 0,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BubbleTabIndicator(
                  indicatorHeight: 35,
                  indicatorColor: Colors.black,
                  tabBarIndicatorSize: TabBarIndicatorSize.label,
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                ),
                tabs: [
                  AnimatedBuilder(
                    animation: _tabController.animation!,
                    builder: (context, widget) {
                      return Container(
                        // color: Colors.yellow,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        // padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                        // height: 35,
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Events",
                          style: TextStyle(
                            // fontFamily: "Roboto",
                            // fontStyle: FontStyle.,
                            color: ColorTween(begin: Colors.white, end: Colors.black).animate(_tabController.animation!).value,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            // height: 1
                          )
                        )
                      );
                    }
                  ),
                  AnimatedBuilder(
                    animation: _tabController.animation!,
                    builder: (context, widget) {
                      return Container(
                        // color: Colors.yellow,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        // padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                        // height: 35,
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Invitations",
                          style: TextStyle(
                            // fontFamily: "Roboto",
                            // fontStyle: FontStyle.,
                            color: ColorTween(begin: Colors.black, end: Colors.white).animate(_tabController.animation!).value,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            // height: 1
                          )
                        )
                      );
                    }
                  )
                ],
              )
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                MainEvents(),
                AllEventInvitations(),
              ]
            ),
          )
        ],
      )
    );
  }
}