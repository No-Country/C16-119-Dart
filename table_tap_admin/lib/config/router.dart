import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/login/login_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/change_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/recovery_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/password/verify_code_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/register/register_screen.dart';
import 'package:table_tap_admin/features/auth/presentation/screen/splash/splash_screen.dart';
import 'package:table_tap_admin/features/home/presentation/screen/home_screen.dart';

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
  ],
);
