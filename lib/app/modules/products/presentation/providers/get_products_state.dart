import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tezda_task/app/modules/products/data/models/platzi_product_data.dart';

part 'get_products_state.freezed.dart';

@freezed
class GetProductsState with _$GetProductsState {
  const factory GetProductsState.initial() = GetProductsStateInitial;
  const factory GetProductsState.loading() = GetProductsStateLoading;
  const factory GetProductsState.success(List<PlatziProductData> products) = GetProductsStateSuccess;
  const factory GetProductsState.error(String message) = GetProductsStateError;
}
