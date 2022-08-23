import 'package:happ_client/src/utils/widgets/loader.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthActionButton extends ConsumerWidget {
  final StateNotifierProvider notifierProvider;
  final StateNotifierProvider isLoadingProvider;
  final String text;
  final Type classParam;
  const AuthActionButton({
    required this.notifierProvider,
    required this.isLoadingProvider,
    required this.text,
    required this.classParam,
    required Key key
  }): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonState = ref.watch(notifierProvider);

    final buttonStateVal = buttonState.val;

    final isLoadingState = ref.watch(isLoadingProvider);

    bool isLoading = false;

    // print(isLoadingState);

    if (isLoadingState.runtimeType == classParam) {
      isLoading = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: buttonStateVal
            ? const Color(0xff00ff03)
            : Colors.grey[900]!, 
            width: 2.0
        ),
      ),
      child: Center(
        child:isLoading
        ? const Loader()
        : Text(
          text,
          style: TextStyle(
            color: 
              buttonStateVal
              ? const Color(0xff00ff03)
              : Colors.grey[800]!,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1
          )
        ),
      )
    );
  }

}

