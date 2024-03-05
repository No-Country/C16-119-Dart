import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/table/presentation/widget/qr_details_widget.dart';
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
          final tableAsyn = ref.watch(tablesProvider.notifier);
          final table = tableAsyn.getTableById(widget.tableId);

          return table == null
              ? const Center(child: LoadingCustomer())
              :QrDetailsWidget(table: table) ;
        }
      ),
    );
  }
}
