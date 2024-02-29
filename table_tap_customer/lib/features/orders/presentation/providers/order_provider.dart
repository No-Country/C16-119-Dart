import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/dishes/domain/domain.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';

part 'order_provider.g.dart';

@Riverpod(keepAlive: true)
class OrderSelected extends _$OrderSelected {
  @override
  Order build() => Order(
      idOrder: "1",
      nameCustomer: "Paco",
      priceTotal: 0,
      timeTotal: 0,
      amountTotal: 0,
      dishes: []);

  void setNewProps({
    String? newNameCustomer,
    double? newPriceTotal,
    int? newTimeTotal,
    int? newAmountTotal,
  }) {
    state = state.copyWith(
        nameCustomer: newNameCustomer,
        priceTotal: newPriceTotal,
        timeTotal: newAmountTotal,
        amountTotal: newAmountTotal);
  }

  void setAddDish(
    Dish newDish,
  ) {
    final findDish = state.dishes.any((dish) => dish.idDish == newDish.idDish);

    List<Dish> dishesList = [];
    if (findDish) {
      dishesList = state.dishes.map((dish) {
        if (dish.idDish == newDish.idDish) {
          return dish = dish.copyWith(amount: dish.amount + 1);
        }
        return dish;
      }).toList();
    } else {
      dishesList = [...state.dishes, newDish];
    }
    state = state.copyWith(dishes: dishesList);
  }

  void setRemoveDish(String id) {
    final dishesList2 = <Dish>[];
    state.dishes.asMap().forEach((index, dish) {
      if (dish.idDish == id) {
        if (dish.amount > 1) {
          dish = dish.copyWith(amount: dish.amount - 1);
          dishesList2.add(dish);
          return;
        }
        return;
      }
      dishesList2.add(dish);
    });
    state = state.copyWith(dishes: dishesList2);
  }
}
