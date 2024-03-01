import 'package:table_tap_customer/features/orders/domain/domain.dart';

class Orders {
  final List<Order> orders;

  Orders({
    required this.orders,
  });

  Orders copyWith({
    List<Order>? orders,
  }) =>
      Orders(
        orders: orders ?? this.orders,
      );

  // List<Order> ordersToEntity(String data) {
  //   Map<dynamic, dynamic> res = jsonDecode(data);
  //   return res["orders"].map((Map<String, dynamic> itemOrder) => Order(
  //       idOrder: itemOrder["idOrder"],
  //       nameCustomer: itemOrder["nameCustomer"],
  //       priceTotal: itemOrder["priceTotal"],
  //       timeTotal: itemOrder["timeTotal"],
  //       amountTotal: itemOrder["amountTotal"],
  //       dishes: [Dish(idDish: "", name: "", photos: [], price: 2)]));
  // }
}
