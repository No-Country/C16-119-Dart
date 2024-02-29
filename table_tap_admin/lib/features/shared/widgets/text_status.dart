import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/theme.dart';

class TextStatusCustomer extends StatelessWidget {
  final bool status;

  const TextStatusCustomer({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: status ? colorSecondary : colorTerciario,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20.0,
        ),
        child: Text(
          status ? 'Activo' : 'Desactivado',
          style: const TextStyle(color: colorPrincipal),
        ),
      ),
    );
  }
}
