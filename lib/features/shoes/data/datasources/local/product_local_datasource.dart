import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/services/hive/hive_service.dart';
import 'package:sneakers_app/features/shoes/data/datasources/product_datasource.dart';
import 'package:sneakers_app/features/shoes/data/models/product_hive_model.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

final productLocalDatasourceProvider = Provider<IProductLocalDatasource>((ref) {
  return ProductLocalDatasource(ref.read(hiveServiceProvider));
});

class ProductLocalDatasource implements IProductLocalDatasource {
  final HiveService _hiveService;

  ProductLocalDatasource(this._hiveService);

  @override
  Future<void> cacheProducts(List<ProductEntity> products) async {
    final hiveModels = products.map((e) => ProductHiveModel.fromEntity(e)).toList();
    await _hiveService.cacheProducts(hiveModels);
  }

  @override
  Future<List<ProductEntity>> getCachedProducts({String? category}) async {
    final cachedModels = _hiveService.getCachedProducts();
    final entities = ProductHiveModel.toEntityList(cachedModels);

    if (category != null && category != 'All') {
      return entities.where((product) => product.category == category).toList();
    }
    return entities;
  }

  @override
  Future<ProductEntity?> getCachedProductById(String id) async {
    final cachedModels = _hiveService.getCachedProducts();
    final entities = ProductHiveModel.toEntityList(cachedModels);
    try {
      return entities.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
