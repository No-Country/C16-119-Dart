import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_tap_customer/features/scanner/domain/domain.dart';
import 'package:table_tap_customer/features/scanner/infrastructure/infrastructure.dart';
part 'table_provider.g.dart';

@Riverpod(keepAlive: true)
class TableSelected extends _$TableSelected {
  final TableLocalStorageRepositoryImpl tableLocalStorageRepositoryImpl =
      TableLocalStorageRepositoryImpl(TableLocalStorageDatasourceImpl());

  final TablesRepositoryImpl tablesRepositoryImpl =
      TablesRepositoryImpl(TablesDatasourceImpl());

  final initialValue = TableEntity(code: "", number: 0, available: false);
  @override
  TableEntity build() => initialValue;

  Future<TableEntity> loadTable() async {
    TableEntity table = await tablesRepositoryImpl.getTable();
    if (table.available) {
      state = table;
      saveTableLocal(table);
    }
    return table;
  }

  Future<bool> changeStatusTable(String idTable, bool statusTable) async {
    bool changeTableOk =
        await tablesRepositoryImpl.changeStatusTable(idTable, statusTable);
    return changeTableOk;
  }

  Future fillTable(String idTable) async {
    bool isOccupyTable =
        await tablesRepositoryImpl.changeStatusTable(idTable, false);
  }

  void saveTableLocal(TableEntity table) async {
    await tableLocalStorageRepositoryImpl.saveTable(table);
  }

  void getTableLocal() async {
    state = await tableLocalStorageRepositoryImpl.getTable();
  }

  void resetOrder() async{
    state = initialValue;
  }
}
