import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    "Shared preferences must be overridden in main.dart",
  );
});

final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService(prefs: ref.read(sharedPreferencesProvider));
});

class UserSessionService {
  final SharedPreferences _prefs;

  UserSessionService({required SharedPreferences prefs}) : _prefs = prefs;

  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyFullName = 'user_fullName';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUsername = 'username';
  static const String _keyUserProfileImage = 'user_profile_image';

  Future<void> saveUserSession({
    required String userId,
    required String fullName,
    required String email,
    required String username,
    String? profileImage,
  }) async {
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserId, userId);
    await _prefs.setString(_keyFullName, fullName);
    await _prefs.setString(_keyUserEmail, email);
    await _prefs.setString(_keyUsername, username);
    if (profileImage != null) {
      await _prefs.setString(_keyUserProfileImage, profileImage);
    }
  }

  Future<void> clearUserSession() async {
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyFullName);
    await _prefs.remove(_keyUsername);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserProfileImage);
  }

  bool isLoggedIn() => _prefs.getBool(_keyIsLoggedIn) ?? false;
  String? getUserFullName() => _prefs.getString(_keyFullName);
  String? getUserId() => _prefs.getString(_keyUserId);
  String? getUserEmail() => _prefs.getString(_keyUserEmail);
  String? getUsername() => _prefs.getString(_keyUsername);
  String? getUserProfileImage() => _prefs.getString(_keyUserProfileImage);
}
