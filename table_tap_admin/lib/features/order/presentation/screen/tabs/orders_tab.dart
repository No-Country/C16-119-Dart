import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/order/presentation/widget/order_card.dart';
import 'package:table_tap_admin/features/shared/widgets/list_empyty_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

class OrdersTab extends ConsumerWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ordersList = ref.watch(ordersProvider);
    return ordersList.when(
      data: (orders) {
        return orders.isEmpty
            ? const ListEmptyCustomer(message: "No hay ordenes para mostrar")
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Column(
                    children: [
                      OrderCard(pos: index, order: order),
                      index < orders.length ? const Divider() : Container()
                    ],
                  );
                });
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error ')),
      loading: () => const Center(
        child: LoadingCustomer(),
      ),
    );
  }
}
