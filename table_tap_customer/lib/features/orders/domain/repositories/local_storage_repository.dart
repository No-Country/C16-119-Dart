import 'package:table_tap_customer/features/orders/domain/domain.dart';

abstract class LocalStorageRepository {
  Future<void> saveOrder(Order order);

  Future<Order> loadOrder();

  Future<void> saveOrders(List<Order> purchasedOrders);

  Future<List<Order>> loadOrders({int limit = 10, offset = 0});

  Future deleteOrder();
}
