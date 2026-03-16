class ApiEndpoints {
  ApiEndpoints._();

  static const String _physical = '192.168.18.4';
  static const String baseUrl = 'http://$_physical:5000';

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  //auth endpoints
  static const String login = '/user/login';
  static const String register = '/user/register';
}
