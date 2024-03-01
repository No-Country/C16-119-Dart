import 'package:table_tap_admin/features/order/domain/models/dishes_model.dart';

enum OrderStatus {
  pending,
  processing,
  completed,
}

class OrderModel {
  final String? id;
  final List<ItemOrder> listProducts;
  final int countTotal;
  final double priceTotal;
  final OrderStatus status;

  const OrderModel({
    required this.listProducts,
    required this.priceTotal,
    required this.countTotal,
    required this.status,
    this.id,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: id,
      listProducts: (json['listProducts'] as List<dynamic>)
          .map((productJson) => ItemOrder.fromJson(productJson))
          .toList(),
      countTotal: json['countTotal'] as int,
      priceTotal: json['priceTotal'] as double,
      status: _parseOrderStatus(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listProducts': listProducts.map((product) => product.toJson()).toList(),
      'countTotal': countTotal,
      'priceTotal': priceTotal,
      'status': _orderStatusToString(status),
    };
  }

  static OrderStatus _parseOrderStatus(String status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'completed':
        return OrderStatus.completed;
      default:
        throw Exception('Unexpected order status: $status');
    }
  }

  static String _orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.processing:
        return 'processing';
      case OrderStatus.completed:
        return 'completed';
    }
  }

  OrderModel copyWith({
    String? id,
    List<ItemOrder>? listProducts,
    int? countTotal,
    double? priceTotal,
    OrderStatus? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      listProducts: listProducts ?? this.listProducts,
      countTotal: countTotal ?? this.countTotal,
      priceTotal: priceTotal ?? this.priceTotal,
      status: status ?? this.status,
    );
  }
}
