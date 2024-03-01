import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/features/scanner/domain/domain.dart';
import 'package:table_tap_customer/features/scanner/infrastructure/infrastructure.dart';

class KeysSharedPreferences {
  static const table = "table";
}

class TableLocalStorageDatasourceImpl extends TableLocalStorageDatasource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> saveTable(Table table) async {
    try {
      final SharedPreferences prefs = await _prefs;
      prefs.setString(
          KeysSharedPreferences.table, jsonEncode(TableMapper.toJson(table)));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Table> getTable() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final res = prefs.getString(KeysSharedPreferences.table);
      final resDecode = jsonDecode(res!);
      return TableMapper.jsonToEntity(resDecode);
    } catch (e) {
      print(e);
      return Table(code: "", number: 0);
    }
  }

  @override
  Future<void> resetTable() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(KeysSharedPreferences.table);
  }
}
