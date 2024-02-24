import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/dishes/domain/entities/dish_entity.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductSelected extends _$ProductSelected {
  @override
  Product build() => Product(
      idProduct: "1",
      time: 15,
      likes: 100,
      category: "",
      description: "",
      available: true,
      dish: Dish(
        idDish: "1",
        name: "Algo fallo",
        photos: [],
        price: 0,
      ));

  void setProduct(Product newProduct) => state = newProduct;
  void setProductLikes(int likes) => state.likes = likes;
}
