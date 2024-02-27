import 'package:table_tap_admin/features/product/infraestructure/reponse/product_response.dart';

abstract class ProductRepository {
  // crear prodcuto
  Future<ProductResponse> createProduct(ProductResponse product);

  // eliminar producto
  Future<bool> deleteProduct(String id);

  // editar producto
  Future<ProductResponse> updateProduct(ProductResponse product, String id);

  // listar todos los productos
  Future<ProductResponse> getProducts();

  // listar por categoria
  Future<ProductResponse> getProductsByCategory(String category);

  // buscar por id
  Future<ProductResponse> getProductById(String id);
}
