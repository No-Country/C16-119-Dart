import 'package:flutter/material.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';

class DetailsRestScreen extends StatelessWidget {
  const DetailsRestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const HeaderCustomer(title: 'Restaurante', description: ''),
                buildMapa(),
                buildDetail(context),
                buildInfo(context,
                    'Un acogedor café urbano que ofrece una deliciosa fusión de cocina internacional con ingredientes locales frescos.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMapa() {
    return Image.asset('assets/images/mapa.png');
  }

  Widget buildDetail(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        cardDetails(Icons.location_on_outlined, 'Cordoba', 'Colombia'),
        const SizedBox(height: 20),
        cardDetails(Icons.access_time_sharp, 'Hora', '10 AM - 10 PM'),
        const SizedBox(height: 20),
        cardDetails(
            Icons.access_time_sharp, 'Numero Telefono', '+57 312777777'),
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(icono, size: 30),
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(10)),
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
