import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

abstract class ProductDatasource {
  // crear
  Future<ProductModel> createProduct(ProductModel product);

  // eliminar
  Future<bool> deleteProduct(String id);

  // editar
  Future<ProductModel?> updateProduct(ProductModel product, String id);

  // listar todos
  Future<List<ProductModel>> getProducts();

  // buscar por id
  Future<ProductModel?> getProductById(String id);
}
