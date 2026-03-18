import 'package:flutter/foundation.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const String _physical = '192.168.18.4';

  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:5000'; // Chrome / Web
    } else {
      return 'http://$_physical:5000'; // Android emulator / physical device
    }
  }

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth endpoints
  static const String login = '/user/login';
  static const String register = '/user/register';

  // Product endpoints
  static const String getProducts = '/product/get';
  static const String getProductById = '/product/getById';
}