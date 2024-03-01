import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/theme.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_add_modal.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

import '../../../domain/models/category_model.dart';
import '../../riverpod/provider.dart';
import '../../widget/category_card.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final List<CategoryModel> listCategory = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    handleShowCategory();
  }

  handleShowCategory() async {
    final categoryNotifier = ref.read(categoriesProvider.notifier);
    final category = await categoryNotifier.state.getCateroryAll();

    setState(() {
      listCategory.clear();
      listCategory.addAll(category);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    handleShowCategory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Categorias'),
      ),
      body: SafeArea(
        child: loading
            ? const LoadingCustomer()
            : listCategory.isEmpty
                ? const Text("Lista de categoria vacia")
                : buildList(listCategory),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorSecondary,
        child: const Icon(
          Icons.add,
          color: colorPrincipal,
        ),
        onPressed: () {
          _showAddCategoryModal(context);
        },
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

  Widget buildList(List<CategoryModel?> categoriesList) {
    return ListView.builder(
      itemCount: categoriesList.length,
      itemBuilder: (context, index) {
        final category = categoriesList[index];
        return Dismissible(
          key: Key(category!.id!),
          confirmDismiss: (direction) async {
            // Muestra un diálogo de confirmación antes de eliminar
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Confirmar eliminación"),
                content: const Text(
                    "¿Estás seguro de que quieres eliminar esta categoria?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Eliminar"),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) async {
            final categoryNotifier = ref.read(categoriesProvider.notifier);
            await categoryNotifier.state.deleteCategory(category.id!);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Eliminando categoria",
                    style: TextStyle(color: colorPrincipal, fontSize: 25),
                  ),
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 50,
                ),
              ],
            ),
          ),
          child: ListTile(
            title: CategoryCard(category: category),
          ),
        );
      },
    );
  }
}
