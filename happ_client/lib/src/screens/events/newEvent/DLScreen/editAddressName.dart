import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/eventUpdateReady/eventUpdateReady.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/locationDetailsState.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetails.dart';
import 'package:happ_client/src/riverpod/locationSearch/reverseLocationDetailsState.dart';
import 'package:happ_client/src/riverpod/newEventComplete/newEventComplete.dart';
import 'dart:math' as math;

class DLScreenEditAddress extends ConsumerStatefulWidget {
  final bool isNew;
  final String? address;
  const DLScreenEditAddress({
    this.isNew = true,
    this.address,
    super.key
  });
  // const DLScreenEditAddress({super.key});

  @override
  _DLScreenEditAddressState createState() => _DLScreenEditAddressState();
}

class _DLScreenEditAddressState extends ConsumerState<DLScreenEditAddress> {

  String? name;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      setState(() {
        name = widget.address;
        _controller.text = name!;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      widget.isNew ? locationDetailsProvider : updateLocationDetailsProvider,
      (prev, next) {
      if (next is LocationDetailsLoadedState) {
        if (next.name != null) {
          setState(() {
            name = next.name!;
            _controller.text = name!;
            _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });
          // print("name");
          // print(name);
          // ref.read(newEventCompleteProvider.notifier).fieldChange(
          //   eventPlace: name,
          // );
        }
      }
    });

    ref.listen(
      widget.isNew ? reverseLocationDetailsProvider : updateReverseLocationDetailsProvider, 
      (prev, next) {
      if (next is ReverseLocationDetailsLoadedState) {
        setState(() {
          name = next.name;
          _controller.text = name!;
          _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
        // print("name 2");
        ref.read(newEventCompleteProvider.notifier).fieldChange(
          eventPlace: name,
        );
      }
    });

    return Container(
      height: 40,
      // width: (MediaQuery.of(context).size.width - 32) * 0.5,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Edit address: ",
            // maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.25
            )
          ),
          Expanded(
            child: ClipRRect(
              child: TextField(
                scrollController: _scrollController,
                textInputAction: TextInputAction.done,
                controller: _controller,
                clipBehavior: Clip.none,
                textAlignVertical: TextAlignVertical.center,
                keyboardAppearance: Brightness.dark,
                // scrollPhysics: NeverScrollableScrollPhysics(),
                // cursorC
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey[850]!,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.25
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  // filled: true,
                  // fillColor: Colors.red,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(right: 8, left: 1, top: 2, bottom: 2),
                  hintText: 'Address',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.25
                  ),
                ),
                onChanged: (values) {
                  name = values;
                  if (widget.isNew) {
                    ref.read(newEventCompleteProvider.notifier).fieldChange(
                      eventPlace: name,
                    );
                  } else {
                    ref.read(eventUpdateReadyControllerProvider.notifier).fieldChange(
                      eventPlace: name,
                    );
                  }
                },
              ),
            ),
          ),
        ]
      )
    );
  }

  // TextPosition getPositionAtOffset(Offset offset) {
  //    final RenderEditable renderBox = _editableText!.renderEditable;
  //   final TextPosition position = renderBox.getPositionForPoint(offset);
  //   return position;
  // }
}