import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/auth/infraestructure/entities/response_recovery.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class RecoveryScreen extends ConsumerStatefulWidget {
  const RecoveryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RecoveryScreenState();
}

class RecoveryScreenState extends ConsumerState<RecoveryScreen> {
  final _formKey = GlobalKey<FormState>();

  final ValidationTextForm _validate = ValidationTextForm();
  final emailcontroller = TextEditingController();
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
                Text(
                  Constants.recoveryTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5.0),
                Text(
                  Constants.recoveryDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldCustom(
                        icono: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        hintText: "Ingrese su email",
                        validator: (value) => _validate.validateEmail(value),
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

  void _goVerifyCode() {
    context.push(RoutesConstants.passwordVerifyCode);
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
        String email = emailcontroller.text;
        final authRepo = ref.watch(authRepositoryProvider);
        final recovery = ref.read(recoveryUserProvider.notifier);
        // envia el codigo al correo
        await authRepo.sendCodeEmail(email);
        // guardar en el provider el email
        recovery.state = ResponseRecovery(email: email);
        // envia a verificar codigo
        _goVerifyCode();
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
