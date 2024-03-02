import 'package:table_tap_customer/features/scanner/domain/domain.dart';

class TableLocalStorageRepositoryImpl extends TableLocalStorageRepository {
  final TableLocalStorageDatasource datasource;

  TableLocalStorageRepositoryImpl(this.datasource);

  @override
  Future<TableEntity> getTable() {
    return datasource.getTable();
  }

  @override
  Future<void> saveTable(TableEntity table) {
    return datasource.saveTable(table);
  }

  @override
  Future<void> resetTable() {
    return datasource.resetTable();
  }
}
