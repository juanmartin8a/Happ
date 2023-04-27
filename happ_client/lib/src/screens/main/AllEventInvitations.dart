import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:happ_client/src/screens/main/widgets/invitationsFromFriends.dart' as fi;
import 'package:happ_client/src/screens/main/widgets/otherInvitations.dart' as oi;
import 'package:happ_client/src/utils/widgets/loader.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllEventInvitations extends ConsumerStatefulWidget {
  const AllEventInvitations({super.key});

  @override
  _AllEventInvitationsState createState() => _AllEventInvitationsState();
}

class _AllEventInvitationsState extends ConsumerState<AllEventInvitations> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late AnimationController _scaleController;

  // wait for both to be done and then fade in
  bool? friends;
  bool? other;

  @override
  void initState() {
    _scaleController = AnimationController(value: 0.0, vsync: this, upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Container(
      color: Colors.white,
      child: SmartRefresher(
        enablePullDown: true,
        // header: ClassicHeader(),
        
        header: CustomHeader(
          refreshStyle: RefreshStyle.Follow,
          onOffsetChange: (offset) {
            if (_refreshController.headerMode!.value != RefreshStatus.refreshing) {
              double adjustedOffset = offset - 20;
              _scaleController.value = (adjustedOffset > 0 ? adjustedOffset : 0) / 40.0;
            }
          },
          height: 60,
          builder: (child, status) {
            if (status == RefreshStatus.failed) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                margin: const EdgeInsets.only(top: 20),
                child: FadeTransition(
                  opacity: _scaleController,
                  child: ScaleTransition(
                    scale: _scaleController,
                    child: const Text(
                      "❌",
                      style: TextStyle(fontSize: 22, height: 1)
                    )
                  ),
                )
              );
            }
            if (status == RefreshStatus.completed) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                margin: const EdgeInsets.only(top: 20),
                child: FadeTransition(
                  opacity: _scaleController,
                  child: ScaleTransition(
                    scale: _scaleController,
                    child: const Text(
                      "😉",
                      style: TextStyle(fontSize: 22, height: 1)
                    )
                  ),
                )
              );
            }
            return Container(
              // color: Colors.red,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FadeTransition(
                opacity: _scaleController,
                child: ScaleTransition(
                  scale: _scaleController,
                  child: const Loader(radius: 8),
                ),
              ),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: () async {
          final res = await Future.wait([
            ref.read(fi.userEventsProvider.notifier).getUserEventsFromFriends(8, [], isRefresh: true),
            ref.read(oi.userEventsProvider.notifier).getUserOtherEvents(8, [], isRefresh: true)
          ]);

          bool hasErr = false;

          for (int i = 0; i < res.length; i++) {
            if (res[i] == null) {
              hasErr = true;
            } else {
              if (i == 0) {
                ref.read(fi.userEventsProvider.notifier).refreshEventsFromFriends(res[i] as GetUserEventsFromFriends$Query$PaginatedEventResults);
              } else {
                ref.read(oi.userEventsProvider.notifier).refreshOtherEvents(res[i] as GetUserOtherEvents$Query$PaginatedEventResults);
              }
            }
          }

          if (!hasErr) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshFailed();
          }
        },
        physics: const AlwaysScrollableScrollPhysics(),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fi.InvitationsFromFriends(
                ready: friends == null
                  ? null
                  : friends == true && other == true
                    ? true
                    : false,
                friendsOtherDoneFunc: friends != null ? null : friendsOtherDoneFunc,
                key: const Key("friendInvitations")
              ),
        
              oi.OtherInvitations(
                ready: other == null
                  ? null 
                  : friends == true && other == true
                    ? true
                    : false,
                friendsOtherDoneFunc: other != null ? null : friendsOtherDoneFunc,
                key: const Key("OtherInvitations")
              )
            ]
          )
        ),
      ),
    );
  }

  void friendsOtherDoneFunc(bool isFriends, bool value) {
    setState(() {
      if (isFriends) {
        friends = value;
      } else {
        other = value;
      }
    });
  }
  
  @override
  bool get wantKeepAlive => true;
}