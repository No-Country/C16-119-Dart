// Proveedor para el repositorio
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/category_repository.dart';
import 'package:table_tap_admin/features/product/domain/repositories/product_repository.dart';
import 'package:table_tap_admin/features/product/infraestructure/datasources/category_datasource_impl.dart';
import 'package:table_tap_admin/features/product/infraestructure/datasources/product_datasource_impl.dart';
import 'package:table_tap_admin/features/product/infraestructure/repositories/category_repository_impl.dart';
import 'package:table_tap_admin/features/product/infraestructure/repositories/product_repository_impl.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/categories_notifier.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/products_notifier.dart';

// provedor de repositorios
final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    categoryDatasource: CategoryDatasourceImp(),
  ),
);

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    productDatasource: ProductDatasourceImpl(),
  ),
);

// Proveedor para las entidades
final productsProvider =
    StateNotifierProvider<ProductsNotifier, AsyncValue<List<ProductModel>>>(
  (ref) => ProductsNotifier(
    productRepository: ref.read(
      productRepositoryProvider,
    ),
  ),
);

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, AsyncValue<List<CategoryModel>>>(
  (ref) => CategoriesNotifier(
    categoryRepository: ref.read(categoryRepositoryProvider),
  ),
);
