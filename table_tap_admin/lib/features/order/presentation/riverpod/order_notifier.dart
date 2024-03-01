import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/order/domain/models/order_model.dart';
import 'package:table_tap_admin/features/order/domain/repositories/order_repository.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/product_repository.dart';

class OrderNotifier extends StateNotifier<AsyncValue<List<OrderModel>>> {
  final OrderRepository orderRepository;

  OrderNotifier({required this.orderRepository}) : super(const AsyncLoading()) {
    list();
  }

  Future<void> list() async {
    try {
      state = await AsyncValue.guard(() async {
        final orders = await orderRepository.getOrders();
        return orders;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addOrder(OrderModel order) async {
    state = const AsyncLoading();
    try {
      await orderRepository.createOrder(order);
      final updatedOrders = await orderRepository.getOrders();
      state = AsyncData(updatedOrders);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateOrder(OrderModel order, String id) async {
    state = const AsyncLoading();
    try {
      await orderRepository.updateOrder(order, id);
      final updatedOrder = await orderRepository.getOrders();
      state = AsyncData(updatedOrder);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteOrder(String orderId) async {
    state = const AsyncLoading();
    try {
      await orderRepository.deleteOrder(orderId);
      final updatedOrders = await orderRepository.getOrders();
      state = AsyncData(updatedOrders);
    } catch (error) {
      print(error);
    }
  }

  OrderModel? getOrderById(String orderId) {
    if (state is AsyncData<List<OrderModel>>) {
      final orders = (state as AsyncData<List<OrderModel>>).value;
      return orders.firstWhere(
        (order) => order.id == order,
      );
    } else {
      return null;
    }
  }

  Future<List<OrderModel>> getOrderAll() async {
    await list();
    if (state is AsyncData<List<OrderModel>>) {
      final orders = (state as AsyncData<List<OrderModel>>).value;
      return orders;
    } else {
      return [];
    }
  }
}
