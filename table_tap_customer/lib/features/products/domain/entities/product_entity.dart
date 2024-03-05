import 'package:table_tap_customer/features/dishes/domain/domain.dart';

class Product {
  String idProduct;
  int time;
  int likes;
  String category;
  String description;
  bool available;
  Dish dish;

  Product(
      {required this.idProduct,
      required this.time,
      required this.likes,
      required this.category,
      required this.description,
      required this.available,
      required this.dish});
}
