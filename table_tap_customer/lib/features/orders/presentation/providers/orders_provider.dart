import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/infrastructure/infrastructure.dart';

part 'orders_provider.g.dart';

@Riverpod(keepAlive: true)
class OrdersSelected extends _$OrdersSelected {
  // List<Dish> orderDishes = ref.watch(orderDishesSelectedProvider);

  @override
  List<Order> build() => [
        
      ];

  void getOrdersDb() async {
    final res = await SharedPreferencesDatasource().loadOrders();
    state = res;
    print(res);
    // state = state.copyWith(
    //     nameCustomer: newNameCustomer,
    //     priceTotal: newPriceTotal,
    //     timeTotal: newAmountTotal,
    //     amountTotal: newAmountTotal);
  }

  void saveOrders(List<Order> purchasedOrders) async {
    await SharedPreferencesDatasource().saveOrders(purchasedOrders
    // [Order(
    //         idOrder: "1",
    //         nameCustomer: "Paco",
    //         priceTotal: 0,
    //         timeTotal: 0,
    //         amountTotal: 0,
    //         dishes: [
    //           Dish(
    //             idDish: "1",
    //             name: "ajiaco",
    //             photos: [],
    //             price: 15000,
    //             ingredients: [
    //               "4 Eggs",
    //               "1/2 Butter",
    //               "Milk",
    //               "Fruits",
    //               "Flour",
    //               "Sugar",
    //               "Salad",
    //               "Walnut",
    //               "Cacao",
    //             ],
    //           ),
    //           Dish(
    //               idDish: "2",
    //               name: "gaseosa",
    //               photos: [],
    //               price: 20000,
    //               ingredients: ["Colombiana"]),
    //           Dish(
    //             idDish: "3",
    //             name: "agua",
    //             photos: [],
    //             price: 30000,
    //           ),
    //           Dish(
    //               idDish: "4",
    //               name: "tamal",
    //               photos: [],
    //               price: 40000,
    //               ingredients: ["arroz, pollo, verduras"]),
    //         ])]
    );
  }
}


  // ref.onDispose(() {
  //   print('Estamos a punto de eliminar este provider');
  // });

// @Riverpod(keepAlive: true)
// class OrderDishesSelected extends _$OrderDishesSelected {
//   @override
//   List<Dish> build() {
//     return [];
//   }

//   void setAddDish(Dish newDish) {
//     state = [
//       ...state,
//       Dish(
//           idDish: newDish.idDish,
//           name: newDish.name,
//           photos: [],
//           price: newDish.price)
//     ];
//   }
// }
