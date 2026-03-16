import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/services/hive/hive_service.dart';
import 'package:sneakers_app/core/services/storage/user_session_service.dart';
import 'package:sneakers_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:sneakers_app/features/auth/data/models/auth_hive_model.dart';

final authLocalDatasourceProvider = Provider<AuthLocalDatasource>((ref) {
  final hiveService = ref.read(hiveServiceProvider);
  final userSessionService = ref.read(userSessionServiceProvider);
  return AuthLocalDatasource(
    hiveService: hiveService,
    userSessionService: userSessionService,
  );
});

class AuthLocalDatasource implements IAuthLocalDataSource {
  final HiveService _hiveService;
  final UserSessionService _userSessionService;

  AuthLocalDatasource({
    required HiveService hiveService,
    required UserSessionService userSessionService,
  })  : _hiveService = hiveService,
         _userSessionService = userSessionService;

  @override
  Future<AuthHiveModel?> getCurrentUser() async {
    try {
      if (!_userSessionService.isLoggedIn()) return null;
      final userId = _userSessionService.getUserId();
      if (userId == null) return null;
      return await _hiveService.getUserById(userId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthHiveModel?> getUserByEmail(String email) async {
    try {
      return await _hiveService.getUserByEmail(email);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isEmailExists(String email) async {
    try {
      final user = await _hiveService.getUserByEmail(email);
      return user != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthHiveModel?> login(String email, String password) async {
    try {
      final user = await _hiveService.login(email, password);
      if (user != null) {
        await _userSessionService.saveUserSession(
          userId: user.authId ?? user.generatedAuthId,
          fullName: user.fullName,
          email: user.email,
          username: user.username,
          profileImage: user.profilePicture ?? '',
        );
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _userSessionService.clearUserSession();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthHiveModel> register(AuthHiveModel model) async {
    await _hiveService.register(model);
    return model;
  }
}
