import 'package:table_tap_admin/features/product/domain/datasources/category_datasource.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource categoryDatasource;

  CategoryRepositoryImpl({required this.categoryDatasource});

  @override
  Future<CategoryModel> createCategory(CategoryModel category) {
    return categoryDatasource.createCategory(category);
  }

  @override
  Future<bool> deleteCategory(String id) {
    return categoryDatasource.deleteCategory(id);
  }

  @override
  Future<List<CategoryModel>> getCategories() {
    return categoryDatasource.getCategories();
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) {
    return categoryDatasource.getCategoryById(id);
  }

  @override
  Future<CategoryModel?> updateCategory(CategoryModel category, String id) {
    return categoryDatasource.updateCategory(category, id);
  }
}
