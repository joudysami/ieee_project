import 'package:ieee/feature/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelp {
  static SharedPreferences? _preferences;
  static const String _keyIsRemembered = 'isRemembered';
  static const String _KeyUserModel = 'user_Model';
  static const String _keyIsSplashSeen = 'has_seen_splash';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserSession({
    required bool isRemembered,
    required UserModel? user,
  }) async {
    await _preferences!.setBool(_keyIsRemembered, isRemembered);
    if (user != null) {
      await _preferences!.setString(_KeyUserModel, user.toJson());
    } else {
      await _preferences!.remove(_KeyUserModel);
    }
  }

  static bool getIsRemembered() {
    return _preferences!.getBool(_keyIsRemembered) ?? false;
  }

  static UserModel? getUser() {
    final String? userJson = _preferences!.getString(_KeyUserModel);
    if (userJson == null || userJson.isEmpty) return null;
    return UserModel.fromJson(userJson);
  }

  static Future<bool> clearSession() async {
    await _preferences!.remove(_keyIsRemembered);
    return await _preferences!.remove(_KeyUserModel);
  }

  static Future<bool> setSplashSeen() async {
    return await _preferences!.setBool(_keyIsSplashSeen, true);
  }

  static bool getSplashSeen() {
    return _preferences!.getBool(_keyIsSplashSeen) ?? false;
  }
}
