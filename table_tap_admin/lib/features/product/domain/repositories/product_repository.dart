import 'dart:io';

import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

abstract class ProductRepository {
  // crear
  Future<ProductModel> createProduct(ProductModel product, List<File> image);

  // eliminar
  Future<bool> deleteProduct(String id);

  // editar
  Future<ProductModel?> updateProduct(ProductModel product, String id, List<File> image);

  // listar todos
  Future<List<ProductModel>> getProducts();

  // buscar por id
  Future<ProductModel?> getProductById(String id);
}
