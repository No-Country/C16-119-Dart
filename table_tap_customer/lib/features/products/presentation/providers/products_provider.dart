import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/infrastructure/datasources/products_datasource_impl.dart';

part 'products_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsList extends _$ProductsList {
  final ProductsRepositoryImpl productsRepositoryImpl =
      ProductsRepositoryImpl(ProductsDatasourceImpl());
  @override
  List<Product> build() => [];

  Future loadNextPage() async {
    List<Product> productList =
        await productsRepositoryImpl.getProductsByPage();

    // if ( state.isLoading || state.isLastPage ) return;

    state = [...state, ...productList];

    // final products = await productsRepository.getProductsByPage(
    //     limit: state.limit, offset: state.offset);

    // if ( products.isEmpty ) {
    //   state = state.copyWith(
    //     isLoading: false,
    //     isLastPage: true
    //   );
    //   return;
  }
}
