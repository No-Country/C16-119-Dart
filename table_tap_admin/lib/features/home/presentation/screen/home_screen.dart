import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/home/presentation/widget/profile_widget.dart';
import 'package:table_tap_admin/features/order/presentation/screen/order/order_screen.dart';
import 'package:table_tap_admin/features/product/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/register_res_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/resturant_screen.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_screen.dart';
import 'package:table_tap_admin/features/users/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/users/presentation/screen/user/user_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool d1Open = false;

  late int isSelected = 0;

  List<Map<String, dynamic>> drawerOptions = [
    {"title": "Productos", "icon": Icons.shopping_basket},
    {"title": "Categorias", "icon": Icons.category},
    {"title": "Ordenes", "icon": Icons.shopping_cart},
    {"title": "Mesas", "icon": Icons.table_chart},
    {"title": "Resturante", "icon": Icons.restaurant},
    {"title": "Usuarios", "icon": Icons.people},
  ];

  Widget _buildContent() {
    switch (isSelected) {
      case 0:
        return const ProductScreen();
      case 1:
        return const CategoryScreen();
      case 2:
        return const OrderScreen();
      case 3:
        return const TableScreen();
      case 4:
        return const RestaurantScreen();
      case 5:
        return const UserScreen();
      default:
        return Container();
    }
  }

  closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    d1Open = false;
    setState(() {});
  }

  openDrawer() {
    xOffset = 200;
    yOffset = 80;
    scaleFactor = 0.8;
    d1Open = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initEntities();
  }

  void initEntities() async {
    final categoryPr = ref.read(categoriesProvider.notifier);
    final productsPr = ref.read(productsProvider.notifier);
    final usersPr = ref.read(usersProvider.notifier);
    final tablesPr = ref.read(tablesProvider.notifier);
    await categoryPr.list();
    await productsPr.list();
    await usersPr.state.list();
    await tablesPr.list();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 1))
        .then((value) => openDrawer());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(usuarioProvider.notifier);
    final user = userProvider.state!.user;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xff335a5a),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileWidget(user: user!),
                const SizedBox(height: 24),
                ...List.generate(
                  drawerOptions.length,
                  (index) {
                    final option = drawerOptions[index];
                    return ListTile(
                      title: Text(
                        option["title"],
                        style: TextStyle(
                          fontSize: 20,
                          color: isSelected == index
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                      leading: Icon(
                        option["icon"],
                        color:
                            isSelected == index ? Colors.white : Colors.white54,
                      ),
                      onTap: () {
                        isSelected = index;

                        closeDrawer();
                        setState(() {});
                      },
                    );
                  },
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(left: 16, bottom: 24),
                  child: ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.logout, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "Salir",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      closeDrawer();
                      setState(() {
                        handleCloseSession(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              closeDrawer();
              setState(() {});
            },
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: d1Open
                    ? BorderRadius.circular(16)
                    : BorderRadius.circular(0),
              ),
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(d1Open ? Icons.arrow_back : Icons.menu,
                                size: 24),
                            onPressed: () {
                              if (d1Open) {
                                closeDrawer();
                              } else {
                                xOffset = 200;
                                yOffset = 80;
                                scaleFactor = 0.8;
                                d1Open = true;
                              }
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            return _buildContent();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onPanUpdate: (d) {
              closeDrawer();
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  handleCloseSession(BuildContext context) async {
    final usuario = ref.read(usuarioProvider.notifier);
    try {
      await usuario.logout();
      context.go(RoutesConstants.login);
    } catch (error) {
      _buidMessage(error.toString());
    } finally {
      setState(() {});
    }
  }

  void _buidMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
