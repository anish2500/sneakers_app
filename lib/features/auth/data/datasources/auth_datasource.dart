import 'package:sneakers_app/features/auth/data/models/auth_api_model.dart';
import 'package:sneakers_app/features/auth/data/models/auth_hive_model.dart';
import 'package:sneakers_app/features/auth/domain/entities/auth_entity.dart';

abstract interface class IAuthLocalDataSource {
  Future<AuthHiveModel> register(AuthHiveModel model);
  Future<AuthHiveModel?> login(String email, String password);
  Future<AuthHiveModel?> getCurrentUser();
  Future<bool> logout();
  Future<bool> isEmailExists(String email);
  Future<AuthHiveModel?> getUserByEmail(String email);
}

abstract interface class IAuthRemoteDataSource {
  Future<AuthApiModel> register(AuthEntity entity);
  Future<AuthApiModel?> login(String email, String password);
}
