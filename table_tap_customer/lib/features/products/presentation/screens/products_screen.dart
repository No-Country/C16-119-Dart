import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/presentation/providers/providers.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends ConsumerState<ProductsScreen> {
  List productsList = [];
  @override
  void initState() {
    super.initState();
    // ref.read(productsListProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final loadNextPage = ref.read(productsListProvider.notifier).loadNextPage;
    final setProduct = ref.read(productSelectedProvider.notifier).setProduct;

    List<Product> productsList = ref.watch(productsListProvider);
    ThemeColors palette = ThemeColors.palette();
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: palette.main,
      content: const Text('Producto agregado'),
    );
    return Scaffold(
        appBar: AppBar(title: Text("Lsita de productos")),
        floatingActionButton: FloatingActionButton(
          onPressed: loadNextPage,
          child: Icon(Icons.refresh),
        ),
        body: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            Product product = productsList[index];

            return ListTile(
              title: Text(product.dish.name),
              leading: IconButton(
                  onPressed: () {
                    context.push(RoutesNames.product);
                    setProduct(product);
                  },
                  icon: Icon(Icons.remove_red_eye)),
              trailing: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: Icon(Icons.add)),
            );
          },
        )
        // floatingActionButton: FloatingActionButton(onPressed: () => get()),
        // onPressed: () => context.push("/product"), child: Text("GO")),
        );
  }
}
