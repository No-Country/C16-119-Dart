import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/config/theme.dart';
import 'package:table_tap_admin/features/product/domain/models/product_model.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/product/presentation/widget/product_card.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}



class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final List<ProductModel> listProduct = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    handleShowProducts();
  }

  handleShowProducts() async {
    final productsNotifier = ref.read(productsProvider.notifier);
    final products = await productsNotifier.state.getProductAll();
    setState(() {
      listProduct.clear();
      listProduct.addAll(products);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    handleShowProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Productos'),
      ),
      body: SafeArea(
        child: loading
            ? const LoadingCustomer()
            : listProduct.isEmpty
                ? const Text("No se encontraron productos")
                : buildList(listProduct),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorSecondary,
        child: const Icon(
          Icons.add,
          color: colorPrincipal,
        ),
        onPressed: () {
          context.push(RoutesConstants.productAdd);
        },
      ),
    );
  }

  Widget buildList(List<ProductModel?> productList) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return Dismissible(
          key: Key(product!.id!),
          confirmDismiss: (direction) async {
            // Muestra un diálogo de confirmación antes de eliminar
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Confirmar eliminación"),
                content: const Text(
                    "¿Estás seguro de que quieres eliminar este producto?"),
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
            final productsNotifier = ref.read(
              productsProvider.notifier,
            );
            await productsNotifier.state.deleteProduct(product.id!);
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
                    "Eliminan product",
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
            title: ProductCard(product: product!),
          ),
        );
      },
    );
  }
}
