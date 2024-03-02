import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/table/presentation/widget/table_card_widget.dart';

class TableDetailsScreen extends ConsumerStatefulWidget {
  final String tableId;

  const TableDetailsScreen({
    Key? key,
    required this.tableId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TableDetailsScreenState();
}

class _TableDetailsScreenState extends ConsumerState<TableDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles de la mesa"),
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<List<TableModel>> tableState =
              ref.watch(tablesFutureProvider);

          return tableState.when(
            loading: () => const Center(
              child: LoadingCustomer(),
            ),
            error: (error, stackTrace) => const Center(
              child: Text("Error al cargar las mesas"),
            ),
            data: (tables) {
              final table = tables.firstWhere(
                (table) => table.id == widget.tableId,
              );

              if (table == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: QrImageView(
                        data: table.id!,
                        version: QrVersions.auto,
                        size: 350,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Detalles de la mesa',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('ID: ${table.id}'),
                    Text('Mesa No. ${table.number}'),
                    Text(
                      'Estado: ${table.available! ? "Disponible" : "Ocupada"}',
                      style: TextStyle(
                        color: table.available! ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
