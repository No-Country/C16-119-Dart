import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';
import 'package:table_tap_admin/features/product/presentation/screen/category/category_edit_modal.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: colorSecondary, width: 1),
      ),
      child: InkWell(
        onTap: () {
          _showEditCategoryModal(context, category.id!);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
               const   SizedBox(height: 4),
                  Text(
                    'Estado: ${category.status! ? 'Activo' : 'Inactivo'}',
                    style: TextStyle(
                      color: category.status! ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditCategoryModal(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CategoryEditModal(id),
          ),
        );
      },
    );
  }

}
