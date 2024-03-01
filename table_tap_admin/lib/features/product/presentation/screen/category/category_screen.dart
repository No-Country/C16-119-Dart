import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_add_modal.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

import '../../riverpod/provider.dart';
import '../../widget/category_card.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    handleShowCategory();
  }

  handleShowCategory() async {
    final categoryNotifier = ref.read(categoriesProvider.notifier);
    await categoryNotifier.state.getCateroryAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Categorías'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final AsyncValue<List<CategoryModel>> categoryState =
              ref.watch(categoiesFutureProvider);

          return categoryState.when(
            loading: () => const LoadingCustomer(),
            error: (error, stackTrace) => Center(
              child: Text("Error al cargar las categorías: $error"),
            ),
            data: (categories) {
              return categories.isEmpty
                  ?const Center(
                      child:  Text("Lista de categorías vacía"),
                    )
                  : ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryCard(category: category);
                      },
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
