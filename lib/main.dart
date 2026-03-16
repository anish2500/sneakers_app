import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneakers_app/app/app.dart';
import 'package:sneakers_app/core/services/hive/hive_service.dart';
import 'package:sneakers_app/core/services/storage/user_session_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hiveService = HiveService();
  await hiveService.init();
  final sharedPrefs = await SharedPreferences.getInstance();


  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      hiveServiceProvider.overrideWithValue(hiveService),
    ],
    child: const App()));
}
