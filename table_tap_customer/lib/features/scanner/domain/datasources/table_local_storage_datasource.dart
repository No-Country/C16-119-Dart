import 'package:table_tap_customer/features/scanner/domain/domain.dart';

abstract class TableLocalStorageDatasource {
  Future<void> saveTable(Table table);

  Future<Table> getTable();

  Future<void> resetTable();
}
