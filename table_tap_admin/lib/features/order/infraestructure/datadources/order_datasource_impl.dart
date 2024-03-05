import 'package:firebase_database/firebase_database.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/order/domain/datasources/order_datasource.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';

class OrderDatasourceImpl implements OrderDatasource {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    final newOrderRef = _database.child(Constants.tableOrders).push();
    await newOrderRef.set(order.toJson());
    final orderId = newOrderRef.key;
    return order.copyWith(id: orderId);
  }

  @override
  Future<bool> deleteOrder(String id) async {
    try {
      await _database.child(Constants.tableOrders).child(id).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<OrderModel?> getOrderById(String id) async {
    try {
      final response =
          await _database.child(Constants.tableOrders).child(id).once();
      if (response.snapshot.exists) {
        final orderData = response.snapshot.value as Map<String, dynamic>;
        return OrderModel.fromJson(orderData, id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<List<OrderModel>> getOrders() {
    return _database.child(Constants.tableOrders).onValue.map((event) {
      final ordersMap = event.snapshot.value;
      if (ordersMap == null || ordersMap is! Map) {
        return [];
      } else {
        final List<OrderModel> orders = [];
        ordersMap.forEach((key, value) {
          // Comprobar si el valor es un mapa y crear el modelo de pedido
          if (value is Map<Object?, Object?>) {
            orders.add(OrderModel.fromJson(value, key));
          }
        });
        return orders;
      }
    });
  }

  @override
  Future<OrderModel?> updateOrder(OrderModel order, String id) async {
    try {
      await _database
          .child(Constants.tableOrders)
          .child(id)
          .update(order.toJson());
      return order.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateOrderStatus(String newStatus, String id) async {
    try {
      await _database
          .child(Constants.tableOrders)
          .child(id)
          .child('status')
          .set(newStatus);
      return true;
    } catch (e) {
      return false;
    }
  }
}
