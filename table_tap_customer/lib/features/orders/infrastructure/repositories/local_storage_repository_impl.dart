import 'package:table_tap_customer/features/orders/domain/domain.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<List<Order>> loadOrders({int limit = 10, offset = 0}) {
    return datasource.loadOrders(limit: limit, offset: offset);
  }

  @override
  Future<void> saveOrders(List<Order> newOrders) {
    return datasource.saveOrders(newOrders);
  }
}
