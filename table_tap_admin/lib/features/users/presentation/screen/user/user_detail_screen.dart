import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Text("Detalles"),
    );
  }
}
