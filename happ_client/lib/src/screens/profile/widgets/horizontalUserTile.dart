import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemove.dart';
import 'package:happ_client/src/riverpod/addRemove/addRemoveState.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/profile.dart';

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
    
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> userJson = {
          "id": widget.id,
          "username": widget.username,
          "name": widget.name,
          "profilePic": widget.profilePic,
          "followState": widget.followState,
        };
        
        final user = ProfileUserData.fromUserData(userJson);
        context.push('/profile', extra: ProfileParams(
            user: user,
          )
        );
      },
      child: Container(
        width: 72,
        height: 66,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        child: Container(
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
      ),
    );
  }
}