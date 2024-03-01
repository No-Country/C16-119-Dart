import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:log_print/log_print.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';

class OrdersDatasourceImpl extends OrdersDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<bool> createOrder(Map<String, dynamic> orderLike) async {
    try {
    DocumentReference docRef =  await db.collection(DbNames.orders).add(orderLike);
    LogPrint("-> ${docRef.id}", type: LogPrintType.info);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateOrder(
      Map<String, dynamic> orderLike, String idOrder) async {
    throw UnimplementedError();
  }
  // Future<Product> createOrder(Map<String, dynamic> orderLike);

  // Future<Product> updateOrder(Map<String, dynamic> orderLike, String idOrder);
}
