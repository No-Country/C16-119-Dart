import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/config/constants/routes_constant.dart';
import 'package:table_tap_admin/features/auth/infraestructure/entities/response_recovery.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/auth/presentation/widget/textfield_one_digits_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';

class VerifyCodeScreen extends ConsumerStatefulWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecuerpationPasswordScreenState();
}

class _RecuerpationPasswordScreenState extends ConsumerState<VerifyCodeScreen> {
  final _formKey = GlobalKey<FormState>();

  final numberOneController = TextEditingController();
  final numberTwoController = TextEditingController();
  final numberThreeController = TextEditingController();
  final numberFourController = TextEditingController();
  final numberFiveController = TextEditingController();
  bool isButtonNewCode = false;
  bool isLoading = false;
  int minutos = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeaderCustomer(
                title: Constants.verifyTitle,
                description: Constants.verifyDescription,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildContainer(numberOneController),
                        buildContainer(numberTwoController),
                        buildContainer(numberThreeController),
                        buildContainer(numberFourController),
                        buildContainer(numberFiveController),
                      ],
                    ),
                    const SizedBox(height: 50.0),
                    buildTimer(),
                    const SizedBox(height: 30.0),
                    ButtonCustomer(
                      text: "continue",
                      press: handleSubmitValidate,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget buildContainer(TextEditingController controller) {
    return SizedBox(
      height:60,
      width: 60,
      child: TextFieldOneDigitsCustom(controller: controller),
    );
  }

  Row buildTimer() {
    const minutos = 10;
    const tiempoTotalSegundos = 60 * minutos;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("codigo expirando en : "),
        TweenAnimationBuilder(
          tween: Tween(begin: tiempoTotalSegundos.toDouble(), end: 0.0),
          duration: const Duration(seconds: tiempoTotalSegundos),
          builder: (_, dynamic value, child) {
            final minutosRestantes = (value ~/ 60).toString().padLeft(2, '0');
            final segundosRestantes =
                (value % 60).toInt().toString().padLeft(2, '0');
            return Text(
              "$minutosRestantes:$segundosRestantes",
              style: const TextStyle(
                color: Colors.blue,
              ),
            );
          },
        ),
      ],
    );
  }

  void _buidMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _goChangePassword() {
    context.push(RoutesConstants.passwordChange);
  }

  handleSubmitValidate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final authRepository = ref.watch(authRepositoryProvider);
        final recovery = ref.read(recoveryUserProvider.notifier);

        String codigo = numberOneController.text +
            numberTwoController.text +
            numberThreeController.text +
            numberFourController.text;
            numberFiveController.text;
        bool isCorrect = await authRepository.verifyCodePass(codigo);
        if (isCorrect) {
          recovery.state = ResponseRecovery(code: codigo);
          _goChangePassword();
        } else {
          _buidMessage("Codigo no valido");
        }
      } catch (error) {
        _buidMessage("Error en el servidor");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
