import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/domain/repositories/table_repository.dart';

class TableNotifier extends StateNotifier<AsyncValue<List<TableModel>>> {
  final TableRepository tableRepository;

  TableNotifier({required this.tableRepository}) : super(const AsyncLoading()) {
    list();
  }

  Future<void> list() async {
    try {
      state = await AsyncValue.guard(() async {
        final tables = await tableRepository.getTables();
        return tables;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<TableModel?> addTable(TableModel table) async {
    state = const AsyncLoading();
    try {
      final responseTable = await tableRepository.createTable(table);
      await list();
      return responseTable;
    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<void> updateTable(TableModel table, String id) async {
    state = const AsyncLoading();
    try {
      await tableRepository.updateTable(table, id);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteTable(String tableId) async {
    state = const AsyncLoading();
    try {
      await tableRepository.deleteTable(tableId);
      await list();
    } catch (error) {
      print(error);
    }
  }

  TableModel? getTableById(String tableId) {
    if (state is AsyncData<List<TableModel>>) {
      final tables = (state as AsyncData<List<TableModel>>).value;
      return tables.firstWhere(
        (table) => table.id == tableId,
      );
    } else {
      return null;
    }
  }
}
