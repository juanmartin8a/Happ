import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuests.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddAsGuests.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddAsGuestsState.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsButton.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsResults.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

final searchProvider =
  StateNotifierProvider<SearchForUsersToAddAsGuestsController, SearchForUsersToAddAsGuestsState>(
    (ref) => SearchForUsersToAddAsGuestsController()
  );

class InviteNewGuests extends ConsumerStatefulWidget {
  final int eventId;
  const InviteNewGuests({
    required this.eventId,
    super.key
  });

  @override
  _InviteNewGuestsState createState() => _InviteNewGuestsState();
}

class _InviteNewGuestsState extends ConsumerState<InviteNewGuests> {

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late int eventId;

  List<SearchForUsersToAddAsGuests$Query$User> selectedUsers = [];
  List<int> selectedUsersIds = [];

  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    eventId = widget.eventId;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // ref.listen(inviteUserSelectProvider, (prev, next) {
    //   switch (next.runtimeType) {
    //     case InviteUserSelectedState:
    //       selectedUsers.insert(0, (next as InviteUserSelectedState).user);
    //       selectedUsersIds.add(next.user.id);
    //       callFieldChange();
    //       break;
    //     case InviteUserRemoveState:
    //       selectedUsers.removeWhere((item) => item.id == (next as InviteUserRemoveState).userId);
    //       selectedUsersIds.removeWhere((item) => item == (next as InviteUserRemoveState).userId);
    //       organizers.removeWhere((user) => user.id == (next as InviteUserRemoveState).userId);
    //       callFieldChange();
    //       break;
    //     case MakeOrganizerState:
    //       organizers.add((next as MakeOrganizerState).user);
    //       selectedUsers.removeWhere((item) => item.id == next.user.id);
    //       callFieldChange();
    //       break;
    //     case RemoveOrganizerState:
    //       organizers.removeWhere((user) => user.id == (next as RemoveOrganizerState).user.id);
    //       selectedUsers.insert(0, (next as RemoveOrganizerState).user);
    //       callFieldChange();
    //       break;
    //   }
    // });

    // ref.listen(searchProvider, (prev, next) {
    //   if (next is SearchForUsersToAddAsGuestsInitState) {
    //     setState(() {
    //       isEmpty = true;
    //       _textEditingController.text = "";
    //     });
    //   }
    // });

    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                height: 45,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          invalidateProviders();
                          Navigator.pop(context);
                        },
                        child: FloatingActions(
                          icon: EvaIcons.arrowBackOutline,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          // padding:  EdgeInsets.zero,
                          color: Colors.grey[800]!,
                          size: 36,
                          key: Key("goBack_inviteGuestScreen_${widget.eventId}")
                        )
                      ),
                    ),
                    // const Spacer(),
                    Center(
                      child: Text(
                        "Add Guests",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          // letterSpacing: 0.5,
                          // fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          // height: 1
                        ),
                      ),
                    ),
                    // const Spacer(),
                    // const Spacer(),
                  ],
                )
              ),
              const SizedBox(
                height: 20
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Invite Friends!",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                    height: 1
                  )
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        height: 40,
                        child: Row(
                          children: [
                            const FloatingActions(
                              icon: EvaIcons.searchOutline,
                              size: 28,
                              color: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              key: Key("searchBarIcon")
                            ),
                            Expanded(
                              child: ClipRRect(
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  focusNode:  _focusNode,
                                  controller: _textEditingController,
                                  // cursorColor: Colors.black,
                                  clipBehavior: Clip.none,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardAppearance: Brightness.dark,
                                  style: TextStyle(
                                    color: Colors.grey[800]!,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.25
                                  ),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(left: 1, right: 8),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25
                                      // height: 2
                                    ),
                                  ),
                                  onChanged: (values) {
                                    if (values.isEmpty) {
                                      setState(() {
                                        isEmpty = true;
                                      });
                                      ref.read(searchProvider.notifier).backToInit();
                                    } else {
                                      if (isEmpty != false) {
                                        setState(() {
                                          isEmpty = false;
                                        });
                                      }
                                      ref.read(searchProvider.notifier).searchUsers(values, widget.eventId);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              
              Expanded(
                child:SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
                  child: SearchInviteGuestsResults(selectedUsers: [], isEmpty: isEmpty)
                )
              )
            ],
          ),
          Positioned(
            // bottom: 0,
            bottom: 34,
            left: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.5)) / 2,
            child: InviteGuestsButton(eventId: eventId)
          )
        ],
      ),
    );
  }

  // void callFieldChange() {
  //   List<int> organizerIDs = organizers.map((item) => item.id).toList();
  //   List<int> guestIDs = selectedUsers.map((item) => item.id).toList();
  //   ref.read(newEventCompleteProvider.notifier).fieldChange(
  //     guests: guestIDs,
  //     organizers: organizerIDs,
  //     eventId: widget.eventId,
  //   );
  // }
  void invalidateProviders() {
    ref.invalidate(addNewGuestsSelectProvider);
    ref.invalidate(searchProvider);
    ref.invalidate(addGuestsProvider);
  }
}