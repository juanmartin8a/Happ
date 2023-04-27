import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemove.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';

class AddRemoveButton extends ConsumerStatefulWidget {
  final int userId;
  final bool? isAdd; 
  const AddRemoveButton({
    required this.userId,
    required this.isAdd,
    required Key key
  }) : super(key: key);

  @override
  AddRemoveButtonState createState() => AddRemoveButtonState();
}

class AddRemoveButtonState extends ConsumerState<AddRemoveButton> with AutomaticKeepAliveClientMixin {

  late int userId;
  late bool? isAdd;

  bool isHttpReqReady = true;

  String? operationId;

  @override
  void initState() {
    super.initState();
    isAdd = widget.isAdd;
    userId = widget.userId;
    // ref.read(addOrRemoveUserProvider("userId:${widget.userId}").notifier).addOrRemoveUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final addRemove = ref.watch(addOrRemoveUserProvider("userId:${widget.userId}"));

    if (addRemove is AddRemoveAddState) {
      isAdd = true;
      // operationId = addRemove.operationId;
      // if (addRemove.operationId == operationId) {
      //   isAdd = true;
      // }
    } else if (addRemove is AddRemoveRemoveState) {
      isAdd = false;
      // operationId = addRemove.operationId;
      // if (addRemove.operationId == operationId) {
      //   isAdd = false;
      // }
    }

    return GestureDetector(
      onTap: () {
        if (isHttpReqReady && isAdd != null) {
          isHttpReqReady = false;
          ref.read(addOrRemoveUserProvider("userId:${widget.userId}").notifier).addOrRemoveUser(widget.userId, !isAdd!);
          Future.delayed(const Duration(milliseconds: 250), () {  
            isHttpReqReady = true;
          });
        }
      },
      child: Container(
        height: 32,
        width: 80,
        decoration: BoxDecoration(
          // color: Colors.black,
          border: Border.all(color: Colors.grey[800]!, width: 2),
          borderRadius: BorderRadius.circular(16)
          // shape: BoxShape.circle
        ),
        child:  Center(
          child: Text(
            isAdd == null
            ? ""
            : isAdd == true
              ? "Added" 
              : "Add",
            style: TextStyle(
              color: Colors.grey[800]!,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}