import 'package:table_tap_admin/features/data/products_data.dart';
import 'package:table_tap_admin/features/product/infraestructure/reponse/category_response.dart';
import 'package:table_tap_admin/features/product/infraestructure/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<CategoryResponse> getCategories() async {
    final categorias =
        CategoryResponse(success: true, categories: categories.first);
    return categorias;
  }

  @override
  Future<CategoryResponse> getCategory(String id) async {
    for (var categoria in categories) {
      if (categoria.id == id) {
        return CategoryResponse(
          success: true,
          category: categoria,
        );
      }
    }
    return const CategoryResponse(
      success: false,
      errorMessage: 'hay un error',
    );
  }

  @override
  Future<CategoryResponse> setAddCategory(CategoryResponse product) {
    // TODO: implement setAddCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> setDeleteCategory(String id) {
    // TODO: implement setDeleteCategory
    throw UnimplementedError();
  }

  @override
  Future<CategoryResponse> setEditCategory(
      CategoryResponse product, String id) {
    // TODO: implement setEditCategory
    throw UnimplementedError();
  }
}
