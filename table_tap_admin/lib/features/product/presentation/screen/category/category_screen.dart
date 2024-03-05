import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_add_modal.dart';
import 'package:table_tap_admin/features/product/presentation/widget/category_card.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

import '../../riverpod/provider.dart';
import '../../widget/delete_dismissible.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Categorias")),
      body: categoriesAsync.when(
        loading: () => const Center(child: LoadingCustomer()),
        error: (error, stackTrace) => Center(
          child: Text("Error al cargar las categorías: $error"),
        ),
        data: (categories) {
          return categories.isEmpty
              ? const Center(
                  child: Text("Lista de categorías vacía"),
                )
              : ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return DeleteDismissible(
                      item: category,
                      onDismissed: (category) {
                        _handleDelete(context, category.id!);
                      },
                      child: CategoryCard(category: category),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorSecondary,
        onPressed: () {
          _showAddCategoryModal(context);
        },
        child: const Icon(
          Icons.add,
          color: colorPrincipal,
        ),
      ),
    );
  }

  void _handleDelete(BuildContext context, String id) async {
    try {
      await ref.read(categoriesProvider.notifier).deleteCategory(id);
      messageDialogSucces(
          context, "La categoría se eliminó con éxito", "Proceso exitoso");
    } catch (error) {
      messageDialogError(
          context, "No se pudo eliminar la categoría", "Ocurrió un error");
    }
  }

  void _showAddCategoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const CategoryAddModal(),
          ),
        );
      },
    );
  }
}
