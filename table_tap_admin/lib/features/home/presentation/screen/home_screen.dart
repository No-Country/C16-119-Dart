import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool cargando = false;

  @override
  Widget build(BuildContext context) {
    final usuario = ref.watch(usuarioProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("nombre ${usuario?.user?.name ?? ''}"),
            Text("Apellido ${usuario?.user?.lastName ?? ''}"),
            Text("rol ${usuario?.user?.rol ?? ''}"),
            Text("correo ${usuario?.account?.email ?? ''}"),
            ButtonCustomer(
              text: 'cerrar sesion',
              press: () => {handleCloseSession(context)},
            ),
            cargando ? const LoadingCustomer() : Container(),
            const SizedBox(height: 20),
            ButtonCustomer(
              text: 'Modulo productos',
              press: () => (context.push(RoutesConstants.products)),
            ),
            const SizedBox(height: 20),
            ButtonCustomer(
              text: 'Modulo restaurante',
              press: () => (context.push(RoutesConstants.restaurant_details)),
            ),
            const SizedBox(height: 20),
            ButtonCustomer(
              text: 'Modulo mesa',
              press: () => (context.push(RoutesConstants.tables)),
            ),
            const SizedBox(height: 20),
            ButtonCustomer(
              text: 'Modulo ordenes',
              press: () => (context.push(RoutesConstants.restaurant_details)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  handleCloseSession(BuildContext context) async {
    final usuario = ref.read(usuarioProvider.notifier);
    try {
      setState(() {
        cargando = true;
      });
      await usuario.logout();
      nagigatorLogin();
    } catch (error) {
      _buidMessage(error.toString());
    } finally {
      setState(() {
        cargando = false;
      });
    }
  }

  void _buidMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void nagigatorLogin() {
    context.go(RoutesConstants.login);
  }
}
