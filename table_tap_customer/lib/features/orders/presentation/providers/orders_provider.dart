import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/infrastructure/infrastructure.dart';

part 'orders_provider.g.dart';

@Riverpod(keepAlive: true)
class OrdersSelected extends _$OrdersSelected {
  @override
  List<Order> build() => [];

  void getOrdersDb() async {
    final res = await SharedPreferencesDatasourceImpl().loadOrders();
    state = res;
    print(res);
  }

  void saveOrders(List<Order> purchasedOrders) async {
    await SharedPreferencesDatasourceImpl().saveOrders(purchasedOrders);
  }
}
