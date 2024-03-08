import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/users/domain/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    Key? key,
    required this.user,
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
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 32,
                        color: user.rol == "admin"
                            ? Colors.green
                            : Colors.blue.withOpacity(0.7),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name} ${user.lastName}',
                          ),
                          Text(
                            "${user.celPhone?.isEmpty ?? "No registra cel"}",
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${user.rol!.isEmpty ? "Empleado" : user.rol}',
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
