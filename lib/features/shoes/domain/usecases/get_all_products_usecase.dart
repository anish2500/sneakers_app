import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/core/error/failures.dart';
import 'package:sneakers_app/core/usecases/usecase.dart';
import 'package:sneakers_app/features/shoes/data/repository/product_repository.dart';
import 'package:sneakers_app/features/shoes/domain/entities/product_entity.dart';
import 'package:sneakers_app/features/shoes/domain/repository/product_repository.dart';

class GetAllProductsParams extends Equatable {
  final String? category;
  final String? brand;
  final String? size;
  final String? color; 

  const GetAllProductsParams({this.category, this.brand, this.size, this.color});

  @override
  List<Object?> get props => [category, brand];
}

final getAllProductsUsecaseProvider = Provider<GetAllProductsUsecase>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return GetAllProductsUsecase(productRepository: productRepository);
});

class GetAllProductsUsecase
    implements Usecase<List<ProductEntity>, GetAllProductsParams> {
  final IProductRepository _productRepository;
  GetAllProductsUsecase({required IProductRepository productRepository})
    : _productRepository = productRepository;
  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    GetAllProductsParams params,
  ) {
    return _productRepository.getAllProducts(
      category: params.category,
      brand: params.brand,
    );
  }
}
