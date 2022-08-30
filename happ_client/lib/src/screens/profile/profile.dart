import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/profile/profile.dart';
import 'package:happ_client/src/riverpod/profile/profileState.dart';
import 'package:happ_client/src/utils/widgets/floatingActions.dart';
import 'package:uuid/uuid.dart';

class Profile extends ConsumerStatefulWidget {
  final int userId;
  const Profile({
    required this.userId,
    required Key key
  }) : super(key: key);

  @override
  ConsumerState<Profile> createState() => ProfileState();
}

class ProfileState extends ConsumerState<Profile> with AutomaticKeepAliveClientMixin {

  String uuid = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    // print("hello");
    ref.read(profileProvider("userId:${widget.userId}_uuid:$uuid").notifier).getUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final profile = ref.watch(profileProvider("userId:${widget.userId}_uuid:$uuid"));

    bool isLoading = false;
    bool hasError = false;
    
    if (profile is ProfileLoadingState) {
      isLoading = true;
    } else if (profile is ProfileErrorState) {
      hasError = true;
    }

    return Material(
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        top: true,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // margin: EdgeInsets.only(top:statusBar, left: 8, right: 8),
                height: 45,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FloatingActions(
                          icon: CupertinoIcons.chevron_back,
                          padding: const EdgeInsets.only(left: 8),
                          color: Colors.grey[800]!,
                          size: 36,
                          key: Key("goBack_${widget.userId}")
                        )
                      ),
                      Center(
                        child: Text(
                          isLoading || hasError
                            ? "" 
                            : (profile as ProfileLoadedState).user.username,
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading != true)
            Expanded(
              child: hasError
              ? Container(
                padding: const EdgeInsets.only(top: 150),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Could not get user info :'(\n",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                    children: const <TextSpan>[
                      TextSpan(text: '😰🤧🍆😩', style: TextStyle(fontSize: 22))
                    ]
                  )
                )
              )
              : Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Text(
                      (profile as ProfileLoadedState).user.name,
                      style: TextStyle(
                        color: Colors.grey[800]!,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(
                      height: 12
                    ),
                    Container(
                      height: 28,
                      width: 60,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        border: Border.all(color: Colors.grey[800]!, width: 2),
                        borderRadius: BorderRadius.circular(14)
                        // shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            )
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}