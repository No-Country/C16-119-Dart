import 'package:flutter/material.dart';

class LoadingCustomer extends StatelessWidget {
  const LoadingCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ],
    );
  }
}
