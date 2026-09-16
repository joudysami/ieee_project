import 'package:shared_preferences/shared_preferences.dart';

class CacheHelp {
  static  SharedPreferences? _preferences;
  static const String _keyIsRemembered = 'isRemembered';
  static const String _keyUserRole = 'userRole';
  static const String _keyIsSplashSeen = 'has_seen_splash';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveUserSession({
    required bool isRemembered,
    required String role,
  }) async {
    await _preferences!.setBool(_keyIsRemembered, isRemembered);
    return await _preferences!.setString(_keyUserRole, role);
  }

  static bool getIsRemembered() {
    return _preferences!.getBool(_keyIsRemembered) ?? false;
  }

  static String? getUserRole() {
    return _preferences!.getString(_keyUserRole);
  }

  static Future<bool> clearSession() async {
    await _preferences!.remove(_keyIsRemembered);
    return await _preferences!.remove(_keyUserRole);
  }

  static Future<bool> setSplashSeen() async {
    return await _preferences!.setBool(_keyIsSplashSeen, true);
  }
  static bool getSplashSeen() {
    return _preferences!.getBool(_keyIsSplashSeen) ?? false;
  }
}
