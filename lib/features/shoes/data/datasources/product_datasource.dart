import 'package:sneakers_app/features/shoes/data/models/product_api_model.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

abstract interface class IProductLocalDatasource {
  Future<List<ProductEntity>> getCachedProducts({String? category});
  Future<void> cacheProducts(List<ProductEntity> products);
  Future<ProductEntity?> getCachedProductById(String id);
}

abstract interface class IProductRemoteDatasource {
  Future<List<ProductApiModel>> getAllProducts({String? category, String? brand});
  Future<ProductApiModel?> getProductById(String id);
}
