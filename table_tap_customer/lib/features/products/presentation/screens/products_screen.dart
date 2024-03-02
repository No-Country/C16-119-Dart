import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/orders.dart';
import 'package:table_tap_customer/features/orders/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/scanner/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/shared/shared.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends ConsumerState<ProductsScreen> {
  List productsList = [];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    ref.read(orderSelectedProvider.notifier).getOrderLocal();
    ref.read(tableSelectedProvider.notifier).getTableLocal();
    // ref.read(productsListProvider.notifier).loadNextPage();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final table = ref.watch(tableSelectedProvider);

    ThemeColors palette = ThemeColors.palette();

    void onItemTapped(int index) {
      if (index == 1) {
        kIsWeb
            ? context.push(RoutesNames.tables)
            : context.push(RoutesNames.scanner);
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    }

    List<Widget> widgetOptions = [
      _ProductsList(),
      const Text("Qr"),
      const OrderScreen()
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Mesa ${table.number}",
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
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: palette.main,
          unselectedItemColor: palette.secondaryText,
          onTap: onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 60,
                width: 60,
                child: FloatingActionButton(
                    onPressed: () => kIsWeb
                        ? context.push(RoutesNames.tables)
                        : context.push(RoutesNames.scanner),
                    child: kIsWeb
                        ? const Icon(
                            Icons.table_restaurant,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          )),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Cart',
            ),
          ]),
    );
  }
}

class _ProductsList extends ConsumerWidget {
  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    List<Product> productsList = ref.watch(productsListFilteredProvider);
    ThemeColors palette = ThemeColors.palette();
    final selectedCategory = ref.watch(categoryProductsFilteredProvider);
    final setAddDish = ref.read(orderSelectedProvider.notifier).setAddDish;
    final setProduct = ref.read(productSelectedProvider.notifier).setProduct;
    final setCategoryProductsFiltered = ref
        .read(categoryProductsFilteredProvider.notifier)
        .setCategoryProductsFiltered;
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categorías", style: ThemeTextStyle().h1),
          SegmentedButton(
              showSelectedIcon: false,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return palette.main;
                  }
                  return palette.form;
                },
              )),
              segments: [
                ButtonSegment(
                    value: CategoryProducts.todos,
                    label: Text(
                      "Todos",
                      style: TextStyle(
                          color: selectedCategory == CategoryProducts.todos
                              ? Colors.white
                              : palette.secondaryText),
                    )),
                ButtonSegment(
                    value: CategoryProducts.fuertes,
                    label: Text(
                      "Fuertes",
                      style: TextStyle(
                          color: selectedCategory == CategoryProducts.fuertes
                              ? Colors.white
                              : palette.secondaryText),
                    )),
                ButtonSegment(
                    value: CategoryProducts.bebidas,
                    label: Text(
                      "Bebidas",
                      style: TextStyle(
                          color: selectedCategory == CategoryProducts.bebidas
                              ? Colors.white
                              : palette.secondaryText),
                    )),
                ButtonSegment(
                    value: CategoryProducts.postres,
                    label: Text(
                      "Postres",
                      style: TextStyle(
                          color: selectedCategory == CategoryProducts.postres
                              ? Colors.white
                              : palette.secondaryText),
                    ))
              ],
              selected: {selectedCategory},
              onSelectionChanged: (value) =>
                  setCategoryProductsFiltered(value.first)),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                Product product = productsList[index];
                late ImageProvider imageProvider;
                if (product.dish.photos == null ||
                    product.dish.photos.isEmpty) {
                  imageProvider = const AssetImage(
                    'assets/images/no_image.jpg',
                  );
                } else {
                  imageProvider = NetworkImage(product.dish.photos[0]);
                }
                return Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: () {
                              setProduct(product);
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
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundColor: palette.main,
                            child: IconButton(
                              // heroTag: "addDish",
                              onPressed: () {
                                MsgSnackBar.show(
                                    context, "Producto agregado", palette.main);
                                setAddDish(product.dish);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            product.dish.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: palette.primaryTitle),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "Food - ${product.time} mins",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: palette.secondaryText),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
