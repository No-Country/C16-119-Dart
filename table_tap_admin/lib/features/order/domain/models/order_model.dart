import 'package:table_tap_admin/features/order/domain/models/dishes_model.dart';

class OrderModel {
  final String? id;
  final String nameCustomer;
  final int timeTotal;
  final double priceTotal;
  final int? amountTotal;
  final List<DishModel> dishes;
  final String? status;

  OrderModel({
    this.id,
    required this.nameCustomer,
    required this.priceTotal,
    required this.timeTotal,
    this.status,
    required this.amountTotal,
    required this.dishes,
  });

  factory OrderModel.fromJson(Map<Object?, Object?> json, String id) {
    final double _priceTotal = (json['priceTotal'] as num?)?.toDouble() ?? 0.0;
    final int _amountTotal = (json['amountTotal'] as num?)?.toInt() ?? 0;
    final int _timeTotal = (json['timeTotal'] as int?) ?? 0;
    final String? _idOrder = json['idOrder'] as String?;
    final String? _nameCustomer = json['nameCustomer'] as String? ?? '';
    final String? _status = json['status'] as String? ?? '';

    // Mapear la lista de platos
    //final List<DishModel> dishes = (json['dishes'] as List<dynamic>?)
    //        ?.map((dishJson) =>
    //            DishModel.fromJson(dishJson as Map<Object?, Object?>))
    //        .toList() ??
    //    [];

    return OrderModel(
      id: id,
      nameCustomer: _nameCustomer!,
      priceTotal: _priceTotal,
      amountTotal: _amountTotal,
      timeTotal: _timeTotal,
      status: _status,
      dishes: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCustomer': nameCustomer,
      'priceTotal': priceTotal,
      'amountTotal': amountTotal,
      'timeTotal': timeTotal,
      'status': status,
      'dishes': dishes.map((dish) => dish.toJson()).toList(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? nameCustomer,
    double? priceTotal,
    int? amounTotal,
    int? timeTotal,
    String? status,
    List<DishModel>? dishes,
  }) {
    return OrderModel(
      id: id ?? this.id,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      priceTotal: priceTotal ?? this.priceTotal,
      amountTotal: amountTotal ?? this.amountTotal,
      timeTotal: timeTotal ?? this.timeTotal,
      status: status ?? this.status,
      dishes: dishes ?? this.dishes,
    );
  }
}
