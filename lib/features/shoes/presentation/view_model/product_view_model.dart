import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/features/shoes/domain/usecases/get_all_products_usecase.dart';
import 'package:sneakers_app/features/shoes/presentation/state/product_state.dart';

final productViewModelProvider =
    NotifierProvider<ProductViewModel, ProductState>(() => ProductViewModel());

class ProductViewModel extends Notifier<ProductState> {
  late final GetAllProductsUsecase _getAllProductUsecase;

  @override
  ProductState build() {
    _getAllProductUsecase = ref.read(getAllProductsUsecaseProvider);
    return ProductState.initial();
  }

  Future<void> getAllProducts({String? category, String? brand, String? size, String? color}) async {
    state = state.copyWith(status: ProductStatus.loading);

    final params = GetAllProductsParams(category: category, brand: brand, size: size, color: color);

    final result = await _getAllProductUsecase(params);

    result.fold(
      (failure) => state = state.copyWith(
        status: ProductStatus.error,
        errorMessage: failure.message,
      ),
      (products) => state = state.copyWith(
        status: ProductStatus.loaded,
        products: products,
      ),
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
