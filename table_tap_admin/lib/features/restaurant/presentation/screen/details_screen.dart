import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';
import 'package:table_tap_admin/features/restaurant/presentation/riverpod/riverpod.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';

class DetailsRestScreen extends ConsumerWidget {
  const DetailsRestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final restaurant = ref.watch(restaurantProvider).value!.first;

    return restaurant == null
        ? const Center(child: Text("No hay detos que mostrar"))
        : Scaffold(
            appBar: AppBar(
              title: Text(restaurant.name!),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const HeaderCustomer(
                          title: 'Restaurante', description: ''),
                      buildMapa(),
                      buildDetail(context, restaurant),
                      buildInfo(context,
                          'Un acogedor café urbano que ofrece una deliciosa fusión de cocina internacional con ingredientes locales frescos.'),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorSecondary),
                child: IconButton(
                    onPressed: () {
                      context.push(RoutesConstants.restaurant_edit);
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 35,
                    )),
              ),
            ),
          );
  }

  Widget buildMapa() {
    return Image.asset('assets/images/mapa.png');
  }

  Widget buildDetail(BuildContext context, RestaurantModel restaurant) {
    return Column(
      children: [
        const SizedBox(height: 20),
        cardDetails(
            Icons.location_on_outlined, '${restaurant.address}', 'Cordoba'),
        const SizedBox(height: 20),
        cardDetails(Icons.access_time_sharp, 'Hora', '10 AM - 10 PM'),
        const SizedBox(height: 20),
        cardDetails(Icons.access_time_sharp, 'Numero Telefono',
            '${restaurant.cellphone}'),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget buildInfo(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Acerca del restaurante",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget cardDetails(IconData icono, String direccion, String ciudad) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(icono, size: 30),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                direccion,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(ciudad),
            ],
          ),
        ),
      ],
    );
  }
}
