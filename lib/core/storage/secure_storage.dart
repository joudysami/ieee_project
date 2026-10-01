import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _backendTokenKey = 'backend_token';

  static Future<void> saveBackendToken(String token) async {
    await _storage.write(key: _backendTokenKey, value: token);
  }

  static Future<String?> getBackendToken() async {
    return await _storage.read(key: _backendTokenKey);
  }

  static Future<void> clearBackendToken() async {
    await _storage.delete(key: _backendTokenKey);
  }
}