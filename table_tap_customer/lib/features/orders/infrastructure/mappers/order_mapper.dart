import 'package:table_tap_customer/features/dishes/domain/domain.dart';
import 'package:table_tap_customer/features/dishes/infrastructure/infrastructure.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';

class OrderMapper {
  static Order jsonToEntity(Map<String, dynamic> json) => Order(
      idOrder: json["id"],
      nameCustomer: json["nameCustomer"],
      priceTotal: double.parse(json["priceTotal"].toString()),
      timeTotal: json["timeTotal"],
      amountTotal: json["amountTotal"],
      dishes: List<Dish>.from(
          json['dishes'].map((d) => DishMapper.jsonToEntity(d))));

  static Map<String, dynamic> toJson(Order order) => {
        "idOrder": order.idOrder,
        "amountTotal": order.amountTotal,
        "nameCustomer": order.nameCustomer,
        "priceTotal": order.priceTotal,
        "timeTotal": order.timeTotal,
        "dishes":
            List<dynamic>.from(order.dishes.map((dish) => DishMapper.toJson(dish))),
      };
}
