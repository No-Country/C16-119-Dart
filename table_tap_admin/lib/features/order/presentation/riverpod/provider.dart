import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/domain/repositories/order_repository.dart';
import 'package:table_tap_admin/features/order/infraestructure/datadources/order_datasource_impl.dart';
import 'package:table_tap_admin/features/order/infraestructure/repositories/order_repository_impl.dart';
import 'package:table_tap_admin/features/order/presentation/riverpod/order_notifier.dart';

// provedor de repositorios
final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OderRepositoryImpl(
    orderDatasource: OrderDatasourceImpl(),
  ),
);

// Proveedor para las entidades
final ordersProvider = StateProvider<OrderNotifier>(
  (ref) => OrderNotifier(
    orderRepository: ref.read(
      orderRepositoryProvider,
    ),
  ),
);
