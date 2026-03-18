import 'package:equatable/equatable.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductEntity> products;
  final String? errorMessage;

  const ProductState({
    required this.status,
    this.products = const [],
    this.errorMessage,
  });

  factory ProductState.initial() {
    return const ProductState(status: ProductStatus.initial);
  }

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
