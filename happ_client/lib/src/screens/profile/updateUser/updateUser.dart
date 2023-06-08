import "dart:io";

import "package:eva_icons_flutter/eva_icons_flutter.dart";
import "package:flutter/material.dart";
import "package:flutter_image_compress/flutter_image_compress.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:happ_client/src/riverpod/firebaseAuthProvider/firebaseAuthProvider.dart";
import "package:happ_client/src/riverpod/updateUser/updateUser.dart";
import "package:happ_client/src/riverpod/updateUser/updateUserState.dart";
import "package:happ_client/src/screens/profile/profile.dart";
import "package:happ_client/src/utils/widgets/floatingActions.dart";
import "package:image_picker/image_picker.dart";
import "package:path_provider/path_provider.dart";
import 'package:http/http.dart' as http;


class UpdateUser extends ConsumerStatefulWidget {
  final ProfileUserData user;
  const UpdateUser({
    required this.user,
    super.key
  });

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends ConsumerState<UpdateUser> {

  late ProfileUserData user;

  late TextEditingController nameController;
  late TextEditingController usernameController;
  late String initURLPicture;

  final nameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  final ImagePicker picker = ImagePicker();

  File? selectedImageFile;
  http.MultipartFile? selectedImageMultipartFile;

  bool isLoading = false;

  Map<String, dynamic> errors = {};

  @override
  void initState() {
    super.initState();
    user = widget.user;
    nameController = TextEditingController(text: user.name);
    usernameController = TextEditingController(text: user.username);
    initURLPicture = user.profilePic;
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(updateUserProvider, (prev, next) {
      switch (next.runtimeType) {
        case UpdateUserLoadingState:
          setState(() {
            isLoading = true;
          });

          break;

        case UpdateUserDoneState:
          if ((next as UpdateUserDoneState).updateUserRes.user != null) {
            errors = {};
            user = ProfileUserData.fromUserData(next.updateUserRes.user);
            refreshFirebaseToken();
          } else {
            if (next.updateUserRes.errors != null) {
              errors = {};
              for (int i = 0; i < next.updateUserRes.errors!.length; i++) {
                errors[next.updateUserRes.errors![i].field] = next.updateUserRes.errors![i].message;
              }
            }
          }

          setState(() {
            isLoading = false;
          });

          break;

        case UpdateUserErrorState:
          errors = {};
          setState(() {
            isLoading = false;
            errors["global"] = "An Error happened while updating your account :'(";
          });

          break;
      }
    });

    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        right: false,
        left: false,
        top: true,
        child: Stack(
          children: [
            Column(
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
                GestureDetector(
                  onTap: () async {
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      // setState(() {
                      //   selectedImageFile = File(image.path);
                      // });
                      getMultiPartFile(image);
                    }
                  },
                  child: SizedBox(
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
                            child: selectedImageFile != null
                            ? Image.file(
                              selectedImageFile!,
                              fit: BoxFit.cover
                            )
                            : Image.network(
                              initURLPicture,
                              fit: BoxFit.cover,
                            ),
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
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2, color: Colors.red),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.5, color: Colors.red),
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
                              errorText: errors["name"],
                              errorMaxLines: 2
                            ),
                            onChanged: (values) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2, color: Colors.red),
                              ),
                              focusedErrorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.5, color: Colors.red),
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
                              errorText: errors["username"],
                              errorMaxLines: 2,
                            ),
                            onChanged: (values) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if ((nameController.text != user.name || usernameController.text != user.username || selectedImageMultipartFile != null))
            Positioned(
              bottom: 34,
              left: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.5)) / 2,
              child: GestureDetector(
                onTap: () {
                  if (!isLoading) {
                    final isUsernameValid = isValidUsername(usernameController.text);

                    final isNameValid = isValidName(nameController.text);

                    if (isUsernameValid == "valid" && isNameValid == "valid") {
                      setState(() {
                        errors.remove("username");
                        errors.remove("name");
                      });
                      http.MultipartFile? profilePic = selectedImageMultipartFile;
                      String? username = usernameController.text != user.username ? usernameController.text : null;
                      String? name = nameController.text != user.name ? nameController.text : null;
                      ref.read(updateUserProvider.notifier).updateUser(profilePic, username, name);
                    } else {
                      if (isUsernameValid != "valid") {
                        errors["username"] = isUsernameValid;
                      } else {
                        errors.remove("username");
                      }

                      if (isNameValid != "valid") {
                        errors["name"] = isNameValid;
                      } else {
                        errors.remove("name");
                      }

                      setState(() {});
                    }

                  }
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 6,
                      ),
                    ],
                  ),
            
                  child: Center(
                    child: isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      )
                    )
                    : const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void getMultiPartFile(XFile xFile) async {
    setState(() {
      selectedImageFile = File(xFile.path);
    });

    Directory directory = await getTemporaryDirectory();
    String destinationPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    await compressFile(selectedImageFile!.absolute.path, destinationPath);

    http.MultipartFile preSelectedImageMultipartFile = await http.MultipartFile.fromPath('profilePictures', destinationPath);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedImageMultipartFile = preSelectedImageMultipartFile;
      });
    });
  }

  Future<File> compressFile(String filePath, String destinationPath) async {
    await FlutterImageCompress.compressAndGetFile(
      filePath,
      destinationPath,
      minWidth: 150,
      minHeight: 150,
      quality: 70,
    );

    return File(destinationPath);
  }

  String isValidUsername(String s) {

    if (s.length > 30) {
      return "Username can't have more than 30 characters";
    }

    if (s.isEmpty) {
      return "Username cannot be empty.";
    }

    if (!RegExp(r'^[a-z0-9._]*$').hasMatch(s)) {
      return 'Username can only contain lowercase letters, numbers, periods (.), and underscores (_). No Spaces.';
    }

    return "valid";
  }

  String isValidName(String s) {

    if (s.length > 30) {
      return "Name can't have more than 30 characters";
    }

    if (s.isEmpty) {
      return "Name cannot be empty.";
    }

    return "valid";
  }

  void refreshFirebaseToken() {
    ref.read(firebaseAuthProvider).currentUser!.getIdToken(true);
  }
}