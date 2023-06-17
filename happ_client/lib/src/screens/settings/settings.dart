import "dart:io";

import "package:eva_icons_flutter/eva_icons_flutter.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:happ_client/src/riverpod/firebaseAuthProvider/firebaseAuthProvider.dart";
import "package:happ_client/src/screens/settings/widgets/loadingDialog.dart";
import "package:happ_client/src/screens/settings/widgets/settingsTile.dart";
import "package:happ_client/src/utils/buttons/customGestureDetector.dart";
import "package:happ_client/src/utils/widgets/floatingActions.dart";

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top
          ),
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  // top: (45 - 36) / 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      height: 45,
                      child: FloatingActions(
                        icon: EvaIcons.arrowBackOutline,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        // padding:  EdgeInsets.zero,
                        color: Colors.grey[800]!,
                        size: 36,
                        key: const Key("goBack_settings")
                      ),
                    )
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Center(
                    child: Text(
                      "More",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 19,
                        fontWeight: FontWeight.w700
                      )
                    )
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                BackgroundChangeOnTapGestureDetector(
                  onTap: () {
                    ref.read(firebaseAuthProvider).signOut();
                    context.go("/");
                  },
                  key: const Key("signOut_tap"),
                  child: SettingsTile(
                    name: "Sign Out",
                    icon: Icon(
                      EvaIcons.logOutOutline,
                      color: Colors.grey[800]
                    ),
                    key: const Key("log_out")
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: RichText(
                        textAlign: TextAlign.center,
                        
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800]!
                          ),
                          children: <TextSpan>[
                            if (Platform.isIOS) const TextSpan(text: '⬇️ ', style: TextStyle(fontSize: 20)),
                            const TextSpan(text: 'DANGER ZONE'),
                            if (!Platform.isIOS) const TextSpan(text: '❗️', style: TextStyle(fontSize: 20)),
                            if (Platform.isIOS) const TextSpan(text: '💀  ⬇️', style: TextStyle(fontSize: 20))
                          ]
                        )
                      )
                    ),
                    const SizedBox(height: 2),
                    BackgroundChangeOnTapGestureDetector(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierColor: Colors.transparent,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, anim1, anim2) {
                            return const LoadingDialog();
                          }
                        );
                      },
                      key: const Key("deleteAccount_tap"),
                      child: const SettingsTile(
                        name: "Delete Account",
                        icon: Icon(
                          FluentIcons.delete_16_regular,
                          color: Colors.red
                        ),
                        textColor: Colors.red,
                        key: Key("delete_account")
                      ),
                    ),
                  ]
                )
              ],
            )
          )
        ],
      )
    );
  }
}