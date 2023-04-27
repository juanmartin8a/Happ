import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getUserIDToken(FirebaseAuth auth) async {
  String token = await auth.currentUser!.getIdToken();

  Map<String, dynamic> claims = parseJwt(token);
  if (!claims.containsKey("id")) {
    return null;
  }

  return token;
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw const FormatException('Invalid token');
  }

  final payload = parts[1];
  final normalizedPayload = base64Url.normalize(payload);
  final resp = utf8.decode(base64Url.decode(normalizedPayload));
  final payloadMap = json.decode(resp) as Map<String, dynamic>;

  return payloadMap;
} 