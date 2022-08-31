import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/search/search.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';
import 'package:happ_client/src/screens/search/widgets/searchUserTile.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Results ;)",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 15,
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
                  text: "Sorry, could not find any users T_T\n",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: '🤥💀', style: TextStyle(fontSize: 28))
                  ]
                )
              )
            );
          }
        }
        int searchUserResIndex = i - 1;
        return SearchUserTile(user: searchUserState.searchUsersRes[searchUserResIndex]);
      }
    );
  }
}