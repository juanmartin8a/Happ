import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventGuests/eventGuests.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListAction.dart';
import 'package:happ_client/src/riverpod/guestListAction/guestListActionState.dart';
import 'package:happ_client/src/riverpod/removeGuestSelect/removeGuestSelect.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/screens/events/guestList/widgets/editGuestButton.dart';
import 'package:happ_client/src/screens/events/guestList/widgets/guestListGuests.dart';
import 'package:happ_client/src/screens/events/guestList/widgets/guestListHosts.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

class GuestList extends ConsumerStatefulWidget {
  final int eventId;
  final bool isHost;
  final bool isCreator;
  final GetEventHosts$Query$PaginatedEventUsersResults paginatedHostsRes;
  final GetEventGuests$Query$PaginatedEventUsersResults paginatedGuestRes;
  const GuestList({
    required this.eventId,
    required this.isHost,
    required this.isCreator,
    required this.paginatedHostsRes,
    required this.paginatedGuestRes,
    super.key
  });

  @override
  _GuestListState createState() => _GuestListState();
}

class _GuestListState extends ConsumerState<GuestList> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  bool isButtonDelete = false;

  bool selectMode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(guestListActionProvider, (prev, next) {
      if (next is GuestListActionRemoveState) {
        setState(() {
          selectMode = true;
        });
      } else {
        setState(() {
          selectMode = false;
        });
        if (next is GuestListActionAddState) {
          if (_tabController.index == 0) {
            context.push('/invite-guests', extra: InviteGuestsScreenParams(
                eventId: widget.eventId,
                isCreator: widget.isCreator,
                isHosts: true
              )
            );
          } else if (_tabController.index == 1) {
            context.push('/invite-guests', extra: InviteGuestsScreenParams(
                eventId: widget.eventId,
                isCreator: widget.isCreator,
              )
            );
          }
        }
      }
    });
    
    final statusBar = MediaQuery.of(context).padding.top;
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: statusBar),
              SizedBox(
                height: 45,
                child: Stack(
                  children: [
                    Center(
                      // heightFactor: 100,
                      // width
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // AnimatedBuilder(
                          //   animation: _tabController.animation!,
                          //   builder: (context, widget) {
                          //     return Container(
                          //       width: 7,
                          //       height: 7,
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: ColorTween(begin: Colors.deepPurpleAccent, end: Colors.greenAccent[400]).animate(_tabController.animation!).value,
                          //         // color: Color(0xFFFFA500)
                          //         // color: Colors.lightBlue
                          //         // boxShadow: [
                          //         //   BoxShadow(
                          //         //     color: Colors.black.withOpacity(0.1),
                          //         //     spreadRadius: 1,
                          //         //     blurRadius: 2,
                          //         //   ),
                          //         // ],
                          //       ),
                          //     );
                          //   }
                          // ),
                          // const SizedBox(width: 4),
                          Text(
                            "Guest list",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 19,
                              // letterSpacing: 0.5,
                              // fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              // height: 1
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      height: 45,
                      child: GestureDetector(
                        onTap: () {
                          invalidateProviders();
                          Navigator.pop(context);
                        },
                        child: FloatingActions(
                          icon: EvaIcons.arrowBackOutline,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          color: Colors.grey[800]!,
                          size: 36,
                          key: Key("goBack_guestList${widget.eventId}")
                        ),
                      )
                    ),
                  ],
                )
              ),
              SizedBox(
                height: 34,
                // padding: EdgeInsets.only(top: statusBar),
                // color: Colors.red,
                width: 150,
                child: TabBar(
                  overlayColor:MaterialStateProperty.all<Color>(Colors.transparent),
                  // physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  // indicatorColor: Colors.black,
                  indicatorWeight: 0,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const BubbleTabIndicator(
                    indicatorHeight: 32,
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
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          // padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                          // height: 35,
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Hosts",
                            style: TextStyle(
                              // fontFamily: "Roboto",
                              // fontStyle: FontStyle.,
                              color: ColorTween(begin: Colors.white, end: Colors.grey[800]).animate(_tabController.animation!).value,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1
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
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          // padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                          // height: 35,
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Guests",
                            style: TextStyle(
                              // fontFamily: "Roboto",
                              // fontStyle: FontStyle.,
                              color: ColorTween(begin: Colors.grey[800], end: Colors.white).animate(_tabController.animation!).value,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1
                            )
                          )
                        );
                      }
                    )
                  ],
                ),
              ),
              Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children:  [
                  GuestListHosts(
                    eventId: widget.eventId,
                    isCreator: widget.isCreator,
                    paginatedHostsRes: widget.paginatedHostsRes,
                    selectMode: widget.isCreator ? selectMode : false,
                    key: Key("guestList_hosts_${widget.eventId}")
                  ),
                  GuestListGuests(
                    eventId: widget.eventId,
                    isCreator: widget.isCreator,
                    paginatedGuestsRes:  widget.paginatedGuestRes,
                    selectMode: widget.isHost ? selectMode : false,
                    key: Key("guestList_guests_${widget.eventId}")
                  ),
                ]
              ),
            )
            ],
          ),
          if (widget.isHost && !widget.isCreator)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom > 34 
            ? MediaQuery.of(context).padding.bottom + 12 
            : 34 * 0.75,
            right: MediaQuery.of(context).padding.bottom > 34 
            ? 12 
            : 34 * 0.75,
            child: AnimatedBuilder(
              animation: _tabController.animation!, 
              builder: (context, child) {
                final opacityTween = Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(_tabController.animation!);
                return Opacity(
                  opacity: opacityTween.value,
                  child: EditGuestButton(opacity: opacityTween.value, eventId: widget.eventId)
                );
              }
            ),
          ),
          if (widget.isHost && widget.isCreator)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom > 34
            ? MediaQuery.of(context).padding.bottom + 12
            : 34 * 0.75,
            right: MediaQuery.of(context).padding.bottom > 34
            ? 12
            : 34 * 0.75,
            child: EditGuestButton(opacity: 1.0, eventId: widget.eventId)
          ),
        ],
      ),
    );
  }

  void invalidateProviders() {
    ref.invalidate(guestListActionProvider);
    ref.invalidate(eventGuestsProvider);
    ref.invalidate(removeGuestSelectProvider);
  }
}