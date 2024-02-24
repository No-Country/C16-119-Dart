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
          dishes: [
            Dish(
              idDish: "1",
              name: "ajiaco",
              photos: [],
              price: 15000,
              ingredients: [
                "4 Eggs",
                "1/2 Butter",
                "Milk",
                "Fruits",
                "Flour",
                "Sugar",
                "Salad",
                "Walnut",
                "Cacao",
              ],
            ),
            Dish(
                idDish: "2",
                name: "gaseosa",
                photos: [],
                price: 20000,
                ingredients: ["Colombiana"]),
            Dish(
              idDish: "3",
              name: "agua",
              photos: [],
              price: 30000,
            ),
            Dish(
                idDish: "4",
                name: "tamal",
                photos: [],
                price: 40000,
                ingredients: ["arroz, pollo, verduras"]),
          ]);

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
      {required String name,
      required List<String> photos,
      required double price}) {
    state = state.copyWith(dishes: [
      ...state.dishes,
      Dish(idDish: "asdasd", name: name, photos: photos, price: price)
    ]);
  }
  
  void addAmountDish(String id) {
    state = state.copyWith(
        dishes: state.dishes.map((dish) {
      if (dish.idDish == id) {
        dish = dish.copyWith(amount: dish.amount + 1);
      }
      return dish;
    }).toList());
  }

  void removeAmountDish(String id) {
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
