import 'package:table_tap_admin/features/product/domain/models/category_model.dart';

abstract class CategoryRepository {
  // crear
  Future<CategoryModel> createCategory(CategoryModel category);

  // eliminar
  Future<bool> deleteCategory(String id);

  // editar
  Future<CategoryModel?> updateCategory(CategoryModel category, String id);

  // listar todos
  Future<List<CategoryModel>> getCategories();

  // buscar por id
  Future<CategoryModel?> getCategoryById(String id);
}
