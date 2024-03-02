import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/order/presentation/widget/order_card.dart';
import 'package:table_tap_admin/features/shared/widgets/list_empyty_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

class FilterStateList extends StatelessWidget {
  final String statusOrder;

  const FilterStateList({
    Key? key,
    required this.statusOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final filteredOrder = ref.watch(filteredOrdersProvider(statusOrder));

        return filteredOrder.when(
          data: (orders) {
            if (orders.isEmpty) {
              return const ListEmptyCustomer(message: "No tienes ordenes");
            } else {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: ((context, index) {
                  final order = orders[index];
                  return OrderCard(
                    pos: index,
                    order: order,
                  );
                }),
              );
            }
          },
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          loading: () => const Center(
            child: LoadingCustomer(),
          ),
        );
      },
      key: ValueKey(statusOrder),
    );
  }
}
