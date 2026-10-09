import 'package:ieee/feature/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelp {
  static SharedPreferences? _preferences;
  static const String _keyIsRemembered = 'isRemembered';
  static const String _KeyUserModel = 'user_Model';
  static const String _keyIsSplashSeen = 'has_seen_splash';
  static const String _keyIdTrack = 'id_track'; // NEW

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

      // NEW: the track is also stored on its own key
      final track = user.idTrack;
      if (track != null && track.isNotEmpty) {
        await _preferences!.setString(_keyIdTrack, track);
      } else {
        await _preferences!.remove(
          _keyIdTrack,
        ); // never keep another user's track
      }
    } else {
      await _preferences!.remove(_KeyUserModel);
      await _preferences!.remove(_keyIdTrack);
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

  // NEW: the global track id for the admin feature
  static String? get trackId {
    final saved = _preferences!.getString(_keyIdTrack);
    if (saved != null && saved.isNotEmpty) return saved;

    final fromUser = getUser()?.idTrack; // fallback for sessions saved earlier
    return (fromUser != null && fromUser.isNotEmpty) ? fromUser : null;
  }

  // NEW: same value as an int, for requests like CreateSession (trackId is an int there)
  static int? get trackIdInt => int.tryParse(trackId ?? '');

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
