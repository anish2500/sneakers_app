import 'package:dartz/dartz.dart';
import 'package:sneakers_app/core/error/failures.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

abstract interface class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    String? category,
    String? brand,
  });

  Future<Either<Failure, ProductEntity>> getProductById(String id);
}
