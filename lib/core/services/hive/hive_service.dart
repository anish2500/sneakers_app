import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sneakers_app/core/constants/hive_table_constant.dart';
import 'package:sneakers_app/features/auth/data/models/auth_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

class HiveService {
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${HiveTableConstant.dbName}';
    Hive.init(path);
    _registerAdapter();
    await _openBoxes();
  }

  void _registerAdapter() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
  }

  Future<void> _openBoxes() async {
    await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
  }

  Box<AuthHiveModel> get _authBox =>
      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  Future<void> register(AuthHiveModel user) async =>
      await _authBox.put(user.authId ?? user.generatedAuthId, user);

  Future<AuthHiveModel?> login(String email, String password) async {
    try {
      return _authBox.values.firstWhere(
        (user) => user.email == email && (user.password ?? '') == password,
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> isEmailRegistered(String email) async =>
      _authBox.values.any((user) => user.email == email);

  Future<AuthHiveModel?> getUserById(String authId) async =>
      _authBox.get(authId);

  Future<AuthHiveModel?> getUserByEmail(String email) async {
    try {
      return _authBox.values.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser(AuthHiveModel user) async {
    final key = user.authId ?? user.generatedAuthId;
    if (_authBox.containsKey(key)) {
      await _authBox.put(key, user);
      return true;
    }
    return false;
  }

  Future<void> deleteUser(String authId) async => await _authBox.delete(authId);
  Future<void> clearAllData() async => await _authBox.clear();
}
