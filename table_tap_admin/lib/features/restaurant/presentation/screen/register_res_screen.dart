import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/validate/validation_text.dart';
import 'package:table_tap_admin/features/auth/presentation/riverpod/provider.dart';
import 'package:table_tap_admin/features/restaurant/domain/models/resturantModel.dart';
import 'package:table_tap_admin/features/restaurant/presentation/riverpod/riverpod.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
import 'package:table_tap_admin/features/shared/widgets/header_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class RegisterResScreen extends ConsumerStatefulWidget {
  RegisterResScreen({super.key});

  @override
  ConsumerState<RegisterResScreen> createState() => _RegisterResScreenState();
}

class _RegisterResScreenState extends ConsumerState<RegisterResScreen> {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderCustomer(
                  title: 'Restaurante',
                  description: 'Formulario de informacion del restaurante.',
                ),
                buildForm(),
                 const SizedBox(height: 20),
                isLoading ? const LoadingCustomer() : Container(),
                const SizedBox(height: 20),
                ButtonCustomer(
                  text: "Continue",
                  press: handleSubmit,
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
        ],
      ),
    );
  }

  handleSubmit() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final userProvider = ref.watch(usuarioProvider.notifier);
        final user = userProvider.state!.user;

        final address = addresController.text;
        final cellphone = cellPhoneController.text;
        final responsibleId = user!.id;
        final name = nameController.text;
        final rut = rutController.text;

        final restaurant = RestaurantModel(
          address: address,
          cellphone: cellphone,
          responsibleId: responsibleId,
          name: name,
          rut: rut,
        );

        final restaurantAsyc = ref.read(restaurantProvider.notifier);
        await restaurantAsyc.addRestaurant(restaurant);
        messageDialogSucces(context, "Se creo con exito el restaurante", "");
      }
  
    } catch (e) {
      messageDialogError(context, "Error al crear restaurante", "");
    } finally {
      setState(() {
           isLoading=false;

      });
    }
  }
}
