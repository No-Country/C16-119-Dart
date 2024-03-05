import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/config/functions/message_customer.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/auth/domain/model/account_model.dart';
import 'package:table_tap_admin/features/auth/domain/model/user_model.dart';
import 'package:table_tap_admin/features/auth/infraestructure/entities/user_entities.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/auth/presentation/widget/footer_custom.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class UserAddScreen extends ConsumerStatefulWidget {
  const UserAddScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserAddScreenState();
}

class UserAddScreenState extends ConsumerState<UserAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValidationTextForm _validate = ValidationTextForm();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final directionController = TextEditingController();
  final cellPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final rolController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear usuario")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 80.0,
              bottom: 20.0,
            ),
            child: Column(
              children: [
                const HeaderCustomer(
                  title: Constants.userAdd,
                  description: "",
                ),
                buildForm(),
                const SizedBox(height: 40),
                ButtonCustomer(text: "guardar", press: handleSubmitSave),
                const SizedBox(height: 20),
                ButtonCustomer(text: "cancelar", press: handleSubmitDelete),
                isLoading ? const LoadingCustomer() : Container(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Constants.registerlabelPerson,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese nombres",
            icono: Icons.call_to_action_outlined,
            controller: nameController,
            keyboardType: TextInputType.text,
            validator: (value) => _validate.validateName(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese apellidos",
            icono: Icons.call_to_action_outlined,
            controller: lastNameController,
            keyboardType: TextInputType.text,
            validator: (value) => _validate.validateLastName(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese celular",
            icono: Icons.phone,
            controller: cellPhoneController,
            keyboardType: TextInputType.number,
            validator: (value) => _validate.validateLastName(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese direccion",
            icono: Icons.location_on_outlined,
            controller: directionController,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese rol",
            icono: Icons.call_to_action_outlined,
            controller: rolController,
            keyboardType: TextInputType.text,
            validator: (value) => _validate.validateLastName(value),
          ),
          const SizedBox(height: 30),
          Text(
            Constants.registerLabelAccount,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          TextFieldCustom(
            hintText: "Ingrese correo",
            icono: Icons.email_outlined,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validate.validateEmail(value),
          ),
        ],
      ),
    );
  }

  handleSubmitDelete() {
    nameController.clear();
    lastNameController.clear();
    directionController.clear();
    cellPhoneController.clear();
    emailController.clear();
    rolController.clear();
  }

  handleSubmitSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final authRepository = ref.watch(authRepositoryProvider);
        final preferenceRepository = ref.watch(sharedPrefRepoProvider);
        final userNotifier = ref.watch(usuarioProvider.notifier);
        final usuario = UserModel(
          name: nameController.text,
          lastName: lastNameController.text,
          celPhone: cellPhoneController.text,
          direction: directionController.text,
          rol: directionController.text,
        );

        final cuenta = AccountModel(
          email: emailController.text,
          password: "*hSTTS//#32",
        );

        final recuest = UserEntity(user: usuario, account: cuenta);

        final response = await authRepository.register(recuest);
        if (response.success!) {
          preferenceRepository.setAccessToken(
            response.account!.token!,
            response.user!.id!,
          );
          userNotifier.update(response);
          handleSubmitDelete();
          messageDialogSucces(context, "Se creo con exito", "");
        } else {
          messageDialogError(context, "No se pudo registrar el usuario", "");
        }
      } catch (error) {
        messageDialogError(context, error.toString(), "");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
