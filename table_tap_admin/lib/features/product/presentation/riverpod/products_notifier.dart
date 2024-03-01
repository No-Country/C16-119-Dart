import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/product_repository.dart';

class ProductsNotifier extends StateNotifier<AsyncValue<List<ProductModel>>> {
  final ProductRepository productRepository;

  ProductsNotifier({required this.productRepository})
      : super(const AsyncLoading()) {
    list();
  }

  Future<void> list() async {
    try {
      state = await AsyncValue.guard(() async {
        final products = await productRepository.getProducts();
        return products;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProduct(ProductModel product, List<File> image) async {
    state = const AsyncLoading();
    try {
      await productRepository.createProduct(product, image);
      final updatedProducts = await productRepository.getProducts();
      state = AsyncData(updatedProducts);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateProduct(
      ProductModel product, String id, List<File> image) async {
    state = const AsyncLoading();
    try {
      await productRepository.updateProduct(product, id, image);
      final updatedProducts = await productRepository.getProducts();
      state = AsyncData(updatedProducts);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteProduct(String productId) async {
    state = const AsyncLoading();
    try {
      await productRepository.deleteProduct(productId);
      final updatedProducts = await productRepository.getProducts();
      state = AsyncData(updatedProducts);
    } catch (error) {
      print(error);
    }
  }

  ProductModel? getProductById(String productId) {
    if (state is AsyncData<List<ProductModel>>) {
      final products = (state as AsyncData<List<ProductModel>>).value;
      return products.firstWhere(
        (product) => product.id == productId,
      );
    } else {
      return null;
    }
  }

  Future<List<ProductModel>> getProductAll() async {
    if (state is AsyncData<List<ProductModel>>) {
      final products = (state as AsyncData<List<ProductModel>>).value;
      return products;
    } else {
      return [];
    }
  }
}
