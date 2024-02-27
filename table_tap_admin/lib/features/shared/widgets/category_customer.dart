import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';

class CategoryCustomer extends StatefulWidget {
  final List<String> categories;
  final Function(String) onCategorySelected; // Actualizada a Function(String)
  final int indexSelected;

  const CategoryCustomer({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    required this.indexSelected,
  }) : super(key: key);

  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryCustomer> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.categories.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.onCategorySelected(widget.categories[index]);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                color: selectedIndex == index
                    ? colorSecondary
                    : colorTerciario.withOpacity(0.2),
              ),
              child: Text(
                widget.categories[index],
                style: TextStyle(
                  color: selectedIndex == index ? colorPrincipal : colorPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
