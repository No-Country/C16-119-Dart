import 'package:table_tap_customer/features/scanner/domain/domain.dart';

abstract class TablesRepository {
  Future<List<TableEntity>> getTablesByPage();

  Future<TableEntity> getTable();

  Future<bool> changeStatusTable(String idTable, bool status);
}
