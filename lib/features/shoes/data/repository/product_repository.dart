import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/error/failures.dart';
import 'package:sneakers_app/core/services/connectivity/network_info.dart';
import 'package:sneakers_app/features/shoes/data/datasources/remote/product_remote_datasource.dart';
import 'package:sneakers_app/features/shoes/data/models/product_api_model.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';
import 'package:sneakers_app/features/shoes/domain/repository/product_repository.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  final productRemoteDataSource = ref.read(productRemoteDatasourceProvider);
  final networkInfo = ref.read(networkInfoProvider);
  return ProductRepository(
    productRemoteDataSource: productRemoteDataSource,
    networkInfo: networkInfo,
  );
});

class ProductRepository implements IProductRepository {
  final ProductRemoteDatasource _productRemoteDataSource;
  final NetworkInfo _networkInfo;
  ProductRepository({
    required ProductRemoteDatasource productRemoteDataSource,
    required NetworkInfo networkInfo,
  }) : _productRemoteDataSource = productRemoteDataSource,
       _networkInfo = networkInfo;
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    String? category,
    String? brand,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final apiModels = await _productRemoteDataSource.getAllProducts(
          category: category,
          brand: brand,
        );
        return Right(ProductApiModel.toEntityList(apiModels));
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return const Left(ApiFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final apiModel = await _productRemoteDataSource.getProductById(id);
        return Right(apiModel.toEntity());
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return const Left(ApiFailure(message: 'No internet connection'));
    }
  }
}
