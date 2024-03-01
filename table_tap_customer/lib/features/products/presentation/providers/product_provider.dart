import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/dishes/domain/domain.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductSelected extends _$ProductSelected {
  @override
  Product build() => Product(
      idProduct: "",
      time: 0,
      likes: 0,
      category: "",
      description: "",
      available: false,
      dish: Dish(
        idDish: "",
        name: "",
        photos: [],
        price: 0,
      ));

  void setProduct(Product newProduct) => state = newProduct;
  void setProductLikes(int likes) => state.likes = likes;
}