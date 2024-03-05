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
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class UserEditScreen extends ConsumerStatefulWidget {
  final String userId;
  const UserEditScreen({Key? key, required this.userId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserAdddScreenState();
}

class UserAdddScreenState extends ConsumerState<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValidationTextForm _validate = ValidationTextForm();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  title: Constants.recoveryTitle,
                  description: Constants.registerTitle,
                ),
                buildForm(),
                const SizedBox(height: 40),
                ButtonCustomer(text: "Continue", press: handleSubmit),
                isLoading ? const LoadingCustomer() : Container(),
                FooterCustom(
                  etiqueta: Constants.textTengoUnaCuenta,
                  onpress: _navigationLogin,
                  tituloButton: "aqui",
                ),
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
          const SizedBox(height: 10),
          TextFieldCustom(
            hintText: "Ingrese nombres",
            icono: Icons.call_to_action_rounded,
            controller: nameController,
            keyboardType: TextInputType.text,
            validator: (value) => _validate.validateName(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese apellidos",
            icono: Icons.call_to_action_rounded,
            controller: lastNameController,
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
            icono: Icons.email,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validate.validateEmail(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Ingrese clave",
            icono: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            validator: (value) => _validate.validatePassword(value),
          ),
          const SizedBox(height: 15),
          TextFieldCustom(
            hintText: "Confirme clave",
            icono: Icons.lock,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: passwordConfController,
            validator: (value) => _validate.validatePasswordConfirmation(
              value,
              passwordController.text,
            ),
          ),
        ],
      ),
    );
  }

  void _navigationLogin() {
    context.go(RoutesConstants.login);
  }

  void _navigationHome() {
    context.go(RoutesConstants.home);
  }

  handleSubmit() async {
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
          celPhone: '',
          direction: '',
          rol: '',
        );

        final cuenta = AccountModel(
          email: emailController.text,
          password: passwordController.text,
        );

        final recuest = UserEntity(user: usuario, account: cuenta);

        final response = await authRepository.register(recuest);
        if (response.success!) {
          preferenceRepository.setAccessToken(
            response.account!.token!,
            response.user!.id!,
          );
          userNotifier.update(response);
          _navigationHome();
        } else {
          MessageSnackBar.show(context, "${response.errorMessage}");
        }
      } catch (error) {
        MessageSnackBar.show(context, "${error.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
