import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

abstract class IProductRepository {
  Future<List<ProductEntity>> getAllProducts({String? category, String? brand});
  Future<ProductEntity?> getProductById(String id);
}
