import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/eventHosts/eventHosts.dart';
import 'package:happ_client/src/riverpod/eventHosts/eventHostsState.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/utils/widgets/loader.dart';

class GuestListHosts extends ConsumerStatefulWidget {
  final int eventId;
  final GetEventHosts$Query$PaginatedEventUsersResults paginatedHostsRes;
  const GuestListHosts({
    required this.eventId,
    required this.paginatedHostsRes,
    super.key
  });

  @override
  _GuestListHostsState createState() => _GuestListHostsState();
}

class _GuestListHostsState extends ConsumerState<GuestListHosts> with AutomaticKeepAliveClientMixin {

  ScrollController scrollController = ScrollController();

  List<GetEventHosts$Query$PaginatedEventUsersResults$User> hosts = [];
  List<int> userIds = [];

  bool isLoading = false;
  bool hasMore = true; 

  @override
  void initState() {
    super.initState();
    hosts = widget.paginatedHostsRes.users;
    userIds = hosts.map((user) => user.id).toList();
    hasMore = widget.paginatedHostsRes.hasMore;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (hasMore) {
        setState(() {
          isLoading = true;
        });
        ref.read(eventHostsProvider.notifier).getEventHosts(widget.eventId, 25, userIds);
      }
    });
    scrollController.addListener(() {
      if (hasMore) {
        final maxScrollExtent = scrollController.position.maxScrollExtent;
        final currentPos = scrollController.position.pixels;
        final screenHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + 34 + 45);

        if (currentPos >= (maxScrollExtent - screenHeight * 1.5)) {
          if (isLoading == false) {
            setState(() {
              isLoading = true;
            });
            ref.read(eventHostsProvider.notifier).getEventHosts(widget.eventId, 25, userIds);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(eventHostsProvider, (prev, next) {
      if (next is GetEventHostsDoneState) {
        setState(() {
          hosts = [...hosts, ...next.res.users];
          userIds = hosts.map((user) => user.id).toList();
          hasMore = next.res.hasMore;
          isLoading = false;
        });
      }
    });
    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics(),),
      children: [
        const SizedBox(
          height: 10,
        ),
        ...hosts.map((host) {
          return GestureDetector(
            onTap: () {
              final user = ProfileUserData.fromUserData(host);
              context.push('/profile', extra: ProfileParams(
                  user: user,
                )
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: Colors.transparent,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.network(
                        host.profilePic,
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        host.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                          height: 1
                        )
                      ),
                      const SizedBox(height: 2),
                      Text(
                        host.username,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1
                        ),
                      )
                    ],
                  )
                ],
              )
            ),
          );
        }).toList(),
        if (isLoading)
        const SizedBox(
          height: 30,
          child: Loader(radius: 8)
        ),
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}