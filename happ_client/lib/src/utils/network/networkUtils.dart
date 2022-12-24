import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static Future<String?> fetchFromUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final res = await http.get(uri, headers: headers);
      if (res.statusCode == 200) {
        return res.body;
      }
    } catch(e) {
      debugPrint(e.toString());
    }

    return null;
  }
}