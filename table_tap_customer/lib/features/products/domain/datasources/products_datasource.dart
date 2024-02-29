import 'package:table_tap_customer/features/products/domain/domain.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});

  Future<Product> getProductById(String id);

  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
