import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'package:happ_client/src/riverpod/search/search.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';
import 'package:happ_client/src/screens/events/newEvent/IScreen/searchUserInviteResults.dart';
import 'package:happ_client/src/screens/search/class/SearchUserInviteResParams.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

final searchProvider =
  StateNotifierProvider<SearchController, SearchState>(
    (ref) {
      final UserFromId$Query$User currentUser = ref.read(currentUserProvider)!;
      return SearchController(currentUser: currentUser);
    }
  );

class IScreen extends ConsumerStatefulWidget {
  final int eventId;
  const IScreen({
    required this.eventId,
    super.key
  });

  @override
  _IScreenState createState() => _IScreenState();
}

class _IScreenState extends ConsumerState<IScreen> {

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late int eventId;

  List<SearchUsers$Query$User> selectedUsers = [];
  List<SearchUsers$Query$User> organizers = [];
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

    ref.listen(inviteUserSelectProvider, (prev, next) {
      switch (next.runtimeType) {
        case InviteUserSelectedState:
          selectedUsers.insert(0, (next as InviteUserSelectedState).user);
          selectedUsersIds.add(next.user.id);
          callFieldChange();
          break;
        case InviteUserRemoveState:
          selectedUsers.removeWhere((item) => item.id == (next as InviteUserRemoveState).userId);
          selectedUsersIds.removeWhere((item) => item == (next as InviteUserRemoveState).userId);
          organizers.removeWhere((user) => user.id == (next as InviteUserRemoveState).userId);
          callFieldChange();
          break;
        case MakeOrganizerState:
          organizers.add((next as MakeOrganizerState).user);
          selectedUsers.removeWhere((item) => item.id == next.user.id);
          callFieldChange();
          break;
        case RemoveOrganizerState:
          organizers.removeWhere((user) => user.id == (next as RemoveOrganizerState).user.id);
          selectedUsers.insert(0, (next as RemoveOrganizerState).user);
          callFieldChange();
          break;
      }
    });

    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.only(
      //   right: 8,
      //   left: 8,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 45 + MediaQuery.of(context).padding.top,
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
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
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
                                fontSize: 15,
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
                                  fontSize: 15,
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
                                } else {
                                  if (isEmpty != false) {
                                    setState(() {
                                      isEmpty = false;
                                    });
                                  }
                                }
                                ref.read(searchProvider.notifier).searchUsers(values);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (widget.latitude != null)
                const SizedBox(width: 6),
                // if (widget.latitude != null)
                GestureDetector(
                  onTap: () {
                    // userLocationPermission();
                    NewEventInvitedFriendsListParams params = NewEventInvitedFriendsListParams(
                      eventId: eventId, 
                      selectedUsers: selectedUsers, 
                      organizers: organizers
                    );
                    context.push(
                      '/new-event-guest-list',
                      extra: params
                    );
                    // Navigator.of(context).push(
                    //   builder: () => InvitedFriendsList(

                    //     key: Key(),
                    //   )
                    // )
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ) 
                    ),
                    height: 40,
                    width: 50,
                    child: const Center(
                      child: Icon(
                        FluentIcons.clipboard_bullet_list_ltr_20_regular,
                        size: 30,
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          
          Expanded(
            child:SizedBox(
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: const SearchUserInviteResults()
            )
          )
        ],
      ),
    );
  }

  void callFieldChange() {
    List<int> organizerIDs = organizers.map((item) => item.id).toList();
    List<int> guestIDs = selectedUsers.map((item) => item.id).toList();
    ref.read(newEventCompleteProvider.notifier).fieldChange(
      guests: guestIDs,
      organizers: organizerIDs,
      eventId: widget.eventId,
    );
  }
}