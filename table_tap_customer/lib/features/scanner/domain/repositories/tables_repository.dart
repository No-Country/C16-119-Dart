import 'package:table_tap_customer/features/scanner/domain/domain.dart';

abstract class TablesRepository {
  Future<List<Table>> getTablesByPage({
    bool available = true,
  });

  Future<Table> getTable();

  Future<bool> changeStatusTable(String idTable,  bool status);
}
