import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/search/search.dart';
import 'package:happ_client/src/utils/buttons/changeOnTap.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      // padding: EdgeInsets.symmetric(horizontal: 12),
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              child: Row(
                children: [
                  FloatingActions(
                    icon: EvaIcons.searchOutline,
                    size: 28,
                    color: Colors.grey[800]!,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    key: const Key("searchBarIcon")
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      // focusNode: _focusNode,
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
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.25
                          // height: 2
                        ),
                      ),
                      onChanged: (values) { 
                        ref.read(searchProvider.notifier).searchUsers(values);
                        // if (values.length <= 0) {
                        //   BlocProvider.of<CommentsOrUsersCubit>(context).setUsers(widget.id);
                        // } else {
                        //   BlocProvider.of<CommentsOrUsersCubit>(context).setComments(widget.id);
                        // }
                        // BlocProvider.of<SearchBloc>(context).add(
                        //   SearchSubmitEvent(
                        //     search: values,
                        //     id: widget.id
                        //   )
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (widget.focusState is TextFocusState)
          GestureDetector(
            // onTap
            onTapDown: (_) {
              print("down");
            },
            onTapUp: (_) {
              print("up");
            },
            onTap: () {
              print("aaaaa");
              _textEditingController.clear();
              FocusScope.of(context).unfocus();
              // if ()
              // BlocProvider.of<CommentsOrUsersCubit>(context).setUsers(widget.id);
              // BlocProvider.of<SearchBloc>(context).add(
              //   SearchSubmitEvent(
              //     search: '',
              //     id: widget.id
              //   )
              // );
              // // BlocProvider.of<TextFocusUnfocusCubit>(context).focusUnfocus(false);
              // Navigator.pop(context);
            },
            child: 
            // Builder(
            //   builder: (context) {
            //     Widget widget = 
            //   }
            // )
            CustomGestureDetector(
              prevWidget: Container(
                padding: const EdgeInsets.only(right: 8),
                child:
                const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
              afterWidget: Container(
                padding: const EdgeInsets.only(right: 8),
                child:
                Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                )
              ),
            )
            Container(
              padding: const EdgeInsets.only(right: 8),
              child:
              const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
              )
            ),
          )
        ],
      )
    ); 
  }
}