import 'package:table_tap_admin/features/order/domain/datasources/order_datasource.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';
import 'package:table_tap_admin/features/order/domain/repositories/order_repository.dart';

class OderRepositoryImpl implements OrderRepository {
  final OrderDatasource orderDatasource;

  OderRepositoryImpl({required this.orderDatasource});

  @override
  Future<OrderModel> createOrder(OrderModel order) {
    return orderDatasource.createOrder(order);
  }

  @override
  Future<bool> deleteOrder(String id) {
    return orderDatasource.deleteOrder(id);
  }

  @override
  Future<OrderModel?> getOrderById(String id) {
    return orderDatasource.getOrderById(id);
  }

  @override
  Future<List<OrderModel>> getOrders() {
    return orderDatasource.getOrders();
  }

  @override
  Future<OrderModel?> updateOrder(OrderModel order, String id) {
    return orderDatasource.updateOrder(order, id);
  }
}
