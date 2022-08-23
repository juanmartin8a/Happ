import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JWT {
  final _storage = new FlutterSecureStorage();

  getRefreshJWT() async {
    var token = await _storage.read(key: "refreshToken");
    if (token == null) {
      return '';
    }

    return token;
  }

  getJWT() async {
    var token = await _storage.read(key: "accessToken");
    if (token == null) {
      return '';
    }
    
    return token;
  }


  createJWTS(String accessToken, String refreshToken) async {
    await _storage.write(key: "accessToken", value: accessToken);
    await _storage.write(key: "refreshToken", value: refreshToken);
  }

  deleteJWTS() async {
    await _storage.delete(key: "accessToken");
    await _storage.delete(key: "refreshToken");
  }

  deleteAll() async {
    await _storage.deleteAll();
  }
}
