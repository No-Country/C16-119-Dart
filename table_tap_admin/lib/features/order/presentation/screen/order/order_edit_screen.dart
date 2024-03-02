import 'package:flutter/material.dart';

class OrderEditScreen extends StatelessWidget {
  final String order;
  const OrderEditScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Text("Editando orden"),
    );
  }
}
