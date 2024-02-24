import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_tap_customer/features/orders/domain/domain.dart';
import 'package:table_tap_customer/features/orders/presentation/providers/providers.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

// class OrderScreen extends StatelessWidget {
class OrderScreenState extends ConsumerState<OrderScreen> {
  final themeTextStyle = ThemeTextStyle();
  final palette = ThemeColors.palette();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // void _insert() async {
  //   final SharedPreferences prefs = await _prefs;
  //   // await prefs.setInt("asd", 20);
  //   prefs.setString(
  //       "user",
  //       jsonEncode({
  //         "orders": [
  //           {
  //             "amountTotal": 2,
  //             "nameCustomer": "paco",
  //             "priceTotal": 20000,
  //             "timeTotal": 25,
  //             "dishes": [
  //               {
  //                 "name": "ajiaco",
  //                 "price": 10000,
  //                 "amount": 2,
  //                 "photos": [],
  //                 "ingredients": []
  //               }
  //             ]
  //           },
  //           {
  //             "amountTotal": 3,
  //             "nameCustomer": "sol",
  //             "priceTotal": 30000,
  //             "timeTotal": 25
  //           },
  //           {
  //             "amountTotal": 1,
  //             "nameCustomer": "luna",
  //             "priceTotal": 15000,
  //             "timeTotal": 15
  //           }
  //         ]
  //       }));

  //   print("insert");
  // }

  // void _get() async {
  //   final SharedPreferences prefs = await _prefs;
  //   final res = await prefs.getString("user");
  //   print(res.runtimeType);
  //   print(jsonDecode(res!).runtimeType);
  // }

  // final db = DbService();
  // void _get() async {
  //   await db.getData();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getOrderDb = ref.read(ordersSelectedProvider.notifier).getOrdersDb;
    // final saveOrdersDb = ref.read(ordersSelectedProvider.notifier).saveOrders();
    final setAddDish = ref.read(orderSelectedProvider.notifier).setAddDish;
    Order order = ref.watch(orderSelectedProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Mesa")),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Text("+"),
              onPressed: () => {
                    getOrderDb()
                    // setAddDish(name: "Ajiaco", photos: [], price: 2000),
                    // _insert()
                    // setNewNameCustomer( newNameCustomer: "LUis")
                  }),
          FloatingActionButton(
              child: const Text("save"),
              onPressed: () => {
                    ref.read(ordersSelectedProvider.notifier).saveOrders()
                    // _get()
                  }),
        ],
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
    Order order = ref.watch(orderSelectedProvider);
    final addAmountDish =
        ref.read(orderSelectedProvider.notifier).addAmountDish;
    final removeAmountDish =
        ref.read(orderSelectedProvider.notifier).removeAmountDish;
    // List<Dish> orderDishes = ref.watch(orderDishesSelectedProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(children: [
        Text(
          "Carrito ${order.nameCustomer}",
          style: themeTextStyle.h1,
          textAlign: TextAlign.end,
        ),
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
                    child: FadeInImage(
                        image: imageProvider,
                        placeholder:
                            const AssetImage('assets/loaders/loader.gif'),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/no_image.jpg',
                            ),
                        fit: BoxFit.cover),
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
                              Text("\$ 35",
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
                                      onPressed: () =>
                                          addAmountDish(dish.idDish),
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
