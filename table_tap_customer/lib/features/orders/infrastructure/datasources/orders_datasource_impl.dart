import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:log_print/log_print.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:firebase_database/firebase_database.dart';

/// The `DbNames` class in Dart contains static constants for database table names such as products,
/// users, orders, and tables.
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class OrdersDatasourceImpl extends OrdersDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;
  DatabaseReference dbRT = FirebaseDatabase.instance.ref();

  @override
  Future<bool> createOrder(Map<String, dynamic> orderLike) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final idTable = prefs.getString("idTable");
      // await db
      //     .collection(DbNames.orders)
      //     .doc(orderLike["idOrder"])
      //     .set(orderLike);
      DocumentReference res = await db
          .collection(DbNames.orders)
          .add({...orderLike, "idTable": idTable});
      DatabaseReference resDbRT = dbRT.child(DbRTNames.orders).push();
      resDbRT.set({
        ...orderLike,
        "idOrder": res.id,
        "status": "pending",
        "idTable": idTable
      });
      // resDbRT.key! id del real time

      // DatabaseEvent dataSnapshot =
      //     await dbRT.child(DbRTNames.orders).child(resDbRT.key!).once();
      // LogPrint("${dataSnapshot.snapshot.value}", type: LogPrintType.info);

      // final r = await dbRT.child(DbRTNames.orders).equalTo(resDbRT.key).get();

      // final r = await dbRealTime
      //     .child('orders').get();
      // .push()
      // LogPrint("-> ${docRef.id}", type: LogPrintType.info);
      return true;
    } catch (e) {
      LogPrint("${e}", type: LogPrintType.warning);
      return false;
    }
  }

  @override
  Future<bool> updateOrder(
      Map<String, dynamic> orderLike, String idOrder) async {
    throw UnimplementedError();
  }
}
