import 'package:table_tap_customer/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);


  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<Product> createProduct(Map<String, dynamic> productLike) {
    return datasource.createProduct(productLike);
  }

  @override
  Future<Product> updateProduct(
      Map<String, dynamic> productLike, String idProduct) {
    return datasource.updateProduct(productLike, idProduct);
  }
}
