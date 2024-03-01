import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/select_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class RegisterResScreen extends StatefulWidget {
  RegisterResScreen({super.key});

  @override
  State<RegisterResScreen> createState() => _RegisterResScreenState();
}

class _RegisterResScreenState extends State<RegisterResScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValidationTextForm validate = ValidationTextForm();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addresController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();
  final TextEditingController rutController = TextEditingController();

  final TextEditingController hourOpenController = TextEditingController();
  final TextEditingController hourCloseController = TextEditingController();

  bool isLoading = false;
  final List<String> customers = ['Seleccione', 'Active', 'Desactive'];

  void onChanged(String? value) {
    print('Cliente seleccionado: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
          child: Column(
            children: [
              const HeaderCustomer(
                title: 'Restaurante',
                description: 'Formulario de informacion del restaurante.',
              ),
              buildForm(),
              const SizedBox(height: 40),
              ButtonCustomer(
                text: "Continue",
                press: handleSubmit,
              ),
              isLoading ? const LoadingCustomer() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldCustom(
            controller: nameController,
            icono: Icons.call_to_action_sharp,
            hintText: 'Ingrese el nombre',
            keyboardType: TextInputType.text,
            validator: (value) => validate.validateIsTextEmpity(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            controller: addresController,
            icono: Icons.call_to_action_sharp,
            hintText: 'Ingrese direccion',
            keyboardType: TextInputType.text,
            validator: (value) => validate.validateIsTextEmpity(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            icono: Icons.phone,
            controller: cellPhoneController,
            hintText: 'Ingrese celular',
            keyboardType: TextInputType.phone,
            validator: (value) => validate.validateIsTextEmpity(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            icono: Icons.call_to_action_sharp,
            controller: rutController,
            hintText: 'Ingrese ruth',
            keyboardType: TextInputType.text,
            validator: (value) => validate.validateIsTextEmpity(value),
          ),
          const SizedBox(height: 15),
       
       /**
           SelectCustomer(
            icono: Icons.tiktok,
            options: customers,
            initialValue: 'Seleccione',
            onChanged: onChanged,
          ),
       * 

        */
          isLoading ? const LoadingCustomer() : Container(),
        ],
      ),
    );
  }

  handleSubmit() {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
      }
      setState(() {
        !isLoading;
      });
    } catch (e) {
    } finally {
      setState(() {
        !isLoading;
      });
    }
  }
}
