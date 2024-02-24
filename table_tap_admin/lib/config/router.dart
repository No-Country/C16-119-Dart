import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/features/products/products.dart';
// List routes = ["/product"];
// Map<String, String> routes2 = {"product" : "/product"};
// enum Routes {as}
final goRouterProvider = GoRouter(
  initialLocation: '/product',
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
      // path: '/product/:id', // /product/new
      builder: (context, state) => ProductScreen(
          // productId: state.params['id'] ?? 'no-id',
          ),
    ),
  ],
);
