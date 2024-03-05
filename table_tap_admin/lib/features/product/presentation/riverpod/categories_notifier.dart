import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/category_repository.dart';

class CategoriesNotifier
    extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  final CategoryRepository categoryRepository;

  CategoriesNotifier({required this.categoryRepository})
      : super(const AsyncLoading()) {
    list();
  }

  Future<void> list() async {
    try {
      state = await AsyncValue.guard(() async {
        final categories = await categoryRepository.getCategories();
        return categories;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await categoryRepository.createCategory(category);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateCategory(CategoryModel category, String id) async {
    state = const AsyncLoading();
    try {
      await categoryRepository.updateCategory(category, id);
      await list();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    list();
    state = const AsyncLoading();
    try {
      await categoryRepository.deleteCategory(categoryId);
      list();
    } catch (error) {
      print(error);
    }
  }

  CategoryModel? getCategotyById(String categoryId) {
    if (state is AsyncData<List<CategoryModel>>) {
      final categories = (state as AsyncData<List<CategoryModel>>).value;
      return categories.firstWhere(
        (category) => category.id == categoryId,
      );
    } else {
      return null;
    }
  }

  List<CategoryModel>? getCategoryByStatus() {
    if (state is AsyncData<List<CategoryModel>>) {
      final categories = (state as AsyncData<List<CategoryModel>>).value;
      final filterCategories =
          categories.where((category) => category.status == true).toList();
      return filterCategories;
    } else {
      return [];
    }
  }
}
