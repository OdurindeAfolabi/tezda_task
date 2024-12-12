import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/products/domain/repositories/interfaces/product_repository_interface.dart';
import 'package:tezda_task/app/shared/helpers/classes/failures.dart';

import '../../domain/repositories/product_repository.dart';
import 'get_products_state.dart';

// Define the provider
final getProductsProvider = StateNotifierProvider<GetProductsNotifier, GetProductsState>((ref) {
  final repo = ref.read(productRepositoryProvider);
  return GetProductsNotifier(repo: repo);
});

class GetProductsNotifier extends StateNotifier<GetProductsState> {
  final ProductRepositoryInterface repo;

  GetProductsNotifier({required this.repo}) : super(const GetProductsState.initial());

  Future<void> getProducts() async {
    state = const GetProductsState.loading();
    try {
      final products = await repo.getProducts();
      products.fold(
        (productsResult) {
          state = GetProductsState.success(productsResult);
        },
        (error) => state = GetProductsState.error(error.message),
      );
    } catch (error) {
      final failure = error is FailureResponse ? error : const FailureResponse('Unknown error');
      state = GetProductsState.error(failure.message);
    }
  }
}
