import 'package:table_tap_customer/features/scanner/domain/domain.dart';

abstract class TableLocalStorageRepository {
  Future<void> saveTable(TableEntity table);

  Future<TableEntity> getTable();

  Future<void> resetTable();
}
