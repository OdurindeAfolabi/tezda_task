import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/products/data/models/platzi_product_data.dart';
import 'package:tezda_task/app/modules/products/domain/repositories/interfaces/product_repository_interface.dart';
import 'package:tezda_task/app/shared/helpers/classes/failures.dart';

import '../services/product_service.dart';


final productRepositoryProvider = Provider<ProductRepositoryInterface>((ref) {
  final service = ref.read(productServiceProvider);
  return ProductRepository(service: service);
});

class ProductRepository implements ProductRepositoryInterface {
  final ProductServiceInterface service;

  ProductRepository({required this.service});

  @override
  ApiFuture<List<PlatziProductData>> getProducts() async {
    final response = await service.getProducts();
    return response;
  }
}
