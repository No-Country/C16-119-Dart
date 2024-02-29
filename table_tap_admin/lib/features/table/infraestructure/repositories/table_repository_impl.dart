import 'package:table_tap_admin/features/table/domain/datasources/table_datasource.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/domain/repositories/table_repository.dart';

class TableRepositoryImp implements TableRepository {
  final TableDatasource tableDatasource;

  TableRepositoryImp({
    required this.tableDatasource,
  });

  @override
  Future<TableModel> createTable(TableModel table) {
    return tableDatasource.createTable(table);
  }

  @override
  Future<bool> deleteTable(String id) {
    return tableDatasource.deleteTable(id);
  }

  @override
  Future<TableModel?> getTableById(String id) async {
    return tableDatasource.getTableById(id);
  }

  @override
  Future<List<TableModel>> getTables() {
    return tableDatasource.getTables();
  }

  @override
  Future<TableModel?> updateTable(TableModel table, String id) {
    return tableDatasource.updateTable(table, id);
  }
}
