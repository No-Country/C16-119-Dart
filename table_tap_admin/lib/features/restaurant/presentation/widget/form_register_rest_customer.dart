import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/validate/validations.dart';

class FormRegisterRestCustomer extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Validate validate = Validate();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addresController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();
  final TextEditingController RutController = TextEditingController();

  FormRegisterRestCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
