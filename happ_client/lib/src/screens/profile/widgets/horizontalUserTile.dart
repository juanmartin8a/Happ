import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemove.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';

class HorizontalUserTile extends ConsumerStatefulWidget {
  final String name;
  final String username;
  final String profilePic;
  final bool followState;
  final int id;
  const HorizontalUserTile({
    required this.followState,
    required this.name,
    required this.profilePic,
    required this.username,
    required this.id,
    super.key
  });

  @override
  _HorizontalUserTileState createState() => _HorizontalUserTileState();
}

class _HorizontalUserTileState extends ConsumerState<HorizontalUserTile> {

  late bool followState;

  @override
  void initState() {
    super.initState();
    followState = widget.followState;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AddRemoveState>(addOrRemoveUserProvider("userId:${widget.id}"), (prev, next) {
      switch(next.runtimeType) {
        case AddRemoveAddState:
          setState(() {
            followState = true;
          });
        break;
        case AddRemoveRemoveState:
          setState(() {
            followState = false;
          });
        break;
        default: {}
        break;
      }
    });
    
    return Container(
      width: 72,
      height: 66,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                widget.profilePic,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
    // Container(
    //   width: 118,
    //   // width: 85,
    //   // margin: const EdgeInsets.only(),
    //   margin: const EdgeInsets.symmetric(horizontal: 6),
    //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    //   decoration: BoxDecoration(
    //     // color: Colors.grey[200],
    //     borderRadius: BorderRadius.circular(20),
    //     border: Border.all(width: 2, color: Colors.grey[200]!)
    //   ),
    //   child: Column(
    //     children: [
    //       Container(
    //         width: 70,
    //         height: 70,
    //         decoration: BoxDecoration(
    //           color: Colors.grey[300],
    //           shape: BoxShape.circle,
    //           // boxShadow: [
    //           //   BoxShadow(
    //           //     color: Colors.black.withOpacity(0.2),
    //           //     spreadRadius: 1,
    //           //     blurRadius: 4,
    //           //   ),
    //           // ],
    //         ),
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(100),
    //           child: Image.network(
    //             widget.profilePic,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 12),
    //       Text(
    //         Characters(widget.name)
    //         .replaceAll(Characters(' '), Characters('\u{000A0}'))
    //         .toString(),
    //         style: TextStyle(
    //           color: Colors.grey[800],
    //           fontSize: 13,
    //           fontWeight: FontWeight.w600,
    //           height: 1
    //         ),
    //         softWrap: false,
    //         maxLines: 1,
    //         overflow: TextOverflow.ellipsis, // new
    //       ),
    //       const SizedBox(height: 2),
    //       Text(
    //         Characters(widget.username)
    //         .replaceAll(Characters(' '), Characters('\u{000A0}'))
    //         .toString(),
    //         style: TextStyle(
    //           color: Colors.grey[600],
    //           fontSize: 11,
    //           fontWeight: FontWeight.w500,
    //           height: 1
    //         ),
    //         softWrap: false,
    //         maxLines: 1,
    //         overflow: TextOverflow.ellipsis, // new
    //       ),
    //       const SizedBox(height: 12),
    //       GestureDetector(
    //         onTap: () {
    //           ref.read(addOrRemoveUserProvider("userId:${widget.id}").notifier).addOrRemoveUser(widget.id, !followState);
    //         },
    //         child: Container(
    //           height: 26,
    //           width: 70,
    //           decoration: BoxDecoration(
    //             color: followState ? Colors.grey[200] : Colors.black,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           child: Center(
    //             child: Text(
    //               followState ? "Added" : "Add",
    //               style: TextStyle(
    //                 color: followState ? Colors.grey[800]! : Colors.white,
    //                 fontSize: 13,
    //                 fontWeight: FontWeight.w600,
    //               )
    //             ),
    //           )
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}