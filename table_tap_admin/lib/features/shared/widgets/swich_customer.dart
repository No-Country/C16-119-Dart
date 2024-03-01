import 'package:flutter/material.dart';

class SwichCustomer extends StatefulWidget {
  final bool available;
  final String title;
  final VoidCallback onChange;

  const SwichCustomer({
    Key? key,
    required this.available,
    required this.onChange,
    required this.title,
  }) : super(key: key);

  @override
  State<SwichCustomer> createState() => _SwichCustomerState();
}

class _SwichCustomerState extends State<SwichCustomer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Switch(
          value: widget.available,
          onChanged: (value) {
            setState(() {
              widget.onChange();
            });
          },
        ),
      ],
    );
  }
}
