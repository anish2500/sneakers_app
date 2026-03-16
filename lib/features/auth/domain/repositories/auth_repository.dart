import 'package:dartz/dartz.dart';
import 'package:sneakers_app/core/error/failures.dart';
import 'package:sneakers_app/features/auth/domain/entities/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, bool>> register(AuthEntity entity);
  Future<Either<Failure, AuthEntity>> login(String email, String password);
  Future<Either<Failure, AuthEntity>> getCurrentUser();
  Future<Either<Failure, bool>> logout();
  Future<bool> isEmailExists(String email);
}
