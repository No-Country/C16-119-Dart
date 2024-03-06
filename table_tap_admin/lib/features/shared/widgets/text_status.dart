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
    return Text(
      status ? 'Activo' : 'Desactivado',
      style: TextStyle(
        color: status ? Colors.green : Colors.black.withOpacity(5),
      ),
    );
  }
}
