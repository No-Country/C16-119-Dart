import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/orders.dart';
import 'package:table_tap_customer/features/orders/presentation/providers/providers.dart';
import 'package:table_tap_customer/features/products/domain/domain.dart';
import 'package:table_tap_customer/features/products/presentation/providers/providers.dart';

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
    // ref.read(productsListProvider.notifier).loadNextPage();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final loadNextPage = ref.read(productsListProvider.notifier).loadNextPage;
    CollectionReference collectionReferenceProducts =
        db.collection(DbNames.products);
    save() {
      collectionReferenceProducts.add({
        "available": false,
        "category": "Fuertes",
        "description":
            "dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet",
        "ingredients": [
          "queso",
          "papa",
          "huevos",
          "salsas",
          "cebolla",
          "carne"
        ],
        "likes": 487,
        "name": "CARNES",
        "photos": [
          "https://images.pexels.com/photos/15439289/pexels-photo-15439289/free-photo-of-top-view-of-a-bowl-of-soup-with-meat.jpeg?auto=compress&cs=tinysrgb&w=600",
          "https://images.pexels.com/photos/15433931/pexels-photo-15433931/free-photo-of-sushi-served-in-a-restaurant.jpeg?auto=compress&cs=tinysrgb&w=600"
        ],
        "price": 28768,
        "time": 34
      });
    }

    ThemeColors palette = ThemeColors.palette();

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    List<Widget> widgetOptions = [
      _ProductsList(),
      const Text("Qr"),
      const OrderScreen()
    ];

    return Scaffold(
      // appBar: AppBar(title: const Text("Lsita de productos")),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: loadNextPage,
      //   child: const Icon(Icons.refresh),
      // ),
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
                  onPressed: () => onItemTapped(1),
                  child: const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                ),
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
  Widget build(BuildContext contex, WidgetRef ref) {
    List<Product> productsList = ref.watch(productsListFilteredProvider);
    ThemeColors palette = ThemeColors.palette();
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: palette.main,
      content: const Text('Producto agregado'),
    );
    final selectedCategory = ref.watch(categoryProductsFilteredProvider);
    final setAddDish = ref.read(orderSelectedProvider.notifier).setAddDish;
    final setProduct = ref.read(productSelectedProvider.notifier).setProduct;
    final setCategoryProductsFiltered = ref
        .read(categoryProductsFilteredProvider.notifier)
        .setCategoryProductsFiltered;
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("Categorías", style: ThemeTextStyle().h1),
          ),
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
          SizedBox(
            height: 10,
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
                                setAddDish(product.dish);
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
                    SizedBox(
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
