import 'package:flutter/material.dart';

class SwichCustomer extends StatefulWidget {
  final bool isActive;
  final VoidCallback onChange;

  const SwichCustomer({
    Key? key,
    required this.isActive,
    required this.onChange,
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
        const Text('Estado'),
        Switch(
          value: widget.isActive,
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
