import 'package:flutter/material.dart';

class HeaderCustomer extends StatelessWidget {
  final String title;
  final String description;
  const HeaderCustomer({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 5.0),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
