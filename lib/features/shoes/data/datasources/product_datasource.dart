import 'package:dartz/dartz.dart';
import 'package:sneakers_app/core/error/failures.dart';
import 'package:sneakers_app/features/shoes/data/models/product_api_model.dart';


abstract interface class IProductRemoteDatasource {
  Future<List<ProductApiModel>> getAllProducts({
    String? category,
    String? brand,
  });
  Future<ProductApiModel> getProductById(String id);
}
