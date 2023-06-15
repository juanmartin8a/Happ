import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/search/searchBar.dart';
import 'package:happ_client/src/screens/search/widgets/searchUserTile.dart';

class SearchResults extends ConsumerStatefulWidget {
  const SearchResults({super.key});

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends ConsumerState<SearchResults> {
  List<SearchUsers$Query$User> searchUsersRes = [];

  @override
  Widget build(BuildContext context) {

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

    if (ref.read(searchProvider) is SearchInitState) {
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
                  text: "Look for your friends!\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: '🔍', style: TextStyle(fontSize: 20))
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
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                "Results ;)",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 150),
              color: Colors.transparent,
              child: RichText(
                textAlign: TextAlign.center,
                
                text: TextSpan(
                  text: "Sorry, we could not find any users :(\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    if (Platform.isIOS) const TextSpan(text: '😰🦤', style: TextStyle(fontSize: 20))
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
        return GestureDetector(
          onTap: () {
            // print("Hello there");
            // final inviteRes = EventTypesConverter().convertOtherInviteResToFriendsInviteRes(invite);
            final user = ProfileUserData.fromSearchUsersQueryUser(searchUsersRes[searchUserResIndex]);
            context.push('/profile', extra: ProfileParams(
                user: user,
              )
            );
          },
          child: SearchUserTile(users: searchUsersRes, user: searchUsersRes[searchUserResIndex])
        );
      }
    );
  }
}