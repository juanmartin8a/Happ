import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/api/graphql/graphql_api.graphql.dart';
import 'package:happ_client/src/riverpod/currentUser/currentUser.dart';
import 'package:happ_client/src/riverpod/search/search.dart';
import 'package:happ_client/src/riverpod/search/searchState.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

final searchProvider =
  StateNotifierProvider<SearchController, SearchState>(
    (ref) {
      final UserFromId$Query$User currentUser = ref.read(currentUserProvider)!;
      return SearchController(currentUser: currentUser);
    }
  );

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> with AutomaticKeepAliveClientMixin {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return SizedBox(
      height: 45,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
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
                    // focusNode:  _focusNode,
                    controller: _textEditingController,
                    // autofocus: true,
                    // cursorColor: Colors.black,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardAppearance: Brightness.dark,
                    clipBehavior: Clip.none,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey[800]!,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.25
                    ),
                    decoration: InputDecoration(
                      // isCollapsed: true,
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(right: 8, left: 1),
                      hintText: 'Search for users',
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
                        ref.read(searchProvider.notifier).backToInit();
                      } else {
                        ref.read(searchProvider.notifier).searchUsers(values);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ); 
  }
  
  @override
  bool get wantKeepAlive => true;
}