import 'package:flutter/material.dart';
import 'package:table_tap_admin/features/auth/domain/model/user_model.dart';

class ProfileWidget extends StatelessWidget {
  final UserModel user;
  const ProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.account_circle, color: Colors.white, size: 50),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name, style: Theme.of(context).textTheme.bodySmall),
              Text(user.lastName, style: Theme.of(context).textTheme.bodySmall),
              Text("${user.rol}", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
