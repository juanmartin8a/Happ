import "package:eva_icons_flutter/eva_icons_flutter.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:happ_client/src/utils/widgets/floatingActions.dart";

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  final nameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        top: true,
        child: Column(
          children: [
            SizedBox(
              // margin: EdgeInsets.only(top:statusBar, left: 8, right: 8),
              height: 45,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 45,
                        child: Center(
                          child: FloatingActions(
                            icon: EvaIcons.arrowBackOutline,
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            // padding:  EdgeInsets.zero,
                            color: Colors.grey[800]!,
                            size: 36,
                            key: const Key("goBack_update_user")
                          ),
                        ),
                      )
                    ),
                  ),
                  Center(
                    child: Text(
                      // username,
                      "Edit Profile",
                      style: TextStyle(
                        color: Colors.grey[800]!,
                        fontSize: 19,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(100),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.2),
                      //     spreadRadius: 2,
                      //     blurRadius: 6,
                      //   ),
                      // ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      // child: Image.network(
                      //   // widget.user.profilePic,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      width: 25,
                      height: 25,
                      // color: Colors.red,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          EvaIcons.editOutline,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 36),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[850],
                    height: 1.25
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                // height: 40,
                // decoration: BoxDecoration(
                //   color: Colors.grey[200],
                //   borderRadius: BorderRadius.circular(12)
                // ),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          focusNode:  nameFocusNode,
                          controller: nameController,
                          // autofocus: true,
                          // cursorColor: Colors.black,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardAppearance: Brightness.dark,
                          clipBehavior: Clip.none,
                          autofocus: false,
                          maxLines: 1,
                          maxLength: 30,
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.25
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            // isDense: true,
                            alignLabelWithHint: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2, color: Colors.grey[300]!), //<-- SEE HERE
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2, color: Colors.grey[300]!), //<-- SEE HERE
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2, color: Colors.grey[300]!), //<-- SEE HERE
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.5, color: Color.fromARGB(255, 1, 228, 96)), //<-- SEE HERE
                            ),
                            // focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(right: 12, left: 1, top: 6, bottom: 6),
                            hintText: 'Name',
                            // fillColor: Colors.red,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.25
                              // height: 2
                            ),
                          ),
                          onChanged: (values) {
                            // if (values.isEmpty) {
                            //   ref.read(searchProvider.notifier).backToInit();
                            // } else {
                            //   ref.read(searchProvider.notifier).searchUsers(values);
                            // }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                    height: 1.25
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                // height: 40,
                // decoration: BoxDecoration(
                //   color: Colors.grey[200],
                //   borderRadius: BorderRadius.circular(12)
                // ),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          focusNode:  usernameFocusNode,
                          controller: usernameController,
                          // autofocus: true,
                          // cursorColor: Colors.black,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardAppearance: Brightness.dark,
                          clipBehavior: Clip.none,
                          autofocus: false,
                          maxLines: 1,
                          maxLength: 30,
                          style: TextStyle(
                            color: Colors.grey[800]!,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.25
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            // isDense: true,
                            alignLabelWithHint: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2, color: Colors.grey[300]!), //<-- SEE HERE
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2, color: Colors.grey[300]!), //<-- SEE HERE
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2, color: Colors.grey[300]!), //<-- SEE HERE
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.5, color: Colors.greenAccent[400]!), //<-- SEE HERE
                            ),
                            // focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(right: 12, left: 1, top: 6, bottom: 6),
                            hintText: 'Username',
                            // fillColor: Colors.red,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.25
                              // height: 2
                            ),
                          ),
                          onChanged: (values) {
                            // if (values.isEmpty) {
                            //   ref.read(searchProvider.notifier).backToInit();
                            // } else {
                            //   ref.read(searchProvider.notifier).searchUsers(values);
                            // }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}