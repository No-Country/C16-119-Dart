import 'package:table_tap_customer/features/dish/domain/domain.dart';

class Order {
  String idOrder;
  String nameCustomer;
  double priceTotal;
  int timeTotal;
  int amountTotal;
  List<Dish> dishes;

  Order({
    required this.idOrder,
    required this.nameCustomer,
    required this.priceTotal,
    required this.timeTotal,
    required this.amountTotal,
    required this.dishes,
  });

  Order copyWith({
    String? idOrder,
    String? nameCustomer,
    double? priceTotal,
    int? timeTotal,
    int? amountTotal,
    List<Dish>? dishes,
  }) =>
      Order(
        idOrder: idOrder ?? this.idOrder,
        nameCustomer: nameCustomer ?? this.nameCustomer,
        priceTotal: priceTotal ?? this.priceTotal,
        timeTotal: timeTotal ?? this.timeTotal,
        amountTotal: amountTotal ?? this.amountTotal,
        dishes: dishes ?? this.dishes,
      );
}
