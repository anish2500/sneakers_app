import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/api/api_client.dart';
import 'package:sneakers_app/core/api/api_endpoints.dart';
import 'package:sneakers_app/core/services/storage/token_service.dart';
import 'package:sneakers_app/core/services/storage/user_session_service.dart';
import 'package:sneakers_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:sneakers_app/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:sneakers_app/features/auth/data/models/auth_api_model.dart';
import 'package:sneakers_app/features/auth/data/models/auth_hive_model.dart';
import 'package:sneakers_app/features/auth/domain/entities/auth_entity.dart';

final authRemoteDatasourceProvider = Provider<IAuthRemoteDataSource>((ref) {
  return AuthRemoteDatasource(
    apiClient: ref.read(apiClientProvider),
    userSessionService: ref.read(userSessionServiceProvider),
    tokenService: ref.read(tokenServiceProvider),
    authLocalDatasource: ref.read(authLocalDatasourceProvider),
  );
});

class AuthRemoteDatasource implements IAuthRemoteDataSource {
  final ApiClient _apiClient;
  final UserSessionService _userSessionService;
  final TokenService _tokenService;
  final AuthLocalDatasource _authLocalDatasource;

  AuthRemoteDatasource({
    required ApiClient apiClient,
    required UserSessionService userSessionService,
    required TokenService tokenService,
    required AuthLocalDatasource authLocalDatasource,
  })  : _apiClient = apiClient,
        _userSessionService = userSessionService,
        _tokenService = tokenService,
        _authLocalDatasource = authLocalDatasource;

  @override
  Future<AuthApiModel?> login(String email, String password) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      print('LOGIN RESPONSE: ${response.statusCode}');
      print('LOGIN DATA: ${response.data}');

      if (response.statusCode == 200 && response.data['user'] != null) {
        final userData = response.data['user'] as Map<String, dynamic>;
        print('USER DATA: $userData');
        
        final user = AuthApiModel(
          authId: userData['_id'],
          fullName: userData['fullName'],
          email: userData['email'],
          username: userData['fullName'],
        );

        await _userSessionService.saveUserSession(
          userId: userData['_id'] ?? '',
          fullName: userData['fullName'] ?? '',
          email: userData['email'] ?? '',
          username: userData['fullName'] ?? '',
          profileImage: '',
        );

        final token = response.data['token'] as String?;
        if (token != null) {
          await _tokenService.saveToken(token);
        }

        try {
          await _authLocalDatasource.register(
            AuthHiveModel(
              authId: userData['_id'],
              email: userData['email'],
              fullName: userData['fullName'],
              username: userData['fullName'],
              password: password,
            ),
          );
        } catch (e) {
          // Ignore local storage errors, login is still successful
        }

        return user;
      }
      return null;
    } on DioException catch (e) {
      print('DIO ERROR: ${e.message}');
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    } catch (e) {
      print('ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<AuthApiModel> register(AuthEntity entity) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.register,
        data: {
          'fullName': entity.fullName,
          'email': entity.email,
          'username': entity.username,
          'password': entity.password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = response.data['user'] ?? response.data;
        return AuthApiModel(
          authId: userData['_id'],
          fullName: userData['fullName'],
          email: userData['email'],
          username: userData['fullName'],
        );
      }
      return AuthApiModel(
        email: entity.email,
        fullName: entity.fullName,
        username: entity.username,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    }
  }
}
