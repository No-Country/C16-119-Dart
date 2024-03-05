import 'package:flutter/material.dart';

class ListEmptyCustomer extends StatelessWidget {
  final String message;

  const ListEmptyCustomer({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
