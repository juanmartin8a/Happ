import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:happ_client/src/riverpod/deleteUser/deleteUser.dart";
import "package:happ_client/src/riverpod/deleteUser/deleteUserState.dart";
import "package:happ_client/src/riverpod/firebaseAuthProvider/firebaseAuthProvider.dart";
import "package:uuid/uuid.dart";

class LoadingDialog extends ConsumerWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color widgetColor = Colors.black;
    bool isDefault = false;
    String textMessage = "";
    bool loading = false;

    DeleteUserState state = ref.watch(deleteUserProvider);
    if(state is DeleteUserInitState){
      isDefault = true;
      textMessage = "Are you considering deleting your account?😫";
    }
    if (state is DeleteUserLoadingState) {
      loading = true;
      isDefault = false;
    } else if (state is DeleteUserDoneState) {
      isDefault = false;
      if (state.success == true) { // Should always be true
        widgetColor = const Color.fromARGB(255, 1, 214, 90);
        textMessage = "Your account has been removed :'(";
        loading = false;
        ref.read(firebaseAuthProvider).signOut();
        context.go("/");
      }
    } else if (state is DeleteUserErrorState) {
      isDefault = false;
      loading = false;
      widgetColor = Colors.red;
      textMessage = "Error while deleting user :/";
    }

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!loading) {
                Navigator.pop(context);
              }
            },
            child: Container(color: Colors.black26)
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Container(
                key: ValueKey<String>(const Uuid().v4()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: isDefault ? 250 : 150,
                    width: 250,
                    color: widgetColor,
                    child: 
                    loading
                    ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: const [
                          SizedBox(height: 15),
                          Text(
                            "Removing Account....",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              // height: 1
                            )
                          ),
                          Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            )
                          ),
                          Spacer()
                        ],
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        right: 12,
                        left: 12
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    textMessage,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (isDefault)
                                  const SizedBox(height: 4),
                                  if (isDefault)
                                  Text(
                                    "Heads up! If you delete your account, all your data will vanish forever. There's no undo. Are you sure you're ready for this step?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[500],
                                      // height: 1.5
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isDefault == true) {
                                ref.read(deleteUserProvider.notifier).deleteUser();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                isDefault ? "Delete" : "Done",
                                style: TextStyle(
                                  color: isDefault ? Colors.red : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}