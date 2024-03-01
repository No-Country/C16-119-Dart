import 'package:table_tap_customer/features/scanner/domain/domain.dart';

class TableLocalStorageRepositoryImpl extends TableLocalStorageRepository {
  final TableLocalStorageDatasource datasource;

  TableLocalStorageRepositoryImpl(this.datasource);

  @override
  Future<Table> getTable() {
    return datasource.getTable();
  }

  @override
  Future<void> saveTable(Table table) {
    return datasource.saveTable(table);
  }

  @override
  Future<void> resetTable() {
    return datasource.resetTable();
  }
}
