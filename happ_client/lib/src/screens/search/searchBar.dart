import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/search/search.dart';
import 'package:happ_client/src/utils/buttons/changeOnTap.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
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
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      focusNode:  _focusNode,
                      controller: _textEditingController,
                      // cursorColor: Colors.black,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardAppearance: Brightness.dark,
                      style: TextStyle(
                        color: Colors.grey[800]!,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.25
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(right: 8),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.25
                          // height: 2
                        ),
                      ),
                      onChanged: (values) { 
                        ref.read(searchProvider.notifier).searchUsers(values);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _textEditingController.clear();
              FocusScope.of(context).unfocus();
            },
            child:
            CustomGestureDetector(
              prevWidget: Container(
                padding: const EdgeInsets.only(right: 8),
                key: ValueKey<String>(const Uuid().v4()),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
              afterWidget: Container(
                padding: const EdgeInsets.only(right: 8),
                key: ValueKey<String>(const Uuid().v4()),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
              onTap: () {
                _textEditingController.clear();
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
              key: widget.key ?? const Key("cancelButton_searchBar")
            )
          )
        ],
      )
    ); 
  }
}