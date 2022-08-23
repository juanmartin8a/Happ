import 'package:happ_client/src/riverpod/signIn/signInState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthErrors extends ConsumerWidget {
  final StateNotifierProvider stateNotifierProvider;
  final String errorField;
  const AuthErrors({
    required this.stateNotifierProvider,
    required this.errorField,
    required Key key
  }): super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(stateNotifierProvider);

    String? errorMessage;

    if (notifier is SignInDoneState) {
      if (notifier.signInRes.errors != null && notifier.signInRes.errors!.isNotEmpty) {
        for (var error in notifier.signInRes.errors!) {
          if (error.field == errorField) {
            errorMessage = error.message;
          }
        }
      }
    }
    
    if (errorMessage == null) {
      return const SizedBox(height: 6);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Text(
          errorMessage,
          style: TextStyle(
            color: Colors.red[700],
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.2
          ),
        )
      ),
    );
  }
}