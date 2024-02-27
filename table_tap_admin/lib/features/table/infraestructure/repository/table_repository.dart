import 'package:table_tap_admin/features/table/infraestructure/entities/table_entities.dart';

abstract class TableRepository {
  // crear
  Future<TableEntities> createTable(TableEntities Table);

  // eliminar
  Future<bool> deleteTable(String id);

  // editar
  Future<TableEntities> updateTable(TableEntities Table, String id);

  // listar todos
  Future<List<TableEntities>> getTables();

  // buscar por id
  Future<TableEntities> getTableById(String id);
}
