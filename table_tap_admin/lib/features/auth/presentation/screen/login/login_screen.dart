import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

import '../../../../../config/constants/constans.dart';
import '../../../../../config/validate/validation_text.dart';
import '../../../../shared/widgets/button_customer.dart';
import '../../../../shared/widgets/header_customer.dart';
import '../../../../shared/widgets/loading_customer.dart';
import '../../widget/footer_custom.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final ValidationTextForm _validate = ValidationTextForm();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
            child: Center(
              child: Column(
                children: [
                  const HeaderCustomer(
                    title: Constants.loginTitle,
                    description: Constants.loginDescription,
                  ),
                  buildForm(),
                  const SizedBox(height: 40),
                  ButtonCustomer(
                    text: "Continue",
                    press: handleSubmit,
                  ),
                  isLoading ? const LoadingCustomer() : Container(),
                  FooterCustom(
                    etiqueta: Constants.textNoTengoUnaCuenta,
                    onpress: _navigationRegister,
                    tituloButton: "Registrarse",
                  ),
                ],
              ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldCustom(
            hintText: "Ingrese su correo",
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
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _navigationRecoveryPassword,
                child: Text(
                  Constants.buttonRecuperation,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  handleSubmit() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final sharedPrefRepository = ref.watch(sharedPrefRepoProvider);
    final user = ref.read(usuarioProvider.notifier);

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final response = await authRepository.login(
          emailController.text,
          passwordController.text,
        );

        if (response.success!) {
          sharedPrefRepository.setAccessToken(
            response.account!.token!,
            response.user!.id!,
          );
          user.update(response);
          _navigationHome();
        } else {
          messageDialogError(context, response.errorMessage!, "");
        }
      } catch (e) {
        messageDialogError(context, "Error ${e.toString()}", "");
      } finally {
        isLoading = false;
      }

      setState(() {});
    } else {
      messageDialogError(context, "Error en el servidor", "");
    }
  }

  void _navigationRegister() {
    context.go(RoutesConstants.register);
  }

  void _navigationRecoveryPassword() {
    context.push(RoutesConstants.passwordCodeSendEmail);
  }

  void _navigationHome() {
    context.go(RoutesConstants.home);
  }
}
