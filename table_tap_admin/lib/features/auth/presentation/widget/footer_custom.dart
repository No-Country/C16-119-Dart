import 'package:flutter/material.dart';

class FooterCustom extends StatelessWidget {
  final String etiqueta;
  final String tituloButton;
  final VoidCallback onpress;

  const FooterCustom({
    Key? key,
    required this.etiqueta,
    required this.tituloButton,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            etiqueta,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextButton(
            onPressed: onpress,
            child: Text(
              tituloButton,
            ),
          )
        ],
      ),
    );
  }
}
