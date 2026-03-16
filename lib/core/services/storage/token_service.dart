import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneakers_app/core/services/storage/user_session_service.dart';

final tokenServiceProvider = Provider<TokenService>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return TokenService(prefs: prefs);
});

class TokenService {
  final SharedPreferences _prefs;

  TokenService({required SharedPreferences prefs}) : _prefs = prefs;

  static const String _keyToken = 'auth_token';

  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  String? getToken() => _prefs.getString(_keyToken);

  Future<void> removeToken() async {
    await _prefs.remove(_keyToken);
  }
}
