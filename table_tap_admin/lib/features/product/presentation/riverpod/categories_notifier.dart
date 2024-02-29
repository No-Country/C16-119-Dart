import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/domain/repositories/category_repository.dart';

class CategoriesNotifier
    extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  final CategoryRepository categoryRepository;

  CategoriesNotifier({required this.categoryRepository})
      : super(const AsyncLoading()) {
    _list();
  }

  Future<void> _list() async {
    state = await AsyncValue.guard(() async {
      final categories = await categoryRepository.getCategories();
      return categories;
    });
  }

  Future<void> addCategory(CategoryModel category) async {
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
    state = const AsyncLoading();
    try {
      await categoryRepository.deleteCategory(CategoryId);
      final updatedCategory = await categoryRepository.getCategories();
      state = AsyncData(updatedCategory);
    } catch (error) {
      print(error);
    }
  }
}
