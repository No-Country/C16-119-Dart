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

        static Map<String, dynamic> toJson(Dish dish) => {
        "idDish": dish.idDish,
        "name": dish.name,
        "price": dish.price,
        "amount": dish.amount,
        "photos": List<dynamic>.from(dish.photos.map((x) => x)),
        "ingredients": dish.ingredients != null
            ? List<dynamic>.from(dish.ingredients!.map((x) => x))
            : [],
      };
}
