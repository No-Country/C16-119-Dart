import 'package:table_tap_customer/features/orders/domain/domain.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersDatasource datasource;

  OrdersRepositoryImpl(this.datasource);

  @override
  Future<bool> createOrder(Map<String, dynamic> orderLike) {
    return datasource.createOrder(orderLike);
  }

  @override
  Future<bool> updateOrder(Map<String, dynamic> orderLike, String idOrder) {
    return datasource.updateOrder(orderLike, idOrder);
  }
}
