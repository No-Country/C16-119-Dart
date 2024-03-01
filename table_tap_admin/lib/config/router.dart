import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/login/login_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/change_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/recovery_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/verify_code_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/register/register_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/splash/splash_screen.dart';
import 'package:table_tap_admin/features/home/presentation/screen/home_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_edit_modal.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_details_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_edit_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_register_screen.dart';
import 'package:table_tap_admin/features/product/presentation/screen/product/product_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/details_screen.dart';
import 'package:table_tap_admin/features/restaurant/presentation/screen/register_res_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_details_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_register_screen.dart';
import 'package:table_tap_admin/features/table/presentation/screen/table_screen.dart';

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
        final String id = (extra as Map<String, dynamic>)['id'] ?? '';
        return const TableDetailsScreen();
      },
    ),
    GoRoute(
      path: RoutesConstants.tableAdd,
      builder: (context, state) => const TableRegisterScreen(),
    ),
  ],
);
