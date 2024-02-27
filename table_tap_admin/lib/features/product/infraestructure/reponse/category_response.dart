import 'package:table_tap_admin/features/product/domain/models/category_model.dart';

class CategoryResponse {
  final bool? success;
  final CategoryModel? category;
  final CategoryModel? categories;
  final String? errorMessage;

  const CategoryResponse({
    this.success,
    this.category,
    this.categories,
    this.errorMessage,
  });
}
