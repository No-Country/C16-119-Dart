import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';

class LogoAnimadoCustomer extends StatelessWidget {
  final AnimationController controller;

  const LogoAnimadoCustomer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2.0 * 3.14,
          child: Image.asset(
            Constants.splashImage,
            height: 300,
          ),
        );
      },
    );
  }
}
