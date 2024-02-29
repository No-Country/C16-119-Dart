import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/dishes/domain/entities/dish_entity.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/infrastructure/datasources/tables_datasource_impl.dart';

part 'products_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsList extends _$ProductsList {
  final ProductsRepositoryImpl productsRepositoryImpl =
      ProductsRepositoryImpl(ProductsDatasourceImpl());
  @override
  List<Product> build() => [
        Product(
            idProduct: "1",
            available: true,
            category: "Fuertes",
            description:
                "dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet",
            dish: Dish(
              idDish: "1_CARNES 1",
              name: "CARNES 1",
              photos: [
                "https://images.pexels.com/photos/15439289/pexels-photo-15439289/free-photo-of-top-view-of-a-bowl-of-soup-with-meat.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/15433931/pexels-photo-15433931/free-photo-of-sushi-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
              ],
              ingredients: [
                "queso",
                "papa",
                "huevos",
                "salsas",
                "cebolla",
                "carne"
              ],
              price: 28768,
            ),
            likes: 487,
            time: 34),
        Product(
            idProduct: "2",
            available: true,
            category: "Bebidas",
            description:
                "semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie",
            likes: 162,
            dish: Dish(
              idDish: "2_CARNES 2",
              name: "CARNES 2",
              photos: [
                "https://images.pexels.com/photos/15388082/pexels-photo-15388082/free-photo-of-grilled-shish-kebab-with-tomato-pearl-barley-and-vegetables-on-a-plate.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/15344189/pexels-photo-15344189/free-photo-of-burger-in-a-portuguese-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
              ],
              ingredients: [
                "arroz",
                "cebolla",
                "queso",
                "verduras",
                "carne",
                "salsas"
              ],
              price: 14625,
            ),
            time: 21),
        Product(
            idProduct: "3",
            available: true,
            category: "Postres",
            description:
                "egetvarius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem",
            likes: 427,
            dish: Dish(
              idDish: "3_CARNES 3",
              name: "CARNES 3",
              photos: [
                "https://images.pexels.com/photos/15434289/pexels-photo-15434289/free-photo-of-tacos-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/20205482/pexels-photo-20205482/free-photo-of-a-burger-on-a-plate.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/15388082/pexels-photo-15388082/free-photo-of-grilled-shish-kebab-with-tomato-pearl-barley-and-vegetables-on-a-plate.jpeg?auto=compress&cs=tinysrgb&w=600"
              ],
              price: 15355,
              ingredients: ["huevos", "verduras", "papa", "salsas", "carne"],
            ),
            time: 16),
        Product(
            idProduct: "4",
            available: true,
            category: "Fuertes",
            description:
                "dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet",
            dish: Dish(
              idDish: "4_CARNES 4",
              name: "CARNES 4",
              photos: [
                "https://images.pexels.com/photos/15439289/pexels-photo-15439289/free-photo-of-top-view-of-a-bowl-of-soup-with-meat.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/15433931/pexels-photo-15433931/free-photo-of-sushi-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
              ],
              ingredients: [
                "queso",
                "papa",
                "huevos",
                "salsas",
                "cebolla",
                "carne"
              ],
              price: 28768,
            ),
            likes: 487,
            time: 34),
        Product(
            idProduct: "5",
            available: true,
            category: "Bebidas",
            description:
                "semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie",
            likes: 162,
            dish: Dish(
              idDish: "5_CARNES 5",
              name: "CARNES 5",
              photos: [
                "https://images.pexels.com/photos/15388082/pexels-photo-15388082/free-photo-of-grilled-shish-kebab-with-tomato-pearl-barley-and-vegetables-on-a-plate.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/15344189/pexels-photo-15344189/free-photo-of-burger-in-a-portuguese-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
              ],
              ingredients: [
                "arroz",
                "cebolla",
                "queso",
                "verduras",
                "carne",
                "salsas"
              ],
              price: 14625,
            ),
            time: 21),
        Product(
            idProduct: "6",
            available: true,
            category: "Postres",
            description:
                "egetvarius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem",
            likes: 427,
            dish: Dish(
              idDish: "6_CARNES 6",
              name: "CARNES 6",
              photos: [
                "https://images.pexels.com/photos/15434289/pexels-photo-15434289/free-photo-of-tacos-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/20205482/pexels-photo-20205482/free-photo-of-a-burger-on-a-plate.jpeg?auto=compress&cs=tinysrgb&w=600",
                "https://images.pexels.com/photos/15388082/pexels-photo-15388082/free-photo-of-grilled-shish-kebab-with-tomato-pearl-barley-and-vegetables-on-a-plate.jpeg?auto=compress&cs=tinysrgb&w=600"
              ],
              price: 15355,
              ingredients: ["huevos", "verduras", "papa", "salsas", "carne"],
            ),
            time: 16),
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
    print(newFilter.toString());
    state = newFilter;
  }
}

@riverpod
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
