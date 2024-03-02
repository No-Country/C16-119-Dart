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

  Future<void> addProduct(TableModel table) async {
    state = const AsyncLoading();
    try {
      await tableRepository.createTable(table);
      final updatedtables = await tableRepository.getTables();
      state = AsyncData(updatedtables);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateProduct(TableModel table, String id) async {
    state = const AsyncLoading();
    try {
      await tableRepository.updateTable(table, id);
      final updatedTables = await tableRepository.getTables();
      state = AsyncData(updatedTables);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteProduct(String tableId) async {
    state = const AsyncLoading();
    try {
      await tableRepository.deleteTable(tableId);
      final updateTables = await tableRepository.getTables();
      state = AsyncData(updateTables);
    } catch (error) {
      print(error);
    }
  }

  TableModel? getProductById(String tableId) {
    if (state is AsyncData<List<TableModel>>) {
      final tables = (state as AsyncData<List<TableModel>>).value;
      return tables.firstWhere(
        (table) => table.id == tableId,
      );
    } else {
      return null;
    }
  }

  Future<List<TableModel>> getProductAll() async {
    if (state is AsyncData<List<TableModel>>) {
      final tables = (state as AsyncData<List<TableModel>>).value;
      return tables;
    } else {
      return [];
    }
  }
}
