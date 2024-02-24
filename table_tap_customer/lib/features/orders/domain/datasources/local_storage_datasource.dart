import 'package:table_tap_customer/features/orders/domain/domain.dart';

abstract class LocalStorageDatasource {
  Future<void> saveOrders(List<Order> purchasedOrders);

  Future<List<Order>> loadOrders({int limit = 10, offset = 0});
}
