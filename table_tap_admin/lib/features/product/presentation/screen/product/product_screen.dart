import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/config/theme.dart';
import 'package:table_tap_admin/features/product/presentation/widget/product_card.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProductScreenState();
}

class ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Widget buildItem(BuildContext context, int index) {
      return Dismissible(key: Key("$index"), child: const ProductCard());
    }

    Widget buildSeparator(BuildContext context, int index) {
      return const Divider();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: buildItem,
        ),
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
}
