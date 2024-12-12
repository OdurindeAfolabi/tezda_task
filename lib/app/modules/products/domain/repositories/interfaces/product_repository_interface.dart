import '../../../../../shared/helpers/classes/failures.dart';
import '../../../data/models/platzi_product_data.dart';

abstract class ProductRepositoryInterface {
  ApiFuture<List<PlatziProductData>> getProducts();
}