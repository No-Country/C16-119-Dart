// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsListFilteredHash() =>
    r'd2f4f701639a3ed836af3580fa971d95f9550eeb';

/// See also [productsListFiltered].
@ProviderFor(productsListFiltered)
final productsListFilteredProvider =
    AutoDisposeProvider<List<Product>>.internal(
  productsListFiltered,
  name: r'productsListFilteredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsListFilteredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsListFilteredRef = AutoDisposeProviderRef<List<Product>>;
String _$productsListHash() => r'e76c29ec64c381f5ddfbd3bacfba8f9f84ad183d';

/// See also [ProductsList].
@ProviderFor(ProductsList)
final productsListProvider =
    NotifierProvider<ProductsList, List<Product>>.internal(
  ProductsList.new,
  name: r'productsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductsList = Notifier<List<Product>>;
String _$categoryProductsFilteredHash() =>
    r'77f4393c0cc185b875732806ee28c457093fa4d7';

/// See also [CategoryProductsFiltered].
@ProviderFor(CategoryProductsFiltered)
final categoryProductsFilteredProvider =
    NotifierProvider<CategoryProductsFiltered, CategoryProducts>.internal(
  CategoryProductsFiltered.new,
  name: r'categoryProductsFilteredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$categoryProductsFilteredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CategoryProductsFiltered = Notifier<CategoryProducts>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
