import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';

class DetailHeader extends ConsumerWidget {
  final OrderModel order;
  const DetailHeader({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final tableAsync = ref.watch(tablesProvider.notifier);
    final table = tableAsync.getTableById(order.tableId);
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "ID: ${order.id ?? ''}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Mesa No ${table!.number ?? ''}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Estado: ${order.status ?? ''}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: order.status != "finish" ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total apagar \$${order.priceTotal}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
