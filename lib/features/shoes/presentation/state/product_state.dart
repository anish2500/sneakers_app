import 'package:equatable/equatable.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> products;
  final String? errorMessage;
  final bool isFromCache; 

  const ProductState({
    required this.status,
    this.products = const [],
    this.errorMessage,
    this.isFromCache = false, 
  });

  factory ProductState.initial() {
    return const ProductState(status: ProductStatus.initial);
  }

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? products,
    String? errorMessage,
    bool ? isFromCache, 
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      isFromCache: isFromCache ?? this.isFromCache, 
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, isFromCache];
}
