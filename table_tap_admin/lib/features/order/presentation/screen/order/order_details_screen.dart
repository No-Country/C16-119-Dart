import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/order/presentation/widget/detail_content.dart';
import 'package:table_tap_admin/features/order/presentation/widget/detail_header.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles de la orden"),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final order = ref.watch(orderById(orderId));
          final dishes = order.value!.dishes;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DetailHeader(order: order.value!),
               DetailContent(dishes: dishes),
              ],
            ),
          );
        },
        key: ValueKey(orderId),
      ),
    );
  }
}
