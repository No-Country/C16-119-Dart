import 'package:table_tap_customer/features/dishes/domain/domain.dart';

class DishMapper {
  static Dish jsonToEntity(Map<String, dynamic> json) => Dish(
        idDish: json["idDish"],
        name: json["name"],
        price: json["price"],
        amount: json["amount"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
      );
}
