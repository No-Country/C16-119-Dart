import 'package:table_tap_customer/features/products/domain/domain.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});

  Future<Product> getProductById(String id);

  Future<Product> createProduct(Map<String, dynamic> productLike);

  Future<Product> updateProduct(Map<String, dynamic> productLike, String idProduct);
}
