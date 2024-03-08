import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/infrastructure/infrastructure.dart';

part 'products_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsList extends _$ProductsList {
  final ProductsRepositoryImpl productsRepositoryImpl =
      ProductsRepositoryImpl(ProductsDatasourceImpl());
  @override
  List<Product> build() => [
        // Product(
        //     idProduct: "1",
        //     available: true,
        //     category: "Fuertes",
        //     description:
        //         "dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet",
        //     dish: Dish(
        //       idDish: "1_CARNES 1",
        //       name: "CARNES 1",
        //       photos: [
        //         "https://images.pexels.com/photos/15439289/pexels-photo-15439289/free-photo-of-top-view-of-a-bowl-of-soup-with-meat.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/15433931/pexels-photo-15433931/free-photo-of-sushi-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
        //       ],
        //       ingredients: [
        //         "queso",
        //         "papa",
        //         "huevos",
        //         "salsas",
        //         "cebolla",
        //         "carne"
        //       ],
        //       price: 20,
        //     ),
        //     likes: 487,
        //     time: 34),
        // Product(
        //     idProduct: "2",
        //     available: true,
        //     category: "Bebidas",
        //     description:
        //         "semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie",
        //     likes: 162,
        //     dish: Dish(
        //       idDish: "2_Bebidas 2",
        //       name: "Bebidas 2",
        //       photos: [
        //         "https://images.pexels.com/photos/602750/pexels-photo-602750.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/1089930/pexels-photo-1089930.jpeg?auto=compress&cs=tinysrgb&w=600"
        //       ],
        //       ingredients: [
        //         "arroz",
        //         "cebolla",
        //         "queso",
        //         "verduras",
        //         "carne",
        //         "salsas"
        //       ],
        //       price: 10,
        //     ),
        //     time: 21),
        // Product(
        //     idProduct: "3",
        //     available: true,
        //     category: "Postres",
        //     description:
        //         "egetvarius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem",
        //     likes: 427,
        //     dish: Dish(
        //       idDish: "3_Postres 3",
        //       name: "Postres 3",
        //       photos: [
        //         "https://images.pexels.com/photos/3992134/pexels-photo-3992134.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/291528/pexels-photo-291528.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/4110541/pexels-photo-4110541.jpeg?auto=compress&cs=tinysrgb&w=600"
        //       ],
        //       price: 5,
        //       ingredients: ["huevos", "verduras", "papa", "salsas", "carne"],
        //     ),
        //     time: 16),
        // Product(
        //     idProduct: "4",
        //     available: true,
        //     category: "Fuertes",
        //     description:
        //         "dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet",
        //     dish: Dish(
        //       idDish: "4_CARNES 4",
        //       name: "CARNES 4",
        //       photos: [
        //         "https://images.pexels.com/photos/15433931/pexels-photo-15433931/free-photo-of-sushi-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
        //       ],
        //       ingredients: [
        //         "queso",
        //         "papa",
        //         "huevos",
        //         "salsas",
        //         "cebolla",
        //         "carne"
        //       ],
        //       price: 8,
        //     ),
        //     likes: 487,
        //     time: 34),
        // Product(
        //     idProduct: "5",
        //     available: true,
        //     category: "Bebidas",
        //     description:
        //         "semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie",
        //     likes: 162,
        //     dish: Dish(
        //       idDish: "5_Bebidas 5",
        //       name: "Bebidas 5",
        //       photos: [
        //         "https://images.pexels.com/photos/110472/pexels-photo-110472.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/2789328/pexels-photo-2789328.jpeg?auto=compress&cs=tinysrgb&w=600"
        //       ],
        //       ingredients: [
        //         "arroz",
        //         "cebolla",
        //         "queso",
        //         "verduras",
        //         "carne",
        //         "salsas"
        //       ],
        //       price: 12,
        //     ),
        //     time: 21),
        // Product(
        //     idProduct: "6",
        //     available: true,
        //     category: "Postres",
        //     description:
        //         "egetvarius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem",
        //     likes: 427,
        //     dish: Dish(
        //       idDish: "6_Postres 6",
        //       name: "Postres 6",
        //       photos: [
        //         "https://images.pexels.com/photos/1126359/pexels-photo-1126359.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/2144112/pexels-photo-2144112.jpeg?auto=compress&cs=tinysrgb&w=600",
        //         "https://images.pexels.com/photos/205961/pexels-photo-205961.jpeg?auto=compress&cs=tinysrgb&w=600"
        //       ],
        //       price: 15,
        //       ingredients: ["huevos", "verduras", "papa", "salsas", "carne"],
        //     ),
        //     time: 16),
      ];

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

  Future saveOrder() async {}
}

// const uuid = Uuid();
enum CategoryProducts { todos, fuertes, bebidas, postres }

@Riverpod(keepAlive: true)
class CategoryProductsFiltered extends _$CategoryProductsFiltered {
  @override
  CategoryProducts build() => CategoryProducts.todos;

  void setCategoryProductsFiltered(CategoryProducts newFilter) {
    state = newFilter;
  }
}

@riverpod
List<Product> productsListFiltered(ProductsListFilteredRef ref) {
  final currentFilter = ref.watch(categoryProductsFilteredProvider);
  final productsList = ref.watch(productsListProvider);

  switch (currentFilter) {
    case CategoryProducts.todos:
      return productsList;

    case CategoryProducts.fuertes:
      return productsList
          .where((product) =>
              "CategoryProducts.${product.category.toLowerCase()}" ==
              CategoryProducts.fuertes.toString())
          .toList();

    case CategoryProducts.bebidas:
      return productsList
          .where((product) =>
              "CategoryProducts.${product.category.toLowerCase()}" ==
              CategoryProducts.bebidas.toString())
          .toList();

    case CategoryProducts.postres:
      return productsList
          .where((product) =>
              "CategoryProducts.${product.category.toLowerCase()}" ==
              CategoryProducts.postres.toString())
          .toList();
  }
}
