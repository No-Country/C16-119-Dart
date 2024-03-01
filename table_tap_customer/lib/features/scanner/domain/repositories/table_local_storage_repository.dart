import 'package:table_tap_customer/features/scanner/domain/domain.dart';

abstract class TableLocalStorageRepository {
  Future<void> saveTable(Table table);

  Future<Table> getTable();

  Future<void> resetTable();
}
