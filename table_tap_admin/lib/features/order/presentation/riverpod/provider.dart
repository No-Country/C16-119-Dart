import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';
import 'package:table_tap_admin/features/order/domain/repositories/order_repository.dart';
import 'package:table_tap_admin/features/order/infraestructure/datadources/order_datasource_impl.dart';
import 'package:table_tap_admin/features/order/infraestructure/repositories/order_repository_impl.dart';

// provedor de repositorios
final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepositoryImpl(
    orderDatasource: OrderDatasourceImpl(),
  ),
);

// Proveedor para los datos real time
final ordersProvider = StreamProvider<List<OrderModel>>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return repository.getOrders();
});

final filteredOrdersProvider =
    StreamProvider.family<List<OrderModel>, String>((ref, state) {
  final repository = ref.watch(orderRepositoryProvider);
  return repository.getOrders().map((orders) {
    return orders.where((order) => order.status == state).toList();
  });
});
