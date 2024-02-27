import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class ChangeScreen extends ConsumerStatefulWidget {
  const ChangeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ChangeScreenState();
}

class ChangeScreenState extends ConsumerState<ChangeScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValidationTextForm _validate = ValidationTextForm();
  final passwordcontroller = TextEditingController();
  final passwordConfcontroller = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeaderCustomer(
                  title: Constants.changeTitle,
                  description: Constants.changeDescription,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldCustom(
                        icono: Icons.email,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordcontroller,
                        hintText: "Ingrese su clave",
                        validator: (value) => _validate.validatePassword(value),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldCustom(
                        icono: Icons.email,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordConfcontroller,
                        hintText: "confirme su clave",
                        validator: (value) =>
                            _validate.validatePasswordConfirmation(
                          value,
                          passwordcontroller.text,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 30.0),
                      ButtonCustomer(
                        text: "continue",
                        press: handleSubmit,
                      ),
                      isLoading ? const LoadingCustomer() : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goLogin() {
    context.go(RoutesConstants.login);
  }

  void _buidMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final authRepo = ref.watch(authRepositoryProvider);
        final recover = ref.watch(recoveryUserProvider);
        final response = await authRepo.changePassword(
          "${recover!.code}",
          passwordcontroller.text,
        );
        if (response) {
          _goLogin();
        }
      } catch (error) {
        _buidMessage("Se encontro un error ${error.toString()}");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
