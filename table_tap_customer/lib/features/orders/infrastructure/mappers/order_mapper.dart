import 'package:table_tap_customer/features/dishes/domain/domain.dart';
import 'package:table_tap_customer/features/dishes/infrastructure/infrastructure.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';

class OrderMapper {
  static Order jsonToEntity(Map<String, dynamic> json) => Order(
      idOrder: '1',
      nameCustomer: json["nameCustomer"],
      priceTotal: double.parse(json["priceTotal"].toString()),
      timeTotal: json["timeTotal"],
      amountTotal: json["amountTotal"],
      dishes: List<Dish>.from(json['dishes'].map((d) => DishMapper.jsonToEntity(d))));
}