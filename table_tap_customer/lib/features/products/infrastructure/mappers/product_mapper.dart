import 'package:table_tap_customer/features/dishes/domain/domain.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';

class ProductMapper {
  static Product jsonToEntity(Map<String, dynamic> json) => Product(
      idProduct: json["id"] ?? "",
      likes: json["likes"] ?? 0,
      time: json["time"] ?? 0,
      category: json["category"] ?? "",
      description: json["description"] ?? "",
      available: json["available"],
      dish: Dish(
        idDish: json["id"] + "_" + json["name"],
        name: json["name"],
        photos: List<String>.from(json["image"].map((photo) => photo)),
        price: double.parse(json["price"].toString()),
        ingredients: List.from(json["ingredients"].map((ingr) => ingr)),
      ));
}
