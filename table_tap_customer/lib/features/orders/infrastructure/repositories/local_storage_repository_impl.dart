import 'package:table_tap_customer/features/orders/domain/domain.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<void> saveOrder(Order order) async{
    return await datasource.saveOrder(order);
  }

  @override
  Future<Order> loadOrder() {
    return datasource.loadOrder();
  }

  @override
  Future<void> saveOrders(List<Order> purchasedOrders) async{
    return await datasource.saveOrders(purchasedOrders);
  }

  @override
  Future<List<Order>> loadOrders({int limit = 10, offset = 0}) {
    return datasource.loadOrders(limit: limit, offset: offset);
  }

  @override
  Future deleteOrder() {
    return datasource.deleteOrder();
  }
}
