import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/products/data/models/platzi_product_data.dart';
import 'package:tezda_task/app/shared/functions/api_functions.dart';
import 'package:tezda_task/app/shared/helpers/classes/failures.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final productServiceProvider = Provider<ProductServiceInterface>((ref) {
  final dio = ref.read(dioProvider);
  return ProductService(dio: dio);
});

abstract class ProductServiceInterface {
  ApiFuture<List<PlatziProductData>> getProducts();
}

class ProductService implements ProductServiceInterface {
  final Dio dio;

  ProductService({required this.dio});

  @override
  ApiFuture<List<PlatziProductData>> getProducts() {
    return futureFunction(
          () async {
        try {
          final response = await dio.get('https://api.escuelajs.co/api/v1/products');
          if (response.statusCode == 200) {
            final data = response.data as List;
            return data.map((item) => PlatziProductData.fromJson(item)).toList();
          } else {
            throw FailureResponse(
             'Failed to fetch products: ${response.statusCode}',
            );
          }
        } on DioError catch (e) {
          log('Dio error: ${e.message}');
          throw FailureResponse(e.message!);
        } catch (e) {
          log('Error fetching products: $e');
          throw const FailureResponse('Unexpected error occurred.');
        }
      },
    );
  }
}
