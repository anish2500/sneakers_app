import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/api/api_client.dart';
import 'package:sneakers_app/core/api/api_endpoints.dart';
import 'package:sneakers_app/features/shoes/data/datasources/product_datasource.dart';
import 'package:sneakers_app/features/shoes/data/models/product_api_model.dart';

final productRemoteDatasourceProvider = Provider<IProductRemoteDatasource>((ref) {
  return ProductRemoteDatasource(apiClient: ref.read(apiClientProvider));
});

class ProductRemoteDatasource implements IProductRemoteDatasource {
  final ApiClient _apiClient;

  ProductRemoteDatasource({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<ProductApiModel>> getAllProducts({
    String? category,
    String? brand,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null && category != 'All') {
        queryParams['category'] = category;
      }
      if (brand != null && brand != 'All Brands') {
        if (brand == 'NB') {
          queryParams['brand'] = 'New Balance';
        } else {
          queryParams['brand'] = brand;
        }
      }

      final response = await _apiClient.get(
        ApiEndpoints.getProducts,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => ProductApiModel.fromJson(json))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch products',
      );
    }
  }

  @override
  Future<ProductApiModel?> getProductById(String id) async {
    try {
      final response = await _apiClient.get(
        '${ApiEndpoints.getProductById}/$id',
      );
      return ProductApiModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch product');
    }
  }
}
