import 'package:table_tap_admin/features/order/domain/models/order_model.dart';

abstract class OrderRepository {
  // crear
  Future<OrderModel> createOrder(OrderModel order);

  // eliminar
  Future<bool> deleteOrder(String id);

  // editar
  Future<OrderModel?> updateOrder(OrderModel order, String id);

  // listar todos
  Stream<List<OrderModel>> getOrders();

  // buscar por id
  Future<OrderModel?> getOrderById(String id);

  Future<bool> updateOrderStatus(String newStatus, String id);
}
