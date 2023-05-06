import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/searchUserInviteTile.dart';

class SearchUserInviteResults extends ConsumerStatefulWidget {
  // final bool isSearchRes;
  const SearchUserInviteResults({
    // required this.isSearchRes,
    super.key
  });

  @override
  _SearchUserInviteResultsState createState() => _SearchUserInviteResultsState();
}

class _SearchUserInviteResultsState extends ConsumerState<SearchUserInviteResults> {
  List<int> selectedUsersIds = [];

  @override
  Widget build(BuildContext context) {

    ref.listen(inviteUserSelectProvider, (prev, next) {
      if (next is InviteUserSelectedState) {
        selectedUsersIds.add(next.user.id);
      } else if (next is InviteUserRemoveState) {
        selectedUsersIds.removeWhere((item) => item == next.userId);  
      }
    });

    SearchState searchUserState = ref.watch(searchProvider);

    if (searchUserState is !SearchLoadedState) {
      return const SizedBox();
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: searchUserState.searchUsersRes.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          if (searchUserState.searchUsersRes.isNotEmpty) {
            return Container();
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 150),
              color: Colors.transparent,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Sorry, we could not find any users ;(\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: '🫣🦖', style: TextStyle(fontSize: 22))
                  ]
                )
              )
            );
          }
        }
        int searchUserResIndex = i - 1;
        return SearchUserInviteTile(
          user: searchUserState.searchUsersRes[searchUserResIndex],
          isSelected: selectedUsersIds.contains(searchUserState.searchUsersRes[searchUserResIndex].id),
          key: Key("searchUserIntiveTile_${searchUserState.searchUsersRes[searchUserResIndex].id}")
        );
      }
    );
  }
}