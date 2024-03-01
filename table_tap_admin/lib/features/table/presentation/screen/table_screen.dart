import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/table_provider.dart';

class TableScreen extends ConsumerStatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TableScreenState();
}

class _TableScreenState extends ConsumerState<TableScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTablesAndUpdateProvider();
  }

  Future<void> _fetchTablesAndUpdateProvider() async {
    final tableRepository = ref.read(tableRepositoryProvider);
    final tables = await tableRepository.getTables();
    ref.read(tableProvider.notifier).state = tables;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tables = ref.watch(tableProvider);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: IconButton(
        color: colorSecondary,
        onPressed: () {
          context.push(RoutesConstants.tableAdd);
        },
        icon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.add, color: colorTerciario),
        ),
      ),
      body: isLoading
          ? const Center(
              child: LoadingCustomer(),
            )
          : tables.isEmpty
              ? const Center(
                  child: Text("No hay mesas creadas"),
                )
              : buildListItems(tables),
    );
  }

  Widget buildListItems(final tables) {
    return ListView.builder(
      itemCount: tables.length,
      itemBuilder: (context, index) {
        final item = tables[index];
        String available;
        if (item.available!) {
          available = "Disponible";
        } else {
          available = "Ocupada";
        }
        return ListTile(
          title: Text("Mesa ${item.number}"),
          subtitle: Text(available),
        );
      },
    );
  }

  Widget buildItem(String id) {
    return Column(
      children: [
        QrImageView(
          data: id,
          size: 100,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
