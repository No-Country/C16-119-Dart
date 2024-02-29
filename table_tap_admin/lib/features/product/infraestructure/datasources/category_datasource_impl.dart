import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/domain/datasources/category_datasource.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';

class CategoryDatasourceImp implements CategoryDatasource {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<CategoryModel> createCategory(CategoryModel category) async {
    final result = await _firebase.collection(Constants.tableCategory).add(
          category.toJson(),
        );
    final data = await result.get();
    final createdProduct = CategoryModel.fromJson(data.data()!, data.id);
    return createdProduct;
  }

  @override
  Future<bool> deleteCategory(String id) async {
    try {
      await _firebase.collection(Constants.tableCategory).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      var result = await _firebase.collection(Constants.tableCategory).get();
      return result.docs.map((doc) {
        final categoryId = doc.id;
        return CategoryModel.fromJson(
          doc.data(),
          categoryId,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<CategoryModel?> updateCategory(
      CategoryModel category, String id) async {
    try {
      await _firebase
          .collection(Constants.tableCategory)
          .doc(id)
          .update(category.toJson());
      return category.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) async {
    try {
      var snapshot =
          await _firebase.collection(Constants.tableCategory).doc(id).get();
      if (snapshot.exists) {
        return CategoryModel.fromJson(
            snapshot.data() as Map<String, dynamic>, id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
