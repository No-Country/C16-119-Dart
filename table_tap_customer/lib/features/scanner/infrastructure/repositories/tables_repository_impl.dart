import 'package:table_tap_customer/features/scanner/domain/domain.dart';
import 'package:table_tap_customer/features/scanner/domain/repositories/tables_repository.dart';

class TablesRepositoryImpl extends TablesRepository {
  final TablesDatasource datasource;

  TablesRepositoryImpl(this.datasource);

  @override
  Future<List<TableEntity>> getTablesByPage() async {
    return datasource.getTablesByPage();
  }

  @override
  Future<TableEntity> getTable() {
    return datasource.getTable();
  }

  @override
  Future<bool> changeStatusTable(String idTable, bool status) {
    return datasource.changeStatusTable(idTable, status);
  }
}
