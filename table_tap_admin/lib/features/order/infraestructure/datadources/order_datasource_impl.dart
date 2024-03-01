import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/order/domain/datasources/order_datasource.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';

class OrderDatasourceImpl implements OrderDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    final result = await _firebase.collection(Constants.tableOrders).add(
          order.toJson(),
        );
    final data = await result.get();
    final createdOder = OrderModel.fromJson(data.data()!, data.id);
    return createdOder;
  }

  @override
  Future<bool> deleteOrder(String id) async {
    try {
      await _firebase.collection(Constants.tableOrders).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<OrderModel?> getOrderById(String id) async {
    try {
      var snapshot =
          await _firebase.collection(Constants.tableOrders).doc(id).get();
      if (snapshot.exists) {
     //   return Order.fromJson(snapshot.data() as Map<String, dynamic>, id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      var result = await _firebase.collection(Constants.tableOrders).get();
      return result.docs.map((doc) {
        final orderId = doc.id;
        return OrderModel.fromJson(
          doc.data(),
          orderId,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<OrderModel?> updateOrder(OrderModel order, String id) async {
    try {
      await _firebase
          .collection(Constants.tableOrders)
          .doc(id)
          .update(order.toJson());
      return order.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }
}
