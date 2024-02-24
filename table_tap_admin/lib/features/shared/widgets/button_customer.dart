import 'package:flutter/material.dart';

class ButtonCustomer extends StatelessWidget {
  const ButtonCustomer({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: press as void Function()?,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Text(text!, style: Theme.of(context).textTheme.labelSmall),
        ),
      ),
    );
  }
}
