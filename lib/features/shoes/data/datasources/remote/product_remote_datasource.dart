import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/api/api_client.dart';
import 'package:sneakers_app/core/api/api_endpoints.dart';
import 'package:sneakers_app/features/shoes/data/models/product_api_model.dart';

final productRemoteDatasourceProvider = Provider<ProductRemoteDatasource>((
  ref,
) {
  return ProductRemoteDatasource(apiClient: ref.read(apiClientProvider));
});

class ProductRemoteDatasource {
  final ApiClient _apiClient;

  ProductRemoteDatasource({required ApiClient apiClient})
    : _apiClient = apiClient;

  Future<List<ProductApiModel>> getAllProducts({
    String? category,
    String? brand,
    String? size,
    String? color,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null && category != 'All') {
        queryParams['category'] = category;
      }
      if (brand != null && brand != 'All Brands' && brand != 'NB') {
        if (brand == 'NB') {
          queryParams['brand'] = 'New Balance';
        } else {
          queryParams['brand'] = brand;
        }
        if (size != null && size != 'All Sizes') {
          queryParams['sizes'] = size;
        }
        if (color != null && color != 'All Colors') {
          queryParams['colors'] = color; 
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

  Future<ProductApiModel> getProductById(String id) async {
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
