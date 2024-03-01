import 'dart:io';

import 'package:table_tap_admin/features/product/domain/datasources/product_datasource.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource productDatasource;

  ProductRepositoryImpl({required this.productDatasource});

  @override
  Future<ProductModel> createProduct(ProductModel product, List<File> image) {
    return productDatasource.createProduct(product, image);
  }

  @override
  Future<bool> deleteProduct(String id) {
    return productDatasource.deleteProduct(id);
  }

  @override
  Future<ProductModel?> getProductById(String id) {
    return productDatasource.getProductById(id);
  }

  @override
  Future<List<ProductModel>> getProducts() {
    return productDatasource.getProducts();
  }

  @override
  Future<ProductModel?> updateProduct(
      ProductModel product, String id, List<File> image) {
    return productDatasource.updateProduct(product, id, image);
  }
}
