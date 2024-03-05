import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/table/domain/datasources/table_datasource.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';

class TableDatasourceRemoteImpl implements TableDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<TableModel> createTable(TableModel table) async {
    final String tableId = _firebase.collection(Constants.tableTable).doc().id;
    await _firebase.collection(Constants.tableTable).doc(tableId).set({
      'id': tableId,
      'number': table.number,
      'available': table.available,
    });
    return table.copyWith(id: tableId);
  }

  @override
  Future<bool> deleteTable(String id) async {
    try {
      await _firebase.collection(Constants.tableTable).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<TableModel?> getTableById(String id) async {
    try {
      var snatshot =
          await _firebase.collection(Constants.tableTable).doc(id).get();
      if (snatshot.exists) {
        return TableModel.fromJson(snatshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<TableModel>> getTables() async {
    try {
      var querySnapshot =
          await _firebase.collection(Constants.tableTable).get();
          return querySnapshot.docs
          .map((doc) => TableModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<TableModel?> updateTable(TableModel table, String id) async {
    try {
      await _firebase.collection(Constants.tableTable).doc(id).update({
        'number': table.number,
        'available': table.available,
      });
      return table.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }
}
