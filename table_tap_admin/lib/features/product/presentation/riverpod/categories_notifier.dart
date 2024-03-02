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
    list();
    state = const AsyncLoading();
    try {
      await categoryRepository.createCategory(category);
      final updatedCategory = await categoryRepository.getCategories();
      state = AsyncData(updatedCategory);
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateCategory(CategoryModel Category, String id) async {
    list();
    state = const AsyncLoading();
    try {
      await categoryRepository.updateCategory(Category, id);
      final updatedCategory = await categoryRepository.getCategories();
      state = AsyncData(updatedCategory);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteCategory(String CategoryId) async {
    list();
    state = const AsyncLoading();
    try {
      await categoryRepository.deleteCategory(CategoryId);
      final updatedCategory = await categoryRepository.getCategories();
      state = AsyncData(updatedCategory);
    } catch (error) {
      print(error);
    }
  }

  CategoryModel? getCategotyById(String categoryId) {
    list();
    if (state is AsyncData<List<CategoryModel>>) {
      final categories = (state as AsyncData<List<CategoryModel>>).value;
      return categories.firstWhere(
        (category) => category.id == categoryId,
      );
    } else {
      return null;
    }
  }

  Future<List<CategoryModel>> getCateroryAll() async {
    list();
    if (state is AsyncData<List<CategoryModel>>) {
      final categories = (state as AsyncData<List<CategoryModel>>).value;
      return categories;
    } else {
      return [];
    }
  }
}
