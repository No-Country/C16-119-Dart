import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/users/presentation/riverpod/provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final categoryPr = ref.read(categoriesProvider.notifier);
    final productsPr = ref.read(productsProvider.notifier);
    final usersPr = ref.read(usersProvider.notifier);
    final tablesPr = ref.read(tablesProvider.notifier);

    return Text("Listando datos ");
  }

  Widget buildItem(IconData icono, String name, int count) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 48),
            SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("$count",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
