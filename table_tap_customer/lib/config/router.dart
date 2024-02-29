import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/orders.dart';
import 'package:table_tap_customer/features/products/products.dart';
import 'package:table_tap_customer/features/scanner/scanner.dart';

final goRouterProvider = GoRouter(
  initialLocation: RoutesNames.scanner,
  // refreshListenable: goRouterNotifier,
  routes: [
    GoRoute(
      path: RoutesNames.scanner,
      builder: (context, state) => const ScannerScreen(),
    ),

    // ///* Product Routes
    GoRoute(
      path: RoutesNames.products,
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: RoutesNames.product, // /product/new
      builder: (context, state) => const ProductScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
    GoRoute(
      path: RoutesNames.order, // /product/new
      builder: (context, state) => const OrderScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
    GoRoute(
      path: RoutesNames.orders, // /product/new
      builder: (context, state) => const ProductsScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
  ],
);
