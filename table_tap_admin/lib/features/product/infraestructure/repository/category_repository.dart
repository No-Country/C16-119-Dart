import 'package:table_tap_admin/features/product/infraestructure/reponse/category_response.dart';

abstract class CategoryRepository {
  // crear prodcuto
  Future<CategoryResponse> setAddCategory(CategoryResponse product);

  // eliminar producto
  Future<bool> setDeleteCategory(String id);

  // editar producto
  Future<CategoryResponse> setEditCategory(CategoryResponse product, String id);

  // listar todos los productos
  Future<CategoryResponse> getCategories();

  // buscar por id
  Future<CategoryResponse> getCategory(String id);
}
