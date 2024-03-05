import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';

class QrDetailsWidget extends StatelessWidget {
  final TableModel table;
  const QrDetailsWidget({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        QrImageView(
          data: table.id!,
          backgroundColor: Colors.white,
          version: QrVersions.auto,
          size: 300.0,
        ),
        const SizedBox(height: 20),
        Text("Id ${table.id}"),
        Text("Mesa ${table.number}"),
        Text("Estado ${table.available! ? 'Disponible' : 'Ocupado'}"),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: colorSecondary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: handleDowunload,
                  icon: const Icon(
                    Icons.download,
                    color: colorPrincipal,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  handleDowunload() {
    print("Descargando el codigo");
  }
}
