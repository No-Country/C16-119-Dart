import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/presentation/widget/filter_state_list.dart';

class OrdersTabProcessing extends ConsumerWidget {
  const OrdersTabProcessing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return const FilterStateList(statusOrder: "processing");
  }
}
