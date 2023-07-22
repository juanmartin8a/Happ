import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/riverpod/addGuests/addGuests.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/AddNewGuestsSelect.dart';
import 'package:happ_client/src/riverpod/addNewGuestsSelect/addNewGuestsSelectState.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelect.dart';
import 'package:happ_client/src/riverpod/inviteUserSelect/inviteUserSelectState.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddToEvent.dart';
import 'package:happ_client/src/riverpod/searchForUsersToAddAsGuests/searchForUsersToAddToEventState.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsButton.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsResults.dart';
import 'package:happ_client/src/screens/search/class/SearchUserInviteResParams.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

final searchProvider =
  StateNotifierProvider<SearchForUsersToAddToEventController, SearchForUsersToAddToEventState>(
    (ref) => SearchForUsersToAddToEventController()
  );

class InviteNewGuests extends ConsumerStatefulWidget {
  final int eventId;
  final bool isCreator;
  final bool isHosts;
  const InviteNewGuests({
    required this.eventId,
    required this.isCreator,
    this.isHosts = false,
    super.key
  });

  @override
  _InviteNewGuestsState createState() => _InviteNewGuestsState();
}

class _InviteNewGuestsState extends ConsumerState<InviteNewGuests> {

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late int eventId;

  List<SearchForUsersToAddToEvent$Query$User> selectedUsers = [];
  // List<int> selectedUsersIds = [];

  List<SearchForUsersToAddToEvent$Query$User> hosts = [];
  // List<int> hostIds = [];

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

    ref.listen(uInviteUserSelectProvider, (prev, next) {
      switch (next.runtimeType) {
        case UInviteUserSelectedState:
          selectedUsers.insert(0, (next as UInviteUserSelectedState).user);
          break;
        case UInviteUserRemoveState:
          selectedUsers.removeWhere((item) => item.id == (next as UInviteUserRemoveState).userId);
          hosts.removeWhere((user) => user.id == (next as UInviteUserRemoveState).userId);
          break;
        case UMakeOrganizerState:
          hosts.add((next as UMakeOrganizerState).user);
          selectedUsers.removeWhere((item) => item.id == next.user.id);
          break;
        case URemoveOrganizerState:
          hosts.removeWhere((user) => user.id == (next as URemoveOrganizerState).user.id);
          selectedUsers.insert(0, (next as URemoveOrganizerState).user);
          break;
      }
    });

    ref.listen(addNewGuestsSelectProvider, (prev, next) {
      if (next is AddNewGuestsSelectedState) {
        setState(() {
          selectedUsers.add(next.user);
        });
      } else if (next is AddNewGuestsRemoveState) {
        setState(() {
          selectedUsers.removeWhere((item) => item.id == next.userId);
          hosts.removeWhere((item) => item.id == next.userId);
        });
      } else if (next is AddNewGuestsInitState) {
        setState(() {
          selectedUsers = [];
          hosts = [];
        });
      }
    });

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
                        !widget.isHosts ? "Add Guests" : "Add Hosts",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 19,
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
                    fontSize: 17,
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
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            bottomLeft: const Radius.circular(20),
                            topRight: widget.isCreator ? const Radius.circular(8) : const Radius.circular(20),
                            bottomRight: widget.isCreator ? const Radius.circular(8) : const Radius.circular(20),
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
                    if (widget.isCreator)
                    const SizedBox(width: 6),

                    if (widget.isCreator)
                    GestureDetector(
                      onTap: () {
                        // userLocationPermission();

                        NewGuestsListParams params = NewGuestsListParams(
                          eventId: eventId, 
                          users: selectedUsers, 
                          organizers: hosts,
                          isCreator: widget.isCreator
                        );
                        context.push(
                          '/updated-guest-list',
                          extra: params
                        );
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
                  child: SearchInviteGuestsResults(isEmpty: isEmpty)
                )
              )
            ],
          ),
          Positioned(
            // bottom: 0,
            bottom: MediaQuery.of(context).padding.bottom > 34 ? MediaQuery.of(context).padding.bottom + 12 : 34,
            left: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.5)) / 2,
            child: InviteGuestsButton(eventId: eventId)
          )
        ],
      ),
    );
  }

  void invalidateProviders() {
    ref.invalidate(addNewGuestsSelectProvider);
    ref.invalidate(searchProvider);
    ref.invalidate(addGuestsProvider);
  }
}