import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';
import 'package:table_tap_admin/features/order/presentation/widget/popup_menu_widget.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';

class OrderCard extends ConsumerWidget {
  final OrderModel order;
  final int pos;

  const OrderCard({
    Key? key,
    required this.pos,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final tableAsyc = ref.read(tablesProvider.notifier);
    final table = tableAsyc.getTableById(order.tableId);

    return ListTile(
      title: Text(
        'Mesa ${table!.number}',
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Cant P: ${order.amountTotal}'),
            Text(getStatusText(order.status!)),
          ]),
      trailing: PopupMenuWidet(orderId: order.id!),
      onTap: () {
        context.push(RoutesConstants.orderDetail, extra: {"id": order.id});
      },
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pendiente';
      case 'processing':
        return 'En proceso';
      case 'complete':
        return 'Completa';
      case 'finish':
        return 'Finalizada';
      default:
        return 'pending';
    }
  }
}
