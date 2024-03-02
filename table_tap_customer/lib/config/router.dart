import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/config/config.dart';
import 'package:table_tap_customer/features/orders/orders.dart';
import 'package:table_tap_customer/features/products/products.dart';
import 'package:table_tap_customer/features/scanner/scanner.dart';

final goRouterProvider = GoRouter(
  initialLocation: kIsWeb ? RoutesNames.tables : RoutesNames.scanner,
  // refreshListenable: goRouterNotifier,
  routes: [
    GoRoute(
      path: RoutesNames.scanner,
      name: RoutesNames.scanner,
      builder: (context, state) => const ScannerScreen(),
    ),
    GoRoute(
      path: RoutesNames.tables,
      name: RoutesNames.tables,
      builder: (context, state) => const TablesScreen(),
    ),
    GoRoute(
      path: RoutesNames.products,
      name: RoutesNames.products,
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: RoutesNames.product, // /product/new
      name: RoutesNames.product, // /product/new
      builder: (context, state) => const ProductScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
    GoRoute(
      path: RoutesNames.order, // /product/new
      name: RoutesNames.order, // /product/new
      builder: (context, state) => const OrderScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
    GoRoute(
      path: RoutesNames.orders, // /product/new
      name: RoutesNames.orders, // /product/new
      builder: (context, state) => const ProductsScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
  ],
);
