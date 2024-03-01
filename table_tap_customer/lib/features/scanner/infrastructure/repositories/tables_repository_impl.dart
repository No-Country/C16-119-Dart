import 'package:table_tap_customer/features/scanner/domain/domain.dart';

class TablesRepositoryImpl extends TablesRepository {
  final TablesDatasource datasource;

  TablesRepositoryImpl(this.datasource);

  @override
  Future<List<Table>> getTablesByPage({bool available = true}) {
    return datasource.getTablesByPage(available: available);
  }

  @override
  Future<Table> getTable() {
    return datasource.getTable();
  }

  @override
  Future<bool> changeStatusTable(String idTable, bool status) {
    return datasource.changeStatusTable(idTable, status);
  }
}
