import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/login/login_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/change_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/recovery_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/verify_code_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/register/register_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/splash/splash_screen.dart';
import 'package:table_tap_admin/features/home/presentation/screen/home_screen.dart';
import 'package:table_tap_admin/features/order/presentation/screen/order/order_details_screen.dart';
import 'package:table_tap_admin/features/order/presentation/screen/order/order_edit_screen.dart';
import 'package:table_tap_admin/features/order/presentation/screen/order/order_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_edit_modal.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_details_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_edit_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_register_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/details_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/register_res_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/resturant_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_details_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_edit_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_register_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_screen.dart';
import 'package:table_tap_admin/features/users/presentation/screen/user/user_add_screen.dart';
import 'package:table_tap_admin/features/users/presentation/screen/user/user_detail_screen.dart';
import 'package:table_tap_admin/features/users/presentation/screen/user/user_edit_screen.dart';
import 'package:table_tap_admin/features/users/presentation/screen/user/user_screen.dart';

final goRouterProvider = GoRouter(
  initialLocation: RoutesConstants.splash,
  routes: [
    GoRoute(
      path: RoutesConstants.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutesConstants.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutesConstants.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RoutesConstants.passwordCodeSendEmail,
      builder: (context, state) => const RecoveryScreen(),
    ),
    GoRoute(
      path: RoutesConstants.passwordVerifyCode,
      builder: (context, state) => const VerifyCodeScreen(),
    ),
    GoRoute(
      path: RoutesConstants.passwordChange,
      builder: (context, state) => const ChangeScreen(),
    ),
    GoRoute(
      path: RoutesConstants.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RoutesConstants.restaurant,
      builder: (context, state) => const RestaurantScreen(),
    ),
    GoRoute(
      path: RoutesConstants.restaurant_register,
      builder: (context, state) => RegisterResScreen(),
    ),
    GoRoute(
      path: RoutesConstants.restaurant_details,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String id = (extra as Map<String, dynamic>)['id'] ?? '';
        return const DetailsRestScreen();
      },
    ),
    GoRoute(
      path: RoutesConstants.products,
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: RoutesConstants.productAdd,
      builder: (context, state) => const ProductAddScreen(),
    ),
    GoRoute(
      path: RoutesConstants.productDetail,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String productId = (extra as Map<String, dynamic>)['id'] ?? '';
        return ProductDetailsScreen(productIds: productId);
      },
    ),
    GoRoute(
      path: RoutesConstants.productEdit,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String productId = (extra as Map<String, dynamic>)['id'] ?? '';
        return ProductEditScreen(productId: productId);
      },
    ),
    GoRoute(
      path: RoutesConstants.categories,
      builder: (context, state) => const CategoryScreen(),
    ),
    GoRoute(
      path: RoutesConstants.tables,
      builder: (context, state) => const TableScreen(),
    ),
    GoRoute(
      path: RoutesConstants.tableDetail,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String tableId = (extra as Map<String, dynamic>)['id'] ?? '';
        return TableDetailsScreen(tableId: tableId);
      },
    ),
    GoRoute(
      path: RoutesConstants.tableEdit,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String tableId = (extra as Map<String, dynamic>)['id'] ?? '';
        return TableEditScreen(tableId: tableId);
      },
    ),
    GoRoute(
      path: RoutesConstants.tableAdd,
      builder: (context, state) => const TableRegisterScreen(),
    ),
    GoRoute(
      path: RoutesConstants.orders,
      builder: (context, state) => OrderScreen(),
    ),
    GoRoute(
      path: RoutesConstants.orderDetail,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String orderId = (extra as Map<String, dynamic>)['id'] ?? '';
        return OrderDetailScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: RoutesConstants.orderEdit,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String orderId = (extra as Map<String, dynamic>)['id'] ?? '';
        return OrderEditScreen(order: orderId);
      },
    ),
    GoRoute(
      path: RoutesConstants.users,
      builder: (context, state) {
        return const UserScreen();
      },
    ),
    GoRoute(
      path: RoutesConstants.userAdd,
      builder: (context, state) {
        return const UserAddScreen();
      },
    ),
    GoRoute(
      path: RoutesConstants.userDetail,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String userId = (extra as Map<String, dynamic>)['id'] ?? '';
        return UserDetailScreen(userId: userId);
      },
    ),
    GoRoute(
      path: RoutesConstants.userEdit,
      builder: (context, state) {
        final Object? extra = state.extra;
        final String userId = (extra as Map<String, dynamic>)['id'] ?? '';
        return UserEditScreen(userId:userId);
      },
    ),
  ],
);
