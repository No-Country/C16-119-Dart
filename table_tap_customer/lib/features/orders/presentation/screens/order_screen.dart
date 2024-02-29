import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/products/presentation/providers/providers.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends ConsumerState<OrderScreen> {
  final themeTextStyle = ThemeTextStyle();
  final palette = ThemeColors.palette();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Mesa",
            style: TextStyle(color: palette.primaryText),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.receipt,
                color: palette.secondaryText,
              ),
            )
          ]),
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
      ),
      body: _OrderView(),
    );
  }
}

class _OrderView extends ConsumerWidget {
  final themeTextStyle = ThemeTextStyle();
  final palette = ThemeColors.palette();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsList = ref.watch(productsListProvider);
    Order order = ref.watch(orderSelectedProvider);
    final setAddDish = ref.read(orderSelectedProvider.notifier).setAddDish;
    final setProduct = ref.read(productSelectedProvider.notifier).setProduct;
    final removeAmountDish =
        ref.read(orderSelectedProvider.notifier).setRemoveDish;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: order.dishes.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Carrito vacio!",
                  style: ThemeTextStyle().h1,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_shopping_cart_rounded,
                      color: palette.secondaryText,
                      size: 30,
                    ))
              ],
            ))
          : Column(children: [
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: order.dishes.length,
                  itemBuilder: (context, index) {
                    final dish = order.dishes[index];
                    late ImageProvider imageProvider;
                    if (dish.photos == null || dish.photos.isEmpty) {
                      imageProvider = const AssetImage(
                        'assets/images/no_image.jpg',
                      );
                    } else {
                      imageProvider = NetworkImage(dish.photos[0]);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: palette.main),
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: palette.form,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: () {
                              setProduct(productsList.firstWhere((element) =>
                                  element.dish.idDish == dish.idDish));
                              context.push(RoutesNames.product);
                            },
                            child: FadeInImage(
                                image: imageProvider,
                                placeholder: const AssetImage(
                                    'assets/loaders/loader.gif'),
                                imageErrorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                          'assets/images/no_image.jpg',
                                        ),
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(dish.name, style: themeTextStyle.h3),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("\$ ${dish.price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17,
                                            color: palette.main))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 21,
                                        backgroundColor: palette.main,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: palette.light,
                                          child: IconButton(
                                              onPressed: () =>
                                                  removeAmountDish(dish.idDish),
                                              icon: Icon(
                                                Icons.remove,
                                                color: palette.main,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          '${dish.amount}',
                                          style: themeTextStyle.h3,
                                        ),
                                      ),
                                      CircleAvatar(
                                          radius: 21,
                                          backgroundColor: palette.main,
                                          child: IconButton(
                                            onPressed: () => setAddDish(dish),
                                            icon: const Icon(Icons.add),
                                            color: palette.light,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            if (dish.ingredients != null &&
                                dish.ingredients!.isNotEmpty)
                              Text(
                                dish.ingredients!.join(", ").length <= 50
                                    ? dish.ingredients!.join(", ")
                                    : '${dish.ingredients!.join(", ").substring(0, 65)}...',
                                style: themeTextStyle.p2,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
    );
  }
}
