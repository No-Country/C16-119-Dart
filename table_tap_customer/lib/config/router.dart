import 'package:go_router/go_router.dart';
import 'package:table_tap_customer/features/orders/orders.dart';
import 'package:table_tap_customer/features/products/products.dart';

final goRouterProvider = GoRouter(
  initialLocation: '/',
  // refreshListenable: goRouterNotifier,
  routes: [
    ///* Primera pantalla
    // GoRoute(
    //   path: '/splash',
    //   builder: (context, state) => const CheckAuthStatusScreen(),
    // ),

    ///* Auth Routes
    // GoRoute(
    //   path: '/login',
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   path: '/register',
    //   builder: (context, state) => const RegisterScreen(),
    // ),

    // ///* Product Routes
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: "/product", // /product/new
      builder: (context, state) => const ProductScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
    GoRoute(
      path: "/order", // /product/new
      builder: (context, state) => const OrderScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
  ],
);
