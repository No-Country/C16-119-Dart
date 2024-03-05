import 'package:flutter/material.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';

class DetailHeader extends StatelessWidget {
  final OrderModel order;
  const DetailHeader({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "ID: ${order.id}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Mesa No ${order.nameCustomer}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Estado: ${order.status}",
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
