import 'package:dartz/dartz.dart';
import 'package:sneakers_app/core/error/failures.dart';

// ignore: avoid_types_as_parameter_names
abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// ignore: avoid_types_as_parameter_names
abstract class UsecaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}

class NoParams {
  const NoParams();
}
