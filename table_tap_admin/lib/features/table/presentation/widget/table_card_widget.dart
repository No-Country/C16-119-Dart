import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';

class TableCardWidget extends StatelessWidget {
  final TableModel table;
  final String availableText;
  final Color statusColor;

  const TableCardWidget({
    Key? key,
    required this.table,
    required this.availableText,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: colorPrincipal,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.push(
            RoutesConstants.tableDetail,
            extra: {"id": table.id},
          );
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
                    "Mesa # ${table.number}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    availableText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.edit, color: colorSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
