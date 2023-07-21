import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/addNewGuestsSelectState.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddToEventState.dart';
import 'package:happ_client/src/screens/events/updateEvent/widgets/searchFUTAAGInviteTile.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsScreen.dart';

class SearchInviteGuestsResults extends ConsumerStatefulWidget {
  final bool isEmpty;

  const SearchInviteGuestsResults({
    required this.isEmpty,
    super.key
  });

  @override
  _SearchInviteGuestsResultsState createState() => _SearchInviteGuestsResultsState();
}

class _SearchInviteGuestsResultsState extends ConsumerState<SearchInviteGuestsResults> {

  List<SearchForUsersToAddToEvent$Query$User> selectedUsers = [];
  List<int> selectedUsersIds = [];

  List<SearchForUsersToAddToEvent$Query$User> searchUsersRes = [];

  bool searchErr = false;
  bool searchIsLoaded = false;

  @override
  Widget build(BuildContext context) {

    ref.listen(addNewGuestsSelectProvider, (prev, next) {
      if (next is AddNewGuestsSelectedState) {
        setState(() {
          selectedUsersIds.add(next.user.id);
          selectedUsers.add(next.user);
        });
      } else if (next is AddNewGuestsRemoveState) {
        setState(() {
          selectedUsersIds.removeWhere((item) => item == next.userId);
          selectedUsers.removeWhere((item) => item.id == next.userId);
        });
      } else if (next is AddNewGuestsInitState) {
        setState(() {
          searchUsersRes.removeWhere((user) => selectedUsersIds.contains(user.id));
          selectedUsersIds = [];
          selectedUsers = [];
        });
      }
    });

    ref.listen(searchProvider, (prev, next) {
      bool changes = false;
      bool searchErrTemp = false;
      bool searchIsLoadedTemp = false;

      if (next is SearchForUsersToAddToEventLoadedState) {
        setState(() {
          searchUsersRes = next.searchUsersRes;
          searchIsLoaded = true;
        });
      } else if (next is SearchForUsersToAddToEventErrorState) {
        changes = true;
        searchErrTemp = true;
        searchIsLoadedTemp = false;
      } else if (next is !SearchForUsersToAddToEventLoadedState) {
        changes = true;
        searchIsLoadedTemp = false;
      }

      if (changes == true) {
        setState(() {
          searchErr = searchErrTemp;
          searchIsLoaded = searchIsLoadedTemp;
        });
      }
    });

    // SearchForUsersToAddToEventState searchUserState = ref.watch(searchProvider);

    if (searchErr) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(top: 150),
          color: Colors.transparent,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Sorry, we could not find any users D:\n",
              style: TextStyle(
                fontFamily: "Inter",
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),
              children: <TextSpan>[
                if (Platform.isIOS) const TextSpan(text: '😓🐄', style: TextStyle(fontSize: 20))
              ]
            )
          )
        ),
      );
    }

    if (widget.isEmpty || !searchIsLoaded) {
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          if (selectedUsers.isNotEmpty)
          ...selectedUsers.map((user) {
            return SearchFUTAAGInviteTile(
              user: user,
              isSelected: selectedUsersIds.contains(user.id),
              isOrganizer: false,
              key: Key("searchFUTAAGIntiveTile_select_${user.id}")
            );
          }).toList(),
          
          if (selectedUsers.isEmpty)
          Container(
            padding: const EdgeInsets.only(top: 150),
            color: Colors.transparent,
            child: Center(
              child: 
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Pick friends to join the fun!",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  children: <TextSpan>[
                    if (Platform.isIOS) const TextSpan(text: '\n😉', style: TextStyle(fontSize: 20)),
                    if (!Platform.isIOS) const TextSpan(text: ' ;)')
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
                  text: "Sorry, we could not find any users D:\n",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),
                  children: <TextSpan>[
                    if (Platform.isIOS) const TextSpan(text: '😓🐄', style: TextStyle(fontSize: 20))
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
        return SearchFUTAAGInviteTile(
          user: searchUsersRes[searchUserResIndex],
          isSelected: selectedUsersIds.contains(searchUsersRes[searchUserResIndex].id),
          isOrganizer: false,
          key: Key("searchFUTAAGIntiveTile_${searchUsersRes[searchUserResIndex].id}")
        );
      }
    );
  }
}