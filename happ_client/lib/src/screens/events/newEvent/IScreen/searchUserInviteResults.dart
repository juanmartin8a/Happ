import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/searchUserInviteTile.dart';

class SearchUserInviteResults extends ConsumerStatefulWidget {
  final bool isEmpty;
  const SearchUserInviteResults({
    required this.isEmpty,
    super.key
  });

  @override
  _SearchUserInviteResultsState createState() => _SearchUserInviteResultsState();
}

class _SearchUserInviteResultsState extends ConsumerState<SearchUserInviteResults> {
  List<int> selectedUsersIds = [];

  List<SearchUsers$Query$User> searchUsersRes = [];

  @override
  Widget build(BuildContext context) {

    ref.listen(inviteUserSelectProvider, (prev, next) {
      if (next is InviteUserSelectedState) {
        selectedUsersIds.add(next.user.id);
      } else if (next is InviteUserRemoveState) {
        selectedUsersIds.removeWhere((item) => item == next.userId);  
      }
    });

    ref.listen(searchProvider, (prev, next) {
      if (next is SearchLoadedState) {
        setState(() {
          searchUsersRes = next.searchUsersRes;
        });
      } else if (next is SearchErrorState) {
        setState(() {
          searchUsersRes = [];
        });
      } else if (next is !SearchLoadedState) {
        setState(() {
          searchUsersRes = [];
        });
      }
    });

    if (widget.isEmpty || ref.read(searchProvider) is SearchInitState) {
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 150),
            color: Colors.transparent,
            child: Center(
              child: 
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Pick friends to join the fun!\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: '😉', style: TextStyle(fontSize: 20))
                  ]
                )
              )
            )
          ),
          const SizedBox(height: 150)
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: searchUsersRes.length + 2,
      itemBuilder: (context, i) {
        if (i == 0) {
          if (searchUsersRes.isNotEmpty) {
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
                    TextSpan(text: '🫣🦖', style: TextStyle(fontSize: 20))
                  ]
                )
              )
            );
          }
        }

        if (i == (searchUsersRes.length + 2) - 1) {
          return const SizedBox(height: 150);
        }

        int searchUserResIndex = i - 1;
        return SearchUserInviteTile(
          user: searchUsersRes[searchUserResIndex],
          isSelected: selectedUsersIds.contains(searchUsersRes[searchUserResIndex].id),
          key: Key("searchUserIntiveTile_${searchUsersRes[searchUserResIndex].id}")
        );
      }
    );
  }
}