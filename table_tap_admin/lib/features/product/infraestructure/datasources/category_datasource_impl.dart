import 'package:table_tap_admin/features/product/domain/datasources/category_datasource.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';

class CategoryDatasourceImp implements CategoryDatasource {
  @override
  Future<CategoryModel> createCategory(CategoryModel category) {
    // TODO: implement createCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCategory(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel?> updateCategory(CategoryModel category, String id) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
  
  @override
  Future<CategoryModel?> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }
}
