import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

class ItemOrder {
  final ProductModel product;
  final int count;
  final String? note;

  const ItemOrder({
    required this.count,
    required this.product,
    this.note,
  });

  factory ItemOrder.fromJson(Map<String, dynamic> json) {
    return ItemOrder(
      count: json['count'] as int,
      product:
          ProductModel.fromJson(json['product'] as Map<String, dynamic>, ""),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'product': product.toJson(),
      'note': note,
    };
  }
}
