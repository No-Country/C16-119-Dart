import 'package:table_tap_admin/features/table/domain/models/table_model.dart';

abstract class TableDatasource {
  // crear
  Future<TableModel> createTable(TableModel table);

  // eliminar
  Future<bool> deleteTable(String id);

  // editar
  Future<TableModel?> updateTable(TableModel table, String id);

  // listar todos
  Future<List<TableModel>> getTables();

  // buscar por id
  Future<TableModel?> getTableById(String id);
}
