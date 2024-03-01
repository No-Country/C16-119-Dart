import 'package:flutter/material.dart';

enum MenuState { home, favourite, message, profile }

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0x151E3D),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Column(
              children: [
                const Icon(Icons.all_inbox),
                Text("Todos")
              ],
            ),onPressed: () {}),
            IconButton(icon: const Icon(Icons.pending), onPressed: () {}),
            IconButton(icon: const Icon(Icons.filter_alt_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.filter_alt_outlined), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
