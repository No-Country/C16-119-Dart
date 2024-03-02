import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/table/presentation/widget/table_card_widget.dart';

class TableScreen extends ConsumerStatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TableScreenState();
}

class _TableScreenState extends ConsumerState<TableScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de mesas")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorSecondary,
        child: const Icon(
          Icons.add,
          color: colorPrincipal,
        ),
        onPressed: () {
          context.push(RoutesConstants.productAdd);
        },
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
              if (tables.isEmpty) {
                return const Center(
                  child: Text("No hay mesas creadas"),
                );
              } else {
                return buildListItems(tables);
              }
            },
          );
        },
      ),
    );
  }

  Widget buildListItems(final tables) {
    return ListView.builder(
      itemCount: tables.length,
      itemBuilder: (context, index) {
        final item = tables[index];
        String availableText;
        Color statusColor;

        if (item.available!) {
          availableText = "Disponible";
          statusColor = Colors.green;
        } else {
          availableText = "Ocupada";
          statusColor = Colors.red;
        }

        return TableCardWidget(
          table: item,
          availableText: availableText,
          statusColor: statusColor,
        );
      },
    );
  }
}
