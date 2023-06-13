import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happ_client/src/riverpod/scanPass/scanPass.dart';
import 'package:happ_client/src/riverpod/scanPass/scanPassState.dart';
import 'package:uuid/uuid.dart';

class ProcessPass extends ConsumerWidget {
  const ProcessPass({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color widgetColor = Colors.black;
    bool isDefault = true;

    ScanPassState state = ref.watch(scanPassProvider);
    if (state is ScanPassDoneState) {
      isDefault = false;
      widgetColor = const Color.fromARGB(255, 1, 214, 90);
    } else if (state is ScanPassErrorState) {
      isDefault = false;
      widgetColor = Colors.red;
    }

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (isDefault != true) {
                Navigator.pop(context);
                ref.invalidate(scanPassProvider);
              }
            },
            child: Container(color: Colors.black26)
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.black,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: Container(
                    height: 150,
                    width: 250,
                    color: widgetColor,
                    key: Key(const Uuid().v4()),
                    // padding: const EdgeInsets.all(12),
                    child: isDefault == true 
                    ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: const [
                          Text(
                            "Processing...",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1
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
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    widgetColor == Colors.red 
                                    ? "Not invited 😬" 
                                    : "Invited! 🥳",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      height: 1
                                    )
                                  ),
                                  Icon(
                                    widgetColor == Colors.red
                                    ? FluentIcons.dismiss_12_regular
                                    : FluentIcons.checkmark_16_filled,
                                    color: Colors.white,
                                    size: 80,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              ref.invalidate(scanPassProvider);
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 6, top: 6),
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1
                                )
                              ),
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