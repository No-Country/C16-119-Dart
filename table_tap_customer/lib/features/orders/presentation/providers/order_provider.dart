import 'package:log_print/log_print.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/dishes/domain/domain.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/infrastructure/infrastructure.dart';
import 'package:uuid/uuid.dart';

part 'order_provider.g.dart';

const uuid = Uuid();

@Riverpod(keepAlive: true)
class OrderSelected extends _$OrderSelected {
  final LocalStorageRepositoryImpl localStorageRepositoryImpl =
      LocalStorageRepositoryImpl(SharedPreferencesDatasourceImpl());
  final OrdersRepositoryImpl ordersRepositoryImpl =
      OrdersRepositoryImpl(OrdersDatasourceImpl());
  final orderInitialValue = Order(
      idOrder: "3",
      nameCustomer: "",
      priceTotal: 0,
      timeTotal: 0,
      amountTotal: 0,
      dishes: []);
  @override
  Order build() => orderInitialValue;

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
    calculateAmountTotal();
    calculatePriceTotal();
    saveOrderLocal();
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
    calculateAmountTotal();
    calculatePriceTotal();
    saveOrderLocal();
  }

  void addOrder() async {
    await ordersRepositoryImpl.createOrder(OrderMapper.toJson(state));
  }

  void calculateAmountTotal() {
    int priceTotalDishes = 0;
    for (var dish in state.dishes) {
      priceTotalDishes = priceTotalDishes + dish.amount;
    }
    state = state.copyWith(amountTotal: priceTotalDishes);
  }

  void calculatePriceTotal() {
    double priceTotalDishes = 0;
    for (var dish in state.dishes) {
      priceTotalDishes = priceTotalDishes + (dish.amount * dish.price);
    }
    state = state.copyWith(priceTotal: priceTotalDishes);
  }

  void saveOrderLocal() async {
    await localStorageRepositoryImpl.saveOrder(state);
  }

  void getOrderLocal() async {
    state = await localStorageRepositoryImpl.loadOrder();
    if (state.idOrder.isEmpty) {
      state = state.copyWith(idOrder: uuid.v4());
    }
  }

  void resetOrder() async {
    await localStorageRepositoryImpl.deleteOrder();
    state = orderInitialValue;
  }
}
