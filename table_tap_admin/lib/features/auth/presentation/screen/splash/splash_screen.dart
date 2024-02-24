import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/infraestructure/entities/user_entities.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/auth/presentation/widget/logo_animado_customer.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    Future.delayed(const Duration(seconds: 5), () => _inicioSesion());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _inicioSesion() async {
    final pref = ref.read(sharedPrefRepoProvider);
    final auth = ref.read(authRepositoryProvider);
    final user = ref.read(usuarioProvider.notifier);

    final idIsEmpty = await pref.hasActiveSession();

    if (idIsEmpty != null) {
      final UserEntity usuario = await auth.userById(idIsEmpty);
      user.update(usuario);
    }
    final route =
        idIsEmpty != null ? RoutesConstants.home : RoutesConstants.login;
    _navigation(route);
  }

  void _navigation(final route) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoAnimadoCustomer(controller: _controller),
              Text(
                Constants.splashTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Text(
                Constants.splashDescription,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
