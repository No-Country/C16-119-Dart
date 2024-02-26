// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsListFilteredHash() =>
    r'6cc63cfa5e2a9c9968f304a85b956d58fc6a64dc';

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
String _$productsListHash() => r'1abbbd9ec00f26129b837d2f089a35779fa6edbd';

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
    r'138a633b7a1e21b531d8a8f9880f9430b3772e7d';

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
