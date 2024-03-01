import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/domain/repositories/table_repository.dart';
import 'package:table_tap_admin/features/table/infraestructure/datadources/remote/table_datasource_remote_impl.dart';
import 'package:table_tap_admin/features/table/infraestructure/repositories/table_repository_impl.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/table_notifier.dart';

final tableRepositoryProvider = Provider<TableRepository>(
  (ref) => TableRepositoryImp(tableDatasource: TableDatasourceRemoteImpl()),
);

// Proveedor para las entidades
final productsProvider = StateProvider<TableNotifier>(
  (ref) => TableNotifier(
    tableRepository: ref.read(
      tableRepositoryProvider,
    ),
  ),
);

final tableProvider = StateProvider<List<TableModel>>((ref) => []);

final tablesFutureProvider = FutureProvider<List<TableModel>>((ref) async {
  final tableRepository = ref.read(tableRepositoryProvider);
  return await tableRepository.getTables();
});