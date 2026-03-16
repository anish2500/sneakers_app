import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/error/failures.dart';
import 'package:sneakers_app/core/services/connectivity/network_info.dart';
import 'package:sneakers_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:sneakers_app/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:sneakers_app/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:sneakers_app/features/auth/data/models/auth_hive_model.dart';
import 'package:sneakers_app/features/auth/domain/entities/auth_entity.dart';
import 'package:sneakers_app/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final authLocalDataSource = ref.read(authLocalDatasourceProvider);
  final authRemoteDataSource = ref.read(authRemoteDatasourceProvider);
  final networkInfo = ref.read(networkInfoProvider);
  return AuthRepository(
    authLocalDatasource: authLocalDataSource,
    authRemoteDataSource: authRemoteDataSource,
    networkInfo: networkInfo,
  );
});

class AuthRepository implements IAuthRepository {
  final IAuthLocalDataSource _authLocalDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepository({
    required IAuthLocalDataSource authLocalDatasource,
    required IAuthRemoteDataSource authRemoteDataSource,
    required NetworkInfo networkInfo,
  })  : _authLocalDataSource = authLocalDatasource,
        _authRemoteDataSource = authRemoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final user = await _authLocalDataSource.getCurrentUser();
      if (user != null) {
        return Right(user.toEntity());
      }
      return const Left(LocalDatabaseFailure(message: 'No user logged in'));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login(String email, String password) async {
    if (await _networkInfo.isConnected) {
      try {
        final apiModel = await _authRemoteDataSource.login(email, password);
        if (apiModel != null) {
          return Right(apiModel.toEntity());
        }
        return const Left(ApiFailure(message: 'Invalid Credentials'));
      } on DioException catch (e) {
        return Left(ApiFailure(message: e.response?.data['message'] ?? 'Login Failed'));
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      try {
        final localUser = await _authLocalDataSource.login(email, password);
        if (localUser != null) {
          return Right(localUser.toEntity());
        }
        return const Left(ApiFailure(message: 'Invalid Credentials or offline'));
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> register(AuthEntity entity) async {
    if (await _networkInfo.isConnected) {
      try {
        await _authRemoteDataSource.register(entity);
        return const Right(true);
      } on DioException catch (e) {
        return Left(ApiFailure(message: e.response?.data['message'] ?? 'Registration Failed'));
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      try {
        final existingUser = await _authLocalDataSource.getUserByEmail(entity.email);
        if (existingUser != null) {
          return const Left(LocalDatabaseFailure(message: 'Email already Registered'));
        }
        final authModel = AuthHiveModel.fromEntity(entity);
        await _authLocalDataSource.register(authModel);
        return const Right(true);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await _authLocalDataSource.logout();
      if (result) {
        return const Right(true);
      }
      return const Left(LocalDatabaseFailure(message: 'Failed to logout'));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isEmailExists(String email) async {
    try {
      return await _authLocalDataSource.isEmailExists(email);
    } catch (e) {
      return false;
    }
  }
}
