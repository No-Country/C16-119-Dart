
import 'package:table_tap_customer/features/scanner/domain/domain.dart';

abstract class TablesDatasource {
  Future<List<Table>> getTablesByPage({
    bool available = true,
  });

  Future<bool> existTable();

  Future<bool> changeStatusTable(String idTable, bool status);
}
