import 'package:table_tap_admin/features/product/domain/models/product_model.dart';

class ProductResponse {
  final bool? success;
  final ProductModel? product;
  final List<ProductModel>? products;
  final String? errorMessage;

  const ProductResponse({
    this.success,
    this.product,
    this.products,
    this.errorMessage,
  });
}
