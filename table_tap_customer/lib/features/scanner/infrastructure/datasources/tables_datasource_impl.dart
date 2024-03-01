import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/scanner/domain/domain.dart';
import 'package:table_tap_customer/features/scanner/infrastructure/infrastructure.dart';

class TablesDatasourceImpl extends TablesDatasource {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<List<Table>> getTablesByPage({bool available = true}) async {
    try {
      CollectionReference collectionReferenceProducts =
          db.collection(DbNames.tables);
      QuerySnapshot queryProducts = await collectionReferenceProducts
          .where("available", isEqualTo: available)
          .get();
      List<Table> productsList = [];

      for (var element in queryProducts.docs) {
        Map<dynamic, dynamic> res = element.data() as Map;
        res = {...res, "id": element.id};
      }
      return productsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<Table> getTable() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.getString("qr");
    final idTable = prefs.getString("idTable");

    try {
      final userDocRef = db.collection(DbNames.tables);
      final queryTables = await userDocRef.where("id", isEqualTo: res).get();
      final existTable = queryTables.docs[0].data();
      final idDoc = queryTables.docs[0].id;
      prefs.setString("idTable", idDoc ?? "");
      if (idTable!.isNotEmpty && (existTable["available"] ?? false)) {
        changeStatusTable(idTable, true);
      }
      return TableMapper.jsonToEntity(existTable);
    } catch (e) {
      print(e);
      return Table(code: "", number: 0);
    }
  }

  @override
  Future<bool> changeStatusTable(idTable, status) async {
    try {
      // final batch = db.batch();
      // final userDocRef =
      await db
          .collection(DbNames.tables)
          .doc(idTable)
          .update({"available": status});
      // batch.set(userDocRef, );
      return true;
    } catch (e) {
      return false;
    }
  }
}
