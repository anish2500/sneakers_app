import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/services/hive/hive_service.dart';
import 'package:sneakers_app/features/shoes/data/datasources/local/product_local_datasource.dart';
import 'package:sneakers_app/features/shoes/data/datasources/product_datasource.dart';
import 'package:sneakers_app/features/shoes/data/datasources/remote/product_remote_datasource.dart';
import 'package:sneakers_app/features/shoes/data/models/product_api_model.dart';
import 'package:sneakers_app/features/shoes/data/models/product_hive_model.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';
import 'package:sneakers_app/features/shoes/domain/repository/product_repository.dart';

final productRepositoryProvider = Provider<IProductRepository>((ref) {
  return ProductRepositoryImpl(
    remoteDatasource: ref.read(productRemoteDatasourceProvider),
    localDatasource: ref.read(productLocalDatasourceProvider),
    hiveService: ref.read(hiveServiceProvider),
  );
});

class ProductRepositoryImpl implements IProductRepository {
  final IProductRemoteDatasource remoteDatasource;
  final IProductLocalDatasource localDatasource;
  final HiveService hiveService;

  ProductRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.hiveService,
  });

  @override
  Future<List<ProductEntity>> getAllProducts({String? category, String? brand}) async {
    try {
      final models = await remoteDatasource.getAllProducts(
        category: category,
        brand: brand,
      );
      final entities = ProductApiModel.toEntityList(models);

      // Cache to Hive
      final hiveModels = entities
          .map((e) => ProductHiveModel.fromEntity(e))
          .toList();
      await hiveService.cacheProducts(hiveModels);

      return entities;
    } catch (e) {
      // Fallback to cached data on error
      return await localDatasource.getCachedProducts(category: category);
    }
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    try {
      final model = await remoteDatasource.getProductById(id);
      return model?.toEntity();
    } catch (e) {
      return await localDatasource.getCachedProductById(id);
    }
  }
}
